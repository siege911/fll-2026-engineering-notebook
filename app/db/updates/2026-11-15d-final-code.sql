-- 2026-11-15 · told by Coach CJ · matches PRACTICE-LOG 2026-11-15 "Robot code: Final v1, v2, v3", 2026-11-03, and the code lines added to 2026-11-09 / 2026-11-13;
-- ROBOT-CODE.md 2026-11-15; DECISIONS 2026-11-15 "One menu program for competition".
-- Raw: "Final v1 is just the capture of everything on November 3. Adeline did the main work on Nov 3 to move to the Final v2 which includes the code
--   for selecting the missions during the competition. We tested it on Nov 9. Fynn did the updates on Nov 9 and Nov 13 to the code for Final v3 to fine-tune all of the missions."
-- The code itself is read live from code/ (Final v1 - Nov 3, Final v2 - Nov 9, Final v3 - Nov 13); this file holds only the who-did-what.

-- Who made each saved code version (Coding page → Our Robot Code): code folder date → names
INSERT INTO settings (key, value, note) VALUES
 ('robot_code_who', '{"2026-11-09":["Adeline"],"2026-11-13":["Fynn"]}', 'Coding page: who made each saved version of the code, by code-folder date (Nov 15)');

-- Fynn fine-tuned every mission in the menu (Final v3) → add Fynn to "Coded by" where not listed yet
UPDATE missions SET programmed_by = json_insert(programmed_by, '$[#]', 'Fynn')
 WHERE id IN ('M01','M02','M03','M04','M05','M06','M07','M08','M09','M11','M12','M13','M14','M15')
   AND programmed_by NOT LIKE '%"Fynn"%';
UPDATE programs SET coded_by = json_insert(coded_by, '$[#]', 'Fynn')
 WHERE mission IS NOT NULL AND coded_by NOT LIKE '%"Fynn"%';

-- Adeline's mission menu
INSERT INTO programs (program, mission, coded_by, sensors, innovative_bit, sort_order) VALUES
 ('Mission menu (main_base.py + robot.py)', NULL, '["Adeline"]', 'Hub buttons, light, speaker',
  'One program for the whole match: pick runs 1–9 with the hub buttons, CENTER stops a run and stays on it to retry, the next run is ready (orange light) as soon as one finishes. Ports and wheels set once in robot.py. Built Nov 3, tested Nov 9.', 12);

-- Notebook entries
INSERT INTO entries (date, who, component, phase, text, core_values, success, source) VALUES
 ('2026-11-03', '["Adeline"]', 'Robot Design', 'CREATE', 'Saved all our programs as Final v1. Adeline built the mission menu: one program where we pick each run with the hub buttons, plus robot.py so the ports and wheels are set up in one place.', '[]', 0, 'update'),
 ('2026-11-09', '["Adeline","Fynn"]', 'Robot Design', 'ITERATE', 'We tested Adeline''s mission menu (Final v2) on the robot. Fynn started fine-tuning the code for the missions.', '[]', 1, 'update'),
 ('2026-11-13', '["Fynn"]', 'Robot Design', 'ITERATE', 'Fynn finished fine-tuning the code for all the missions: Final v3 (new path for Missions 2 + 3, smaller arm moves for Mission 15, new distances for Mission 1).', '[]', 1, 'update');
