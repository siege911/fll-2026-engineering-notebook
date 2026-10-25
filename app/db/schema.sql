-- Rooted Warriors season app — database schema.
-- Plain SQLite, written to also run on Cloudflare D1 (the deploy target, DECISIONS.md 2026-08-31).
-- Columns holding lists (names, core values, mission ids) store JSON arrays as TEXT, e.g. '["Isla","Fynn"]'.
-- Dates are ISO text: 'YYYY-MM-DD'.
-- sample = 1 marks made-up placeholder rows carried over from the v2 mockup (not real team facts).
-- source = 'update' (added from a practice update, also in the markdown files) or 'app' (typed into the app by a student).

CREATE TABLE team (
  name              TEXT PRIMARY KEY,
  color             TEXT NOT NULL,          -- avatar color
  face              TEXT,                   -- emoji
  role              TEXT DEFAULT '',
  fav_value         TEXT DEFAULT '',
  fav_color         TEXT DEFAULT '',
  worked_on_most    TEXT DEFAULT '',
  learned           TEXT DEFAULT '',
  worked_with_most  TEXT DEFAULT '',
  notebook_entries  TEXT DEFAULT '',
  sort_order        INTEGER
);

CREATE TABLE missions (
  id             TEXT PRIMARY KEY,          -- official number, 'M01'..'M15'
  name           TEXT NOT NULL,             -- official name (06-missions-bioglow.md)
  aka            TEXT DEFAULT '',           -- what the team calls it
  max_points     INTEGER NOT NULL,
  how_it_scores  TEXT,
  no_equipment   INTEGER DEFAULT 0,
  difficulty     INTEGER DEFAULT 0,         -- 0 = not rated, 1..5
  run_number     INTEGER,                   -- run in the draft run plan
  attachment     TEXT DEFAULT '—',
  built_by       TEXT DEFAULT '[]',         -- JSON array of names
  programmed_by  TEXT DEFAULT '[]',         -- JSON array of names
  reliability    INTEGER DEFAULT 0,         -- %
  status         TEXT DEFAULT 'Not started',-- Not started | Prototyping | Working | Reliable | Competition-ready
  est_seconds    INTEGER DEFAULT 30         -- 30 = a guess until a real run is timed
);

CREATE TABLE scoring_extras (
  name        TEXT PRIMARY KEY,
  max_points  INTEGER NOT NULL,
  how         TEXT
);

CREATE TABLE runs (
  run_number   INTEGER PRIMARY KEY,
  missions     TEXT NOT NULL,               -- JSON array of mission ids
  est_seconds  INTEGER,
  launcher     TEXT DEFAULT '—'
);

CREATE TABLE matches (
  id              INTEGER PRIMARY KEY AUTOINCREMENT,
  date            TEXT NOT NULL,
  score           INTEGER NOT NULL,
  runs_completed  INTEGER,
  what_failed     TEXT,
  what_changed    TEXT,
  source          TEXT DEFAULT 'app',
  created_at      TEXT DEFAULT (datetime('now'))
);

CREATE TABLE rubric (
  id           INTEGER PRIMARY KEY,         -- display order
  section      TEXT NOT NULL,               -- 'ip' | 'rd'
  phase        TEXT NOT NULL,               -- IDENTIFY | DESIGN | CREATE | ITERATE | COMMUNICATE
  row_name     TEXT NOT NULL,
  core_values  INTEGER DEFAULT 0,           -- ⚙️ row also counts for Core Values
  level        INTEGER DEFAULT 1            -- team self-rating 1..4
);

CREATE TABLE entries (                      -- the Engineering Notebook (Daily Log)
  id           INTEGER PRIMARY KEY AUTOINCREMENT,
  date         TEXT NOT NULL,
  who          TEXT NOT NULL,               -- JSON array of names
  component    TEXT NOT NULL,               -- Robot Game | Robot Design | Innovation Project | Core Values
  phase        TEXT,
  text         TEXT NOT NULL,
  core_values  TEXT DEFAULT '[]',           -- JSON array
  success      INTEGER DEFAULT 0,
  photo        TEXT,
  source       TEXT DEFAULT 'app',
  sample       INTEGER DEFAULT 0,
  created_at   TEXT DEFAULT (datetime('now'))
);

