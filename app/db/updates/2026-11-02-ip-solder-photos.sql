-- 2026-11-02 · sent by a student [who?]: "nov 1 we did sodering so put these pictures in innovation progect for the app"
-- Matches PRACTICE-LOG 2026-11-01 (Photos, added 2026-11-02), INNOVATION-PROJECT.md 2026-11-01, CAMERA-BUILD.md 2026-11-01.
-- New table: photos for the Innovation Project page (Project Photos card). photo = file name inside app/images/.
CREATE TABLE ip_photos (
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  date        TEXT,
  who         TEXT DEFAULT '[]',   -- JSON: teammates doing the work shown
  caption     TEXT,
  photo       TEXT,
  sort_order  INTEGER DEFAULT 0,
  source      TEXT DEFAULT 'update',
  created_at  TEXT
);

INSERT INTO ip_photos (date, who, caption, photo, sort_order, source, created_at) VALUES
 ('2026-11-01', '["Nolan","Weston"]', 'Soldering for the camera, with the helping-hands magnifier.', '11-1-soldering-1.jpg', 1, 'update', '2026-11-02 12:00:00'),
 ('2026-11-01', '["Nolan","Weston"]', 'Soldering for the camera while teammates watch.', '11-1-soldering-2.jpg', 2, 'update', '2026-11-02 12:00:01');
