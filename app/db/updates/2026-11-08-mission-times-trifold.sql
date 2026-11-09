-- 2026-11-08 · told by [who?] on 2026-11-09 · matches PRACTICE-LOG 2026-11-08 "Every mission tested and timed (Fynn + Isla); trifold boards (Thea + Adeline)"
-- Raw: "Yesterday Fynn and Isla worked on testing all of the missions and timing them. Attached is their notes. Thea and Adeline worked on the trifold boards for the competition."
-- Notes (handwritten): mission 1 = 12 sec · [needs help] mission 2,3 = · missions 4,5 = 17 sec · [needs work] mission 8,9 = · [needs work] mission 10,14 = · mission 12 = 7 sec · [fix yellow arm] mission 15 = · mission 13,12 = 17 · missions 6,7,11 = 17 sec
-- Not stored (unclear): who programmed M06/M07; what M10 uses; why M12 is listed twice; match order vs test order.

-- Run plan: new columns for when a run was really timed, and the team's note on it
ALTER TABLE runs ADD COLUMN timed_on TEXT;           -- date of a real stopwatch time; NULL = est_seconds is a guess
ALTER TABLE runs ADD COLUMN note TEXT DEFAULT '';    -- the team's note on the run ("needs work", "fix yellow arm")

DELETE FROM runs;
INSERT INTO runs (run_number, missions, est_seconds, timed_on, note) VALUES
 (1, '["M01"]',             12, '2026-11-08', 'Timed by Fynn + Isla'),
 (2, '["M02","M03"]',       35, NULL,         'needs help'),
 (3, '["M04","M05"]',       17, '2026-11-08', 'Timed by Fynn + Isla'),
 (4, '["M08","M09"]',       30, NULL,         'needs work'),
 (5, '["M10","M14"]',       30, NULL,         'needs work'),
 (6, '["M12"]',              7, '2026-11-08', 'Timed by Fynn + Isla'),
 (7, '["M15"]',             30, NULL,         'fix yellow arm'),
 (8, '["M13","M12"]',       17, '2026-11-08', 'Timed by Fynn + Isla · M12 is also in run 6 [unclear]'),
 (9, '["M06","M07","M11"]', 17, '2026-11-08', 'Timed by Fynn + Isla');

UPDATE missions SET run_number = 1 WHERE id = 'M01';
UPDATE missions SET run_number = 2 WHERE id IN ('M02','M03');
UPDATE missions SET run_number = 3 WHERE id IN ('M04','M05');
UPDATE missions SET run_number = 4 WHERE id IN ('M08','M09');
UPDATE missions SET run_number = 5 WHERE id IN ('M10','M14');
UPDATE missions SET run_number = 6 WHERE id = 'M12';
UPDATE missions SET run_number = 7 WHERE id = 'M15';
UPDATE missions SET run_number = 8 WHERE id = 'M13';
UPDATE missions SET run_number = 9 WHERE id IN ('M06','M07','M11');

-- Mission times that belong to one mission alone
UPDATE missions SET est_seconds = 12 WHERE id = 'M01';
UPDATE missions SET est_seconds = 7  WHERE id = 'M12';

-- M10: first time in testing (runs with M14)
UPDATE missions SET status = 'Prototyping' WHERE id = 'M10' AND status = 'Not started';

-- M15: note from testing
INSERT INTO attachment_versions (attachment_id, date, note)
SELECT id, '2026-11-08', 'tested by Fynn + Isla: fix yellow arm' FROM attachments WHERE name = 'Mission 15 attachment';

-- Notebook entries
INSERT INTO entries (date, who, component, phase, text, core_values, success, photo, source) VALUES
 ('2026-11-08', '["Fynn","Isla"]', 'Robot Game', 'ITERATE', 'Fynn and Isla tested all of the missions and timed them. Mission 1 = 12 sec, missions 4+5 = 17 sec, mission 12 = 7 sec, missions 13+12 = 17 sec, missions 6+7+11 = 17 sec. Still to fix: missions 2+3 (needs help), 8+9 and 10+14 (needs work), mission 15 (fix yellow arm).', '["Teamwork"]', 1, '11-8-mission-timing-notes.webp', 'update'),
 ('2026-11-08', '["Thea","Adeline"]', 'Innovation Project', 'COMMUNICATE', 'Thea and Adeline worked on the trifold boards for the competition.', '["Teamwork"]', 1, NULL, 'update');

INSERT INTO moments (date, value, who, text, help, source, created_at)
VALUES ('2026-11-08', 'Teamwork', '["Fynn","Isla","Thea","Adeline"]', 'Two pairs: Fynn + Isla tested and timed every mission; Thea + Adeline made the trifold boards.', '[]', 'update', '2026-11-08 12:00:00');
