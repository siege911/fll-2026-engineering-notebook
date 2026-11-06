-- 2026-10-26 · asked by Thea ("in innovation can you make a new section that is called communication") → picked "Sharing our project"
-- Matches INNOVATION-PROJECT.md 2026-10-26 "New Communication section" and DECISIONS 2026-10-26.
-- New table: every time the team shared its project with someone, what they said, and what we changed.
CREATE TABLE shares (
  id               INTEGER PRIMARY KEY AUTOINCREMENT,
  date             TEXT,
  shared_with      TEXT,
  who              TEXT DEFAULT '[]',   -- JSON: teammates who shared
  what_they_said   TEXT,
  what_we_changed  TEXT,
  source           TEXT DEFAULT 'update',
  created_at       TEXT
);

-- First row, from INNOVATION-PROJECT.md 2026-10-05 (expert meeting) and 2026-10-25 (camera plan v2 / Pi Camera Station)
INSERT INTO shares (date, shared_with, who, what_they_said, what_we_changed, source, created_at) VALUES
 ('2026-10-05', 'Nate Reagan (Arizona Game and Fish)', '["Whole team"]',
  'A camera with a flashing light has been done before. Don''t live stream. Use AI to blur out people. Cameras spread over a wide area work best.',
  'Oct 25: our Camera Station blurs people, and we review every photo before anything is published.',
  'update', '2026-10-26 12:00:00');
