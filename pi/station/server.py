#!/usr/bin/env python3
"""Rooted Warriors Camera Station — runs on the Raspberry Pi.

  * The camera sends each photo here (POST /api/upload) as soon as it's on
    the Pi's camera Wi-Fi. Photos saved while it was out of range come in
    when it gets back.
  * A background helper tags new photos with SpeciesNet, blurs people, sets
    empty photos aside, and groups animal photos into visits.
  * The touchscreen page (public/index.html) lets the team review visits
    and choose what to publish. Nothing is published automatically.

Start it:   python3 server.py                (real AI, needs SpeciesNet)
Try it:     python3 server.py --fake-ai      (made-up answers, no AI needed)
Then open:  http://localhost:8080
"""

import argparse
import collections
import json
import re
import shutil
import socket
import threading
import time
import traceback
import urllib.parse
import urllib.request
from datetime import datetime
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

import ai
from network import Network
from store import Store, now

HERE = Path(__file__).resolve().parent
# 2026-10-25_14-03-22_SC.jpg, or no-time-123456-789_S.jpg if the camera didn't know the time yet
PHOTO_NAME = re.compile(r"^(?:(\d{4}-\d{2}-\d{2})_(\d{2})-(\d{2})-(\d{2})|no-time-\d+-\d+)_(S|C|SC)\.jpg$")
MAX_UPLOAD = 2 * 1024 * 1024  # a 640x480 picture is about 30-80 KB

DEFAULTS = {
    "camera_key": "",
    "team": ["Thea", "Adeline", "Fynn", "Isla", "Nolan", "Weston"],
    "country": "USA",
    "admin1_region": "AZ",
    "min_confidence": 0.2,
    "visit_gap_minutes": 10,
    "keep_empty_days": 7,
    "port": 8080,
    "speciesnet_python": "",  # e.g. /home/pi/speciesnet-env/bin/python (blank = the Python running this)
    "speciesnet_model": "",
    "tag_batch_size": 5,      # photos per SpeciesNet run (smaller = answers show up sooner, a crash loses less)   # downloaded model folder (blank = find the one the warm-up test downloaded)
    # One Wi-Fi radio? Show the Camera Wi-Fi / House Wi-Fi switch (see pi/NETWORKING.md).
    "wifi_switch": False,
    "camera_connection": "camera-wifi",
    "house_connection": "",  # blank = 🌐 joins any Wi-Fi the Pi remembers that's in range
    "auto_return_minutes": 0,  # 0 = stay in House Wi-Fi mode until someone taps Camera Wi-Fi
}


