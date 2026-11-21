-- 2026-11-20 · student [who?]: "Add entries that we did practices on Thursday and Friday to practice our Innovation Project speech and Robot Game. Our best score in the Robot game was 400 but our top possible score is doing everything except Missions 4 & 5."
-- matches PRACTICE-LOG "2026-11-19 (Thu) + 2026-11-20 (Fri)", ROBOT-GAME.md + INNOVATION-PROJECT.md (same dates).
-- The 400 is saved on Nov 20: which day it happened is unclear (marked in the markdown).
INSERT INTO entries (date, who, component, phase, text, core_values, success, source, sample) VALUES
 ('2026-11-19', '["Whole team"]', 'Innovation Project', 'COMMUNICATE', 'Practiced our Innovation Project judging talk.', '["Teamwork"]', 0, 'update', 0),
 ('2026-11-19', '["Whole team"]', 'Robot Game', 'ITERATE', 'Practiced the Robot Game.', '[]', 0, 'update', 0),
 ('2026-11-20', '["Whole team"]', 'Innovation Project', 'COMMUNICATE', 'Practiced our Innovation Project judging talk again, the day before Regionals.', '["Teamwork"]', 0, 'update', 0),
 ('2026-11-20', '["Whole team"]', 'Robot Game', 'ITERATE', 'Practiced the Robot Game. Our best score over Thursday and Friday was 400! Our top possible score is 460: every mission except Missions 4 and 5, plus Equipment Inspection and Precision Tokens.', '[]', 1, 'update', 0);
INSERT INTO matches (date, score, runs_completed, what_failed, what_changed, source) VALUES
 ('2026-11-20', 400, NULL, NULL, NULL, 'update');
