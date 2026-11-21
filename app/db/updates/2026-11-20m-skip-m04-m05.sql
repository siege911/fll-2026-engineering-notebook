-- 2026-11-20 · student [who?]: "Everyone was at both practices. Show top practice score was 400 but top possible score is 460. We skipped Missions 4 & 5 due to time"
-- matches PRACTICE-LOG "2026-11-19 (Thu) + 2026-11-20 (Fri)" follow-up, ROBOT-GAME.md, DECISIONS.md 2026-11-20 "We skip Missions 4 + 5".
-- Missions we leave out of a match; the Dashboard's Top Practice Score card uses it to work out "top possible" (460).
INSERT INTO settings (key, value, note) VALUES
 ('game_plan', '{"skip":["M04","M05"],"why":"time","date":"2026-11-20"}', 'update 2026-11-20');