class Station:
    def __init__(self, data_dir, settings, fake_ai):
        self.data = data_dir
        self.settings = settings
        self.fake_ai = fake_ai
        (self.data / "photos").mkdir(parents=True, exist_ok=True)
        self.store = Store(self.data / "station.db")
        self.camera = {"ip": None, "last_seen": None}
        self.tagging_now = 0
        self.last_error = ""         # the last tagging try failed (cleared when one works)
        self.problems = collections.deque(maxlen=30)  # newest last, for the Problems page
        self.problem_count = 0       # all problems since start-up (the page's badge)
        self.solo = set()            # photo ids from a crashed batch: tag these one per try to find a bad one
        self.tries = {}              # photo id -> failed tries on its own
        self.start_overs = 0         # goes up on "Delete all photos": a tagging batch from before is thrown away
        self._internet = (0, False)
        self.network = Network(settings) if settings["wifi_switch"] else None

    # ---------- photos coming in ----------
    def receive(self, name, body, camera_ip):
        match = PHOTO_NAME.match(name)
        if not match:
            raise ValueError("bad name")
        if not (body.startswith(b"\xff\xd8") and b"\xff\xd9" in body[-16:]):
            raise ValueError("not a whole picture")  # broken on the camera's card: don't hand it to the AI
        day, hh, mm, ss, trigger = match.groups()
        taken_at = f"{day} {hh}:{mm}:{ss}" if day else now()  # no time from the camera: use when it arrived
        rel = f"photos/{taken_at[:10]}/{name}"
        path = self.data / rel
        path.parent.mkdir(parents=True, exist_ok=True)
        temp = path.with_suffix(".part")
        temp.write_bytes(body)
        temp.replace(path)
        self.store.add_photo(rel, name, taken_at, trigger)
        self.seen_camera(camera_ip)

    def seen_camera(self, camera_ip):
        """The camera just talked to us (sent a photo, asked the time, or answered for the Live page)."""
        self.camera = {"ip": camera_ip, "last_seen": now()}

    def live_picture(self):
        """Gets the camera's newest picture for the Live page. The touchscreen only talks to the Pi."""
        ip = self.camera["ip"]
        if not ip:
            raise ConnectionError("The Pi doesn't know the camera's address yet. Restart the camera (press R).")
        with urllib.request.urlopen(f"http://{ip}/picture.jpg", timeout=5) as answer:
            jpg = answer.read()
        self.seen_camera(ip)
        return jpg

    # ---------- the background helper ----------
    def tag_forever(self):
        while True:
            batch = []
            start_overs = self.start_overs
            try:
                size = 1 if self.solo else max(1, int(self.settings.get("tag_batch_size", 5)))
                batch = self.store.waiting_photos(size)
                if self.solo and (not batch or batch[0]["id"] not in self.solo):
                    self.solo.clear()  # the crashed batch is all done (or set aside): back to normal
                    continue
                if batch:
                    self.tag_batch(batch)
                else:
                    self.clean_old_empties()
                    time.sleep(3)
            except Exception as error:
                self.tagging_now = 0
                if start_overs != self.start_overs:
                    continue  # the photos were deleted while the AI was working: not a real problem
                self.tagging_failed(batch, error)
                time.sleep(10)

    def tagging_failed(self, batch, error):
        """A tagging try crashed. Retry the photos one at a time; a photo that
        crashes twice on its own is set aside (Problems page can try it again)."""
        details = traceback.format_exc(limit=3)
        print(details, flush=True)
        self.last_error = details
        what = ai.explain_error(error)
        if len(batch) == 1:
            photo = batch[0]
            self.tries[photo["id"]] = self.tries.get(photo["id"], 0) + 1
            if self.tries[photo["id"]] >= 2:
                self.store.mark_failed(photo["id"])
                self.tries.pop(photo["id"])
                self.solo.discard(photo["id"])
                what += f" Gave up on {photo['name']} after 2 tries."
            else:
                what += f" Trying {photo['name']} once more."
        elif batch:
            self.solo = {p["id"] for p in batch}
            what += f" Trying those {len(batch)} photos one at a time."
        self.add_problem(what, details)

    def add_problem(self, what, details=""):
        self.problems.append({"time": now(), "what": what, "details": details})
        self.problem_count += 1

    def retry_failed(self):
        n = self.store.retry_failed()
        if n:
            self.add_problem(f"Trying {n} set-aside photo{'s' if n != 1 else ''} again (someone tapped Try again).")
        return n

    def delete_all_photos(self):
        """Start over: deletes every photo (and the empty ones) and every visit.
        A tagging batch that's running right now finishes, and its answers are thrown away."""
        self.start_overs += 1
        counts = self.store.delete_everything()
        for folder in ("photos", "empty"):
            shutil.rmtree(self.data / folder, ignore_errors=True)
        (self.data / "photos").mkdir(parents=True, exist_ok=True)
        self.solo.clear()
        self.tries.clear()
        self.problems.clear()
        self.last_error = ""
        self.add_problem(f"Started over: deleted {counts['photos']} photo{'s' if counts['photos'] != 1 else ''} "
                         f"and {counts['visits']} visit{'s' if counts['visits'] != 1 else ''} (someone tapped Delete all photos).")
        return counts

    def tag_batch(self, batch):
        start_overs = self.start_overs
        self.tagging_now = len(batch)
        paths = [self.data / p["file"] for p in batch]
        if self.fake_ai:
            time.sleep(1)
            predictions = ai.fake_predictions(paths)
        else:
            predictions = ai.run_speciesnet(paths, self.settings["country"], self.settings["admin1_region"],
                                            self.settings["speciesnet_python"] or None,
                                            self.settings.get("speciesnet_model") or None)
        if start_overs != self.start_overs:  # someone deleted all photos while the AI was working
            self.tagging_now = 0
            return
        for photo in batch:
            prediction = predictions.get(photo["name"])
            if prediction is None or prediction.get("failures"):
                self.store.mark_failed(photo["id"])
                continue
            tags = ai.read_tags(prediction, self.settings["min_confidence"])
            path = self.data / photo["file"]
            new_file = None
            if tags["blur"]:
                ai.blur_boxes(path, tags["blur"])
            if tags["result"] == "empty":
                new_file = f"empty/{photo['file'].split('/', 1)[1]}"
                (self.data / new_file).parent.mkdir(parents=True, exist_ok=True)
                shutil.move(str(path), self.data / new_file)
            self.store.save_tags(photo["id"], tags, new_file)
            if tags["result"] == "animal":
                self.store.add_to_visit(photo["id"], self.settings["visit_gap_minutes"])
        for photo in batch:
            self.tries.pop(photo["id"], None)
            self.solo.discard(photo["id"])
        self.tagging_now = 0
        self.last_error = ""

    def clean_old_empties(self):
        cutoff = time.time() - self.settings["keep_empty_days"] * 86400
        for photo in (self.data / "empty").glob("*/*.jpg"):
            if photo.stat().st_mtime < cutoff:
                photo.unlink()

    # ---------- what the page shows ----------
    def internet_ok(self):
        checked, ok = self._internet
        if time.time() - checked > 30:
            try:
                socket.create_connection(("1.1.1.1", 53), timeout=2).close()
                ok = True
            except OSError:
                ok = False
            self._internet = (time.time(), ok)
        return ok

    def status(self):
        q = self.store.query
        count = lambda sql: q(sql)[0]["n"]
        return {
            "camera": self.camera,
            "camera_online": bool(self.camera["last_seen"]) and
                (datetime.now() - datetime.strptime(self.camera["last_seen"], "%Y-%m-%d %H:%M:%S")).total_seconds() < 120,
            "waiting": count("SELECT COUNT(*) n FROM photos WHERE status='waiting'"),
            "tagging_now": self.tagging_now,
            "photos_today": count(f"SELECT COUNT(*) n FROM photos WHERE taken_at LIKE '{datetime.now():%Y-%m-%d}%'"),
            "to_review": count("SELECT COUNT(*) n FROM visits WHERE status='review'"),
            "approved": count("SELECT COUNT(*) n FROM visits WHERE status='approved'"),
            "queued": count("SELECT COUNT(*) n FROM visits WHERE status='queued'"),
            "published": count("SELECT COUNT(*) n FROM visits WHERE status='published'"),
            "internet": self.internet_ok(),
            "fake_ai": self.fake_ai,
            "error": bool(self.last_error),     # the last tagging try failed (details: Problems page)
            "problem_count": self.problem_count,
            "failed": count("SELECT COUNT(*) n FROM photos WHERE status='failed'"),
            "photos_total": count("SELECT COUNT(*) n FROM photos"),
            "visits_total": count("SELECT COUNT(*) n FROM visits"),
            "team": self.settings["team"],
            "network": self.network.status() if self.network else None,
        }

    def visits(self, status):
        visits = self.store.query("""SELECT v.*, p.file AS best_file FROM visits v
                                     LEFT JOIN photos p ON p.id = v.best_photo_id
                                     WHERE v.status = ? ORDER BY v.start_at DESC LIMIT 100""", (status,))
        return visits

    def visit(self, visit_id):
        found = self.store.query("SELECT * FROM visits WHERE id=?", (visit_id,))
        if not found:
            return None
        found[0]["photos"] = self.store.query(
            "SELECT id, file, taken_at, trigger, species, confidence, animals FROM photos WHERE visit_id=? ORDER BY taken_at",
            (visit_id,))
        return found[0]

    def experiment(self):
        """Picture changed vs. motion sensor: what did each one catch?"""
        rows = self.store.query("""SELECT trigger, result, COUNT(*) n FROM photos WHERE status='tagged'
                                   GROUP BY trigger, result""")
        photos = {t: {"animal": 0, "person": 0, "vehicle": 0, "empty": 0} for t in ("C", "SC", "S")}
        for r in rows:
            photos[r["trigger"]][r["result"]] = r["n"]
        visits = {t: 0 for t in ("C", "SC", "S")}
        for r in self.store.query("SELECT triggers, COUNT(*) n FROM visits WHERE status != 'hidden' GROUP BY triggers"):
            if r["triggers"] in visits:
                visits[r["triggers"]] = r["n"]
        return {"photos": photos, "visits": visits}


