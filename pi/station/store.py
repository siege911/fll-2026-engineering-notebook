"""The Camera Station's memory: photos, visits, and settings in one SQLite file.

A *photo* is one picture from the camera.
A *visit* is one animal (or group) coming by: all the photos of the same
species where each photo is less than `visit_gap_minutes` after the one
before. We count animals per visit, not per photo, so a deer standing in
front of the camera for 40 photos is still one deer.

How many animals in a visit? The most animal boxes the AI found in any
single photo of that visit. (Scientists call this "MaxN": if one photo
shows 3 elk, at least 3 elk came by.)
"""

import sqlite3
import threading
from datetime import datetime, timedelta

SCHEMA = """
CREATE TABLE IF NOT EXISTS photos (
  id          INTEGER PRIMARY KEY,
  file        TEXT UNIQUE,          -- path under the data folder, e.g. photos/2026-10-25/...jpg
  name        TEXT UNIQUE,          -- 2026-10-25_14-03-22_SC.jpg
  taken_at    TEXT,                 -- 2026-10-25 14:03:22 (camera time)
  trigger     TEXT,                 -- S = motion sensor, C = picture changed, SC = both
  received_at TEXT,
  status      TEXT DEFAULT 'waiting', -- waiting -> tagged (or failed)
  result      TEXT,                 -- animal | person | vehicle | empty
  species     TEXT,
  confidence  REAL,
  animals     INTEGER DEFAULT 0,
  people      INTEGER DEFAULT 0,
  vehicles    INTEGER DEFAULT 0,
  visit_id    INTEGER
);
CREATE TABLE IF NOT EXISTS visits (
  id            INTEGER PRIMARY KEY,
  species       TEXT,
  start_at      TEXT,
  end_at        TEXT,
  photo_count   INTEGER DEFAULT 0,
  animal_count  INTEGER DEFAULT 0,  -- most animals seen in one photo (MaxN)
  best_photo_id INTEGER,
  triggers      TEXT,               -- which triggers caught this visit: S, C, SC
  status        TEXT DEFAULT 'review', -- review -> approved -> queued -> published, or hidden
  reviewed_by   TEXT,
  note          TEXT,
  updated_at    TEXT
);
"""

TIME = "%Y-%m-%d %H:%M:%S"


def now():
    return datetime.now().strftime(TIME)


class Store:
    def __init__(self, path):
        self.lock = threading.Lock()
        self.db = sqlite3.connect(path, check_same_thread=False)
        self.db.row_factory = sqlite3.Row
        self.db.executescript(SCHEMA)

    def query(self, sql, args=()):
        with self.lock:
            return [dict(r) for r in self.db.execute(sql, args).fetchall()]

    def run(self, sql, args=()):
        with self.lock:
            cur = self.db.execute(sql, args)
            self.db.commit()
            return cur.lastrowid

    # ---------- photos ----------
    def add_photo(self, file, name, taken_at, trigger):
        return self.run("INSERT OR IGNORE INTO photos (file, name, taken_at, trigger, received_at) VALUES (?,?,?,?,?)",
                        (file, name, taken_at, trigger, now()))

    def waiting_photos(self, limit=50):
        return self.query("SELECT * FROM photos WHERE status = 'waiting' ORDER BY taken_at LIMIT ?", (limit,))

    def save_tags(self, photo_id, tags, file=None):
        self.run("""UPDATE photos SET status='tagged', result=?, species=?, confidence=?, animals=?, people=?, vehicles=?,
                    file=COALESCE(?, file) WHERE id=?""",
                 (tags["result"], tags["species"], tags["confidence"], tags["animals"], tags["people"],
                  tags["vehicles"], file, photo_id))

    def retry_failed(self):
        """Puts set-aside photos back in line for tagging. Returns how many."""
        n = self.query("SELECT COUNT(*) n FROM photos WHERE status='failed'")[0]["n"]
        self.run("UPDATE photos SET status='waiting' WHERE status='failed'")
        return n

    def mark_failed(self, photo_id):
        self.run("UPDATE photos SET status='failed' WHERE id=?", (photo_id,))

    # ---------- visits ----------
    def add_to_visit(self, photo_id, gap_minutes):
        """Puts a tagged animal photo into a visit: the open visit of the same species
        if it's close enough in time, otherwise a new visit."""
        photo = self.query("SELECT * FROM photos WHERE id=?", (photo_id,))[0]
        taken = datetime.strptime(photo["taken_at"], TIME)
        window_start = (taken - timedelta(minutes=gap_minutes)).strftime(TIME)
        window_end = (taken + timedelta(minutes=gap_minutes)).strftime(TIME)
        match = self.query("""SELECT * FROM visits WHERE species = ? AND status = 'review'
                              AND end_at >= ? AND start_at <= ? ORDER BY end_at DESC LIMIT 1""",
                           (photo["species"], window_start, window_end))
        if match:
            visit_id = match[0]["id"]
        else:
            visit_id = self.run("INSERT INTO visits (species, start_at, end_at, updated_at) VALUES (?,?,?,?)",
                                (photo["species"], photo["taken_at"], photo["taken_at"], now()))
        self.run("UPDATE photos SET visit_id=? WHERE id=?", (visit_id, photo_id))
        self.refresh_visit(visit_id)
        return visit_id

    def refresh_visit(self, visit_id):
        """Recounts a visit from its photos."""
        photos = self.query("SELECT * FROM photos WHERE visit_id=? ORDER BY taken_at", (visit_id,))
        if not photos:
            self.run("DELETE FROM visits WHERE id=?", (visit_id,))
            return
        best = max(photos, key=lambda p: (p["animals"], p["confidence"] or 0))
        triggers = set("".join(p["trigger"] for p in photos))
        visit = self.query("SELECT best_photo_id FROM visits WHERE id=?", (visit_id,))[0]
        chosen = visit["best_photo_id"] if any(p["id"] == visit["best_photo_id"] for p in photos) else best["id"]
        self.run("""UPDATE visits SET start_at=?, end_at=?, photo_count=?, animal_count=MAX(?, COALESCE(animal_count,0)),
                    best_photo_id=?, triggers=?, updated_at=? WHERE id=?""",
                 (photos[0]["taken_at"], photos[-1]["taken_at"], len(photos), max(p["animals"] for p in photos),
                  chosen, "".join(t for t in "SC" if t in triggers), now(), visit_id))

    def merge_with_previous(self, visit_id):
        """The students say 'this is the same animal as the visit before': join them."""
        visit = self.query("SELECT * FROM visits WHERE id=?", (visit_id,))
        if not visit:
            return None
        before = self.query("""SELECT * FROM visits WHERE start_at <= ? AND id != ? AND status IN ('review','approved')
                               ORDER BY start_at DESC LIMIT 1""", (visit[0]["start_at"], visit_id))
        if not before:
            return None
        keep = before[0]["id"]
        self.run("UPDATE photos SET visit_id=? WHERE visit_id=?", (keep, visit_id))
        self.run("DELETE FROM visits WHERE id=?", (visit_id,))
        self.refresh_visit(keep)
        return keep

    def update_visit(self, visit_id, changes):
        allowed = {"species", "animal_count", "best_photo_id", "status", "reviewed_by", "note"}
        fields = {k: v for k, v in changes.items() if k in allowed}
        if not fields:
            return
        sets = ", ".join(f"{k}=?" for k in fields)
        self.run(f"UPDATE visits SET {sets}, updated_at=? WHERE id=?", (*fields.values(), now(), visit_id))
        if "species" in fields:
            self.run("UPDATE photos SET species=? WHERE visit_id=?", (fields["species"], visit_id))
