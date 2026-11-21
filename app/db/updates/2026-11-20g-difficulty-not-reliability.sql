-- 2026-11-20 · Thea: "you didn't do it. Try again." · matches PRACTICE-LOG "2026-11-20 — Difficulty ratings: M11, M12, M13, M14, M15"
-- Fixes 2026-11-20f: Thea's "3 out of 5" numbers are DIFFICULTY, not reliability / test tries.

UPDATE missions SET difficulty = 3 WHERE id = 'M11';
UPDATE missions SET difficulty = 3 WHERE id = 'M12';
UPDATE missions SET difficulty = 2 WHERE id = 'M13';
UPDATE missions SET difficulty = 2 WHERE id = 'M14';
UPDATE missions SET difficulty = 3 WHERE id = 'M15';

-- Reliability back to the slider estimates set in the app today (those saves failed while the data file was locked)
UPDATE missions SET reliability = 94  WHERE id = 'M11';
UPDATE missions SET reliability = 100 WHERE id = 'M12';
UPDATE missions SET reliability = 91  WHERE id = 'M13';
UPDATE missions SET reliability = 82  WHERE id = 'M14';
UPDATE missions SET reliability = 95  WHERE id = 'M15';

DELETE FROM tests WHERE date = '2026-11-20' AND source = 'update' AND tries = 5
  AND attachment IN ('Mission 11 attachment','Mission 12 attachment','Keystone Species (mascot) attachment','Mission 14 attachment','Mission 15 attachment');
DELETE FROM entries WHERE date = '2026-11-20' AND source = 'update' AND text LIKE 'We counted tries, 5 each:%';