def make_handler(station):
    public = HERE / "public"

    class Handler(BaseHTTPRequestHandler):
        timeout = 30  # a send that stalls for 30 s is dropped (Nov 15: a stuck camera send held on forever)

        def log_message(self, *args):
            pass

        def reply(self, code, body, kind="application/json"):
            if not isinstance(body, (bytes, bytearray)):
                body = json.dumps(body).encode()
            self.send_response(code)
            self.send_header("Content-Type", kind)
            self.send_header("Content-Length", str(len(body)))
            self.send_header("Cache-Control", "no-store")
            self.end_headers()
            self.wfile.write(body)

        def send_file(self, path, kind):
            if path.is_file():
                self.reply(200, path.read_bytes(), kind)
            else:
                self.reply(404, {"error": "not found"})

        def do_GET(self):
            url = urllib.parse.urlparse(self.path)
            q = urllib.parse.parse_qs(url.query)
            parts = url.path.strip("/").split("/")
            if url.path == "/":
                return self.send_file(public / "index.html", "text/html; charset=utf-8")
            if parts[0] in ("photos", "empty") and ".." not in parts:
                return self.send_file(station.data.joinpath(*parts), "image/jpeg")
            if url.path == "/api/time":  # the camera sets its clock from this (and we learn its address)
                station.seen_camera(self.client_address[0])
                return self.reply(200, {"epoch": int(time.time())})
            if url.path == "/api/live.jpg":
                try:
                    return self.reply(200, station.live_picture(), "image/jpeg")
                except Exception as error:  # camera off, out of range, busy
                    return self.reply(502, {"error": str(error)[:200]})
            if url.path == "/api/status":
                return self.reply(200, station.status())
            if url.path == "/api/visits":
                return self.reply(200, station.visits(q.get("status", ["review"])[0]))
            if parts[:2] == ["api", "visits"] and len(parts) == 3 and parts[2].isdigit():
                found = station.visit(int(parts[2]))
                return self.reply(200 if found else 404, found or {"error": "not found"})
            if url.path == "/api/problems":
                return self.reply(200, {"problems": list(reversed(station.problems)),
                                        "failed": station.status()["failed"]})
            if url.path == "/api/experiment":
                return self.reply(200, station.experiment())
            self.reply(404, {"error": "not found"})

        def do_POST(self):
            url = urllib.parse.urlparse(self.path)
            q = urllib.parse.parse_qs(url.query)
            parts = url.path.strip("/").split("/")
            length = int(self.headers.get("Content-Length") or 0)
            if length > MAX_UPLOAD:
                return self.reply(413, {"error": "too big"})
            try:
                body = self.rfile.read(length)
            except OSError:  # stalled for 30 s (timeout) or the camera hung up
                self.close_connection = True
                return
            if len(body) < length:
                return self.reply(400, {"error": "only part of it arrived"})

            if url.path == "/api/upload":
                if not station.settings["camera_key"] or q.get("key", [""])[0] != station.settings["camera_key"]:
                    return self.reply(403, {"error": "wrong key"})
                try:
                    station.receive(q.get("name", [""])[0], body, self.client_address[0])
                except ValueError as error:
                    return self.reply(400, {"error": str(error)})
                return self.reply(200, {"ok": True})

            if url.path == "/api/photos/delete-all":
                if json.loads(body or b"{}").get("sure") != "delete everything":
                    return self.reply(400, {"error": "not confirmed"})
                return self.reply(200, station.delete_all_photos())

            if url.path == "/api/problems/retry":
                return self.reply(200, {"retrying": station.retry_failed()})

            data = json.loads(body or b"{}")
            if parts[:2] == ["api", "visits"] and len(parts) >= 3 and parts[2].isdigit():
                visit_id = int(parts[2])
                if len(parts) == 4 and parts[3] == "merge":
                    keep = station.store.merge_with_previous(visit_id)
                    return self.reply(200 if keep else 400, {"kept": keep})
                station.store.update_visit(visit_id, data)
                return self.reply(200, station.visit(visit_id) or {})
            if url.path == "/api/network":
                if not station.network:
                    return self.reply(400, {"error": "wifi_switch is off in settings.json"})
                started = station.network.switch(data.get("mode"))
                station._internet = (0, False)  # check the internet again after switching
                return self.reply(200 if started else 409, station.network.status())
            if url.path == "/api/publish":
                # The picked visits wait in the "queued" list, and the Pi switches to
                # House Wi-Fi to send them. (The website uploader isn't built yet.)
                ids = [int(i) for i in data.get("ids", [])]
                for visit_id in ids:
                    station.store.update_visit(visit_id, {"status": "queued"})
                switching = False
                if ids and station.network and station.network.mode() != "internet":
                    switching = station.network.switch("internet")
                    station._internet = (0, False)
                return self.reply(200, {"queued": len(ids), "switching_to_internet": switching})
            self.reply(404, {"error": "not found"})

    return Handler


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--fake-ai", action="store_true", help="make up tags instead of running SpeciesNet")
    parser.add_argument("--data", default=str(HERE.parent / "data"), help="where photos and station.db live")
    parser.add_argument("--settings", default=str(HERE.parent / "settings.json"))
    args = parser.parse_args()

    settings = dict(DEFAULTS)
    settings_path = Path(args.settings)
    if settings_path.exists():
        settings.update(json.loads(settings_path.read_text()))
    if not settings["camera_key"]:
        print(f"Warning: no camera_key in {settings_path}. The camera can't send photos until you set one.")

    station = Station(Path(args.data).resolve(), settings, args.fake_ai)
    threading.Thread(target=station.tag_forever, daemon=True).start()
    server = ThreadingHTTPServer(("0.0.0.0", settings["port"]), make_handler(station))
    print(f"Camera Station → http://localhost:{settings['port']}" + ("  (fake AI)" if args.fake_ai else ""), flush=True)
    server.serve_forever()


if __name__ == "__main__":
    main()
