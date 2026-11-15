-- 2026-11-15 · told by Coach CJ · matches PRACTICE-LOG 2026-11-15 "Robot code: Final v1 and Final v2", ROBOT-CODE.md 2026-11-15 ("Why there is no Final v3"), DECISIONS 2026-11-15.
-- Raw: "This is the absolute latest backup from the active code so should be v3. If these are the same then just use this as v2 and remove the v3.
--   Fynn did do some fine tuning work be we may not have created the backups at the right time."
-- The Nov 15 hub backup = Final v3 = Final v2, byte for byte. code/Final v3 - Nov 13 removed; Final v2 holds Adeline's menu + Fynn's fine-tuning.

UPDATE settings SET value = '{"2026-11-09":["Adeline","Fynn"]}' WHERE key = 'robot_code_who';

UPDATE entries SET text = 'Fynn finished fine-tuning the code for all the missions (new path for Missions 2 + 3, smaller arm moves for Mission 15, new distances for Mission 1). Saved together with Adeline''s menu as Final v2.'
 WHERE date = '2026-11-13' AND source = 'update' AND text LIKE 'Fynn finished fine-tuning the code for all the missions: Final v3%';
UPDATE entries SET text = 'We tested Adeline''s mission menu (Final v2) on the robot. Fynn started fine-tuning the code for the missions.'
 WHERE date = '2026-11-09' AND source = 'update' AND text LIKE 'We tested Adeline''s mission menu (Final v2)%';
