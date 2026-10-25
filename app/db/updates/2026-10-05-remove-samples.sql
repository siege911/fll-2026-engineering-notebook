-- 2026-10-05 · asked by Adeline and Thea · matches PRACTICE-LOG 2026-10-05 (app changes) and DECISIONS 2026-10-05 "Remove all sample data"
-- "Get rid of all the sample stuff that we did not do. If there's nothing there, make it a text box so we can fill it out."
-- The made-up v2-mockup placeholders are still readable in seed.sql for history.
DELETE FROM moments WHERE sample = 1;     -- 7 made-up Aug 13–29 Core Values moments (GlowCast buoy story)
DELETE FROM gantt   WHERE sample = 1;     -- 6 made-up Project Plan bars
DELETE FROM settings WHERE key IN ('cv_tally_base', 'ip_summary', 'ip_progress');   -- made-up tally counts, GlowCast problem/solution, 4-of-8 steps

-- The team now fills these in from the app: Project Plan bars (rows added there get source = 'app').
ALTER TABLE gantt ADD COLUMN source TEXT DEFAULT 'update';
ALTER TABLE gantt ADD COLUMN created_at TEXT;
