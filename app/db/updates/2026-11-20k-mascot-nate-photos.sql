-- 2026-11-20 · student [who?]: "We added our Team Mascot Photo and a Picture of Nate Ragan with the Team. Nate Ragan is the guy on the left if we want to crop it for a profile picture."
-- matches PRACTICE-LOG 2026-11-20 "New photos: team mascot + Nate Ragan with the team", CORE-VALUES.md + INNOVATION-PROJECT.md (Nov 20 notes).
-- Originals in ../photos/ (mascot.jpg, nate_ragan.jpg); smaller copies + crops in app/images/11-20-*.jpg.
ALTER TABLE experts ADD COLUMN photo TEXT;        -- profile picture (square)
ALTER TABLE experts ADD COLUMN team_photo TEXT;   -- photo of the expert with the team
UPDATE experts SET photo = '11-20-profile-nate-ragan.jpg', team_photo = '11-20-nate-ragan-with-team.jpg' WHERE name = 'Nate Ragan';
UPDATE settings SET value = json_set(value, '$.photo', '11-20-mascot-square.jpg', '$.photo_big', '11-20-mascot.jpg'), note = 'update 2026-11-20' WHERE key = 'mascot';
