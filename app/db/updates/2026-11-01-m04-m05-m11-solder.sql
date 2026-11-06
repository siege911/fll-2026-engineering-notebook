-- 2026-11-01 · told by Adeline · matches PRACTICE-LOG 2026-11-01 "M04 + M05 finished (4/5), M08 + M09 almost done, first M11 program, camera soldering"
-- Also brings the mission table up to date with the 2026-10-26 entries typed into the app (PRACTICE-LOG 2026-10-26). Those entries are already in the app, so no new entries for Oct 26.
-- Raw: "Weston and Nolan worked on mission 6, 7, and 11. they only programed 11 today. Adeline and Fynn worked on mission 8 and 9. Mission 8 and 9 are mostly finished besides the seed. Adeline worked on mission 4 and 5 and finished it, and it is pretty consistent - 4/5. As of this point we have an attachment for all the missions, the only thing left to program is mission 6 and 7. Nolan and Weston did soldering for innovation."
-- Not stored (unclear, asked): who programmed M08; M10 and M05 attachments.

-- ===== Oct 26 (typed into the app) =====

-- M06 Leafcutter Frenzy + M07 Humongous Fungus: Nolan built the first attachments
INSERT INTO attachments (name, mission, purpose, built_by, sort_order) VALUES
 ('Mission 6 attachment', 'M06', 'Get the ant and the leaf fragments into the nest (M06 Leafcutter Frenzy, "mission 6")', '["Nolan"]', 12),
 ('Mission 7 attachment', 'M07', 'Extend the mycelium all the way (M07 Humongous Fungus, "mission 7")', '["Nolan"]', 13);
INSERT INTO attachment_versions (attachment_id, date, note)
SELECT id, '2026-10-26', 'v1 built ✅ (Nolan)' FROM attachments WHERE name IN ('Mission 6 attachment', 'Mission 7 attachment');
UPDATE missions SET attachment = 'Mission 6 attachment', built_by = '["Nolan"]', status = 'Prototyping' WHERE id = 'M06';
UPDATE missions SET attachment = 'Mission 7 attachment', built_by = '["Nolan"]', status = 'Prototyping' WHERE id = 'M07';

-- M11 Window to the Past: Nolan built an attachment (rebuild or new: unclear)
UPDATE missions    SET built_by = json_insert(built_by, '$[#]', 'Nolan') WHERE id = 'M11';
UPDATE attachments SET built_by = json_insert(built_by, '$[#]', 'Nolan') WHERE name = 'Mission 11 attachment';
INSERT INTO attachment_versions (attachment_id, date, note)
SELECT id, '2026-10-26', 'Nolan built an attachment for M11' FROM attachments WHERE name = 'Mission 11 attachment';

-- M04 Lucky Leaves + M05 Reaching Roots: Isla programmed
UPDATE missions SET programmed_by = json_insert(programmed_by, '$[#]', 'Isla') WHERE id IN ('M04', 'M05');
UPDATE programs SET coded_by      = json_insert(coded_by,      '$[#]', 'Isla') WHERE mission IN ('M04', 'M05');

-- Core Values moment: Fynn helped Weston with M09
INSERT INTO moments (date, value, who, text, help, source, created_at)
VALUES ('2026-10-26', 'Teamwork', '["Fynn","Weston"]', 'Fynn helped Weston with mission 9 (Research Platform).', '["Fynn","Weston"]', 'update', '2026-10-26 12:00:00');

-- ===== Nov 1 =====

-- M06 + M07: Weston and Nolan worked on the attachments (no programs yet)
UPDATE missions    SET built_by = json_insert(built_by, '$[#]', 'Weston') WHERE id IN ('M06', 'M07');
UPDATE attachments SET built_by = json_insert(built_by, '$[#]', 'Weston') WHERE name IN ('Mission 6 attachment', 'Mission 7 attachment');
INSERT INTO attachment_versions (attachment_id, date, note)
SELECT id, '2026-11-01', 'worked on (Weston, Nolan) · needs a program' FROM attachments WHERE name IN ('Mission 6 attachment', 'Mission 7 attachment');

-- M11: Weston and Nolan wrote the first program
UPDATE missions SET programmed_by = '["Weston","Nolan"]' WHERE id = 'M11';
INSERT INTO programs (program, mission, coded_by, sensors, innovative_bit, sort_order)
VALUES ('Window to the Past (M11) program', 'M11', '["Weston","Nolan"]', '—', 'First M11 program (Nov 1)', 11);

-- M08 Tangled: Adeline and Fynn, "mostly finished" → Working
UPDATE missions SET status = 'Working' WHERE id = 'M08';
INSERT INTO attachment_versions (attachment_id, date, note)
SELECT id, '2026-11-01', 'mostly finished (Adeline, Fynn)' FROM attachments WHERE name = 'Mission 8 attachment';

-- M09 Research Platform: Adeline and Fynn, mostly finished except the seed → stays Prototyping
INSERT INTO attachment_versions (attachment_id, date, note)
SELECT id, '2026-11-01', 'mostly finished except the seed (Adeline, Fynn)' FROM attachments WHERE name = 'Mission 9 attachment';

-- M04 + M05: Adeline finished them, 4/5 → Working, 80%
UPDATE missions SET status = 'Working', reliability = 80 WHERE id IN ('M04', 'M05');
UPDATE missions SET programmed_by = json_insert(programmed_by, '$[#]', 'Adeline') WHERE id = 'M05';
UPDATE programs SET coded_by      = json_insert(coded_by,      '$[#]', 'Adeline') WHERE mission = 'M05';
INSERT INTO tests (date, attachment, tries, successes, observed, changed, result, source, created_at)
VALUES ('2026-11-01', 'Missions 4 + 5 (Lucky Leaves + Reaching Roots)', 5, 4, 'Adeline finished missions 4 and 5 and tested them: 4 out of 5 worked. "Pretty consistent."', '', '80%', 'update', '2026-11-01 12:00:00');

-- Notebook entries
INSERT INTO entries (date, who, component, phase, text, core_values, success, source) VALUES
 ('2026-11-01', '["Weston","Nolan"]', 'Robot Design', 'CREATE', 'Weston and Nolan worked on missions 6, 7, and 11. They programmed mission 11 (Window to the Past), our first program for it.', '["Teamwork"]', 1, 'update'),
 ('2026-11-01', '["Adeline","Fynn"]', 'Robot Design', 'ITERATE', 'Adeline and Fynn worked on missions 8 and 9 (Tangled, Research Platform). They are mostly finished besides the seed.', '["Teamwork"]', 1, 'update'),
 ('2026-11-01', '["Adeline"]', 'Robot Game', 'ITERATE', 'Adeline finished missions 4 and 5 (Lucky Leaves, Reaching Roots). Pretty consistent: 4 out of 5.', '[]', 1, 'update'),
 ('2026-11-01', '["Adeline","Fynn","Nolan","Weston"]', 'Robot Game', 'DESIGN', 'We have an attachment for all the missions! The only thing left to program is missions 6 and 7.', '[]', 1, 'update'),
 ('2026-11-01', '["Nolan","Weston"]', 'Innovation Project', 'CREATE', 'Nolan and Weston did soldering for the camera.', '["Teamwork"]', 1, 'update');
