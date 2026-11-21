-- 2026-11-20 · asked by a student [who?]: "fill out anything that hasn't been filled out"
-- Facts come only from the team's Nov 15 judging talks (updates/PRESENTATION.md) and the Final v3 code (code/Final v3 - Nov 18).
-- Markdown: updates/ROBOT-DESIGN.md + updates/INNOVATION-PROJECT.md + DECISIONS.md, all 2026-11-20.

-- Tradeoffs
UPDATE tradeoffs SET options = '8 different wheels we tested',
  why = 'Good traction and accurate. "We started by testing 8 different wheels. We decided on this one because it has good traction and is accurate." (Isla)'
 WHERE id = 4;
UPDATE tradeoffs SET why = 'So we can test three attachments at once and have a spare. (Isla) One of the three has no gears: it is our build-and-test robot.'
 WHERE id = 5;
UPDATE tradeoffs SET pick = 'Combined 2 + 3 attachment',
  why = 'One trip does two missions: it knocks the seeds loose and flips the rock (Weston). Nolan''s combined attachment tested 5/5 on Oct 2. Lesson: "combine missions to save trips." (Thea)'
 WHERE id = 6;
INSERT INTO tradeoffs (date, question, options, pick, why, sort_order) VALUES
 (NULL, 'A build-and-test robot with no gears?', 'Gears on every robot vs one robot with no gears',
  'One robot with no gears',
  'One person can focus on building and hand-drive it around the map to test attachments. Then we switch to one of the two robots with gears to program the mission. (Adeline)', 7);

-- Robot specs
UPDATE robot_specs SET value = '4 motors: drive wheels on ports A (left) + E (right), attachment motors on B (left) + F (right)' WHERE label = 'Motors';
UPDATE robot_specs SET value = 'Gyro in the hub: drives straight and turns exactly (every Final v3 program turns it on). No color sensors: the compact base had no room for one (Sep 6)' WHERE label = 'Sensors';

-- Programs: every Final v3 mission program turns the gyro on
UPDATE programs SET sensors = 'Gyro (in the hub)' WHERE id BETWEEN 2 AND 11 AND sensors = '—';
UPDATE programs SET sensors = 'Gyro (on before each mission, off between), hub buttons, light, speaker' WHERE id = 12;

-- Notebook entries for facts said in the talks
INSERT INTO entries (date, who, component, phase, text, core_values, success, source, sample) VALUES
 ('2026-11-15', '["Adeline"]', 'Innovation Project', 'DESIGN',
  'From our judging talk: we had 3 ideas. 1) A camera or sensor with a flashing light to warn drivers about animals. 2) A camera in a car that alerts the driver. 3) A camera that counts how many animals use the bridge vs other crossing places. We picked one multi-purpose camera that detects animals and could help all 3, starting with counting animals on the new bridge.',
  '["Innovation"]', 0, 'update', 0),
 ('2026-11-15', '["Weston"]', 'Innovation Project', 'ITERATE',
  'From our judging talk: our first plan was to put the Raspberry Pi in the forest. After our research (a Pi 4 uses 3–5 watts all the time) we switched to the tiny camera, because it uses less energy and needs a smaller solar panel. The Pi now collects the pictures over Wi-Fi.',
  '[]', 1, 'update', 0),
 ('2026-11-15', '["Adeline"]', 'Robot Design', 'DESIGN',
  'From our judging talk: one of our three robots has no gears. One person builds and hand-drives it around the map to test attachments, then we switch to one of the two robots with gears to program the mission.',
  '[]', 0, 'update', 0);