CREATE TABLE moments (                      -- Core Values moments
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  date        TEXT NOT NULL,
  value       TEXT NOT NULL,                -- one of the six core values
  who         TEXT NOT NULL,                -- JSON array
  text        TEXT NOT NULL,
  help        TEXT,                         -- JSON ["giver","receiver"] or NULL
  source      TEXT DEFAULT 'app',
  sample      INTEGER DEFAULT 0,
  created_at  TEXT DEFAULT (datetime('now'))
);

CREATE TABLE tests (                        -- test sessions: observation → change → result
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  date        TEXT NOT NULL,
  attachment  TEXT NOT NULL,
  tries       INTEGER NOT NULL,
  successes   INTEGER NOT NULL,
  observed    TEXT,
  changed     TEXT,
  result      TEXT,
  source      TEXT DEFAULT 'app',
  created_at  TEXT DEFAULT (datetime('now'))
);

CREATE TABLE attachments (
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  name        TEXT UNIQUE NOT NULL,
  mission     TEXT,                         -- 'M02' or 'M02 + M03'
  purpose     TEXT,
  built_by    TEXT DEFAULT '[]',            -- JSON array
  size        TEXT DEFAULT '—',
  sort_order  INTEGER
);

CREATE TABLE attachment_versions (
  id             INTEGER PRIMARY KEY AUTOINCREMENT,
  attachment_id  INTEGER NOT NULL REFERENCES attachments(id),
  date           TEXT NOT NULL,
  note           TEXT NOT NULL,
  photo          TEXT
);

CREATE TABLE programs (                     -- Coding page: "Programs We've Written"
  id             INTEGER PRIMARY KEY AUTOINCREMENT,
  program        TEXT NOT NULL,
  mission        TEXT,                      -- mission id, NULL for the base template
  coded_by       TEXT DEFAULT '[]',         -- JSON array
  sensors        TEXT DEFAULT '—',
  innovative_bit TEXT,
  sort_order     INTEGER
);

CREATE TABLE robot_specs (                  -- Robot Design: "The Main Robot" card
  label       TEXT PRIMARY KEY,
  value       TEXT,
  sort_order  INTEGER
);

CREATE TABLE tradeoffs (
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  date        TEXT,
  question    TEXT NOT NULL,
  options     TEXT,
  pick        TEXT,
  why         TEXT,
  sort_order  INTEGER
);

CREATE TABLE ip_steps (
  n     INTEGER PRIMARY KEY,
  name  TEXT NOT NULL
);

CREATE TABLE gantt (
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  task        TEXT NOT NULL,
  owner       TEXT,
  start_pos   REAL,                         -- months from Aug 1 (0..4)
  end_pos     REAL,
  iterations  TEXT DEFAULT '[]',            -- JSON array
  sample      INTEGER DEFAULT 0
);

CREATE TABLE research (
  id        INTEGER PRIMARY KEY AUTOINCREMENT,
  source    TEXT NOT NULL,
  type      TEXT,
  found_by  TEXT,
  note      TEXT,
  sample    INTEGER DEFAULT 0
);

CREATE TABLE experts (
  id           INTEGER PRIMARY KEY AUTOINCREMENT,
  name         TEXT NOT NULL,
  role         TEXT,
  face         TEXT,
  feedback     TEXT,
  improvement  TEXT,
  sample       INTEGER DEFAULT 0
);

CREATE TABLE quotes (                       -- Proudest Moment card; newest id shows first
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  quote       TEXT NOT NULL,
  by_line     TEXT,
  date        TEXT,
  source      TEXT DEFAULT 'app',
  created_at  TEXT DEFAULT (datetime('now'))
);

CREATE TABLE settings (                     -- one-off values; value is JSON
  key    TEXT PRIMARY KEY,
  value  TEXT NOT NULL,
  note   TEXT
);

CREATE TABLE applied_updates (              -- which files in db/updates/ have been applied
  file        TEXT PRIMARY KEY,
  applied_at  TEXT DEFAULT (datetime('now'))
);
