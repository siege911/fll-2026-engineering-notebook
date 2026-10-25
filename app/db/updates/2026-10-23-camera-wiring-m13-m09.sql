-- 2026-10-23 · told by Thea · matches PRACTICE-LOG 2026-10-23 "Camera wired; M13 programmed; first M09 attachment + program"
-- Raw: "Today oct 23 Nolan did the wiring for the camera. Thea helped Nolan. Isla programed the mascot mission. Weston built and atachment and programed for the big tree mission." / "Adeline and Fynn were not there"
-- "the big tree mission" = M09 Research Platform (Thea confirmed). "the mascot mission" = M13 Keystone Species.

-- M13 Keystone Species: Isla wrote the first program
UPDATE missions SET programmed_by = json_insert(programmed_by, '$[#]', 'Isla') WHERE id = 'M13';
INSERT INTO programs (program, mission, coded_by, sensors, innovative_bit, sort_order)
VALUES ('Keystone Species (M13) program', 'M13', '["Isla"]', '—', 'First M13 program (Oct 23, "the mascot mission")', 9);

-- M09 Research Platform: Weston built the first attachment and programmed it
INSERT INTO attachments (name, mission, purpose, built_by, sort_order)
VALUES ('Mission 9 attachment', 'M09', 'Raise the research platform, deploy the camera trap, knock the seed off the big tree (M09 Research Platform, "the big tree mission")', '["Weston"]', 9);
INSERT INTO attachment_versions (attachment_id, date, note)
SELECT id, '2026-10-23', 'v1 built ✅ (Weston)' FROM attachments WHERE name = 'Mission 9 attachment';
UPDATE missions SET attachment = 'Mission 9 attachment', built_by = '["Weston"]', programmed_by = '["Weston"]', status = 'Prototyping' WHERE id = 'M09';
INSERT INTO programs (program, mission, coded_by, sensors, innovative_bit, sort_order)
VALUES ('Research Platform (M09) program', 'M09', '["Weston"]', '—', 'First M09 program (Oct 23, "the big tree mission")', 10);

-- Notebook entries
INSERT INTO entries (date, who, component, phase, text, core_values, success, source) VALUES
 ('2026-10-23', '["Nolan","Thea"]', 'Innovation Project', 'CREATE', 'Nolan did the wiring for the camera. Thea helped Nolan.', '["Teamwork"]', 1, 'update'),
 ('2026-10-23', '["Isla"]', 'Robot Game', 'CREATE', 'Isla programmed the mascot mission (mission 13, Keystone Species).', '[]', 1, 'update'),
 ('2026-10-23', '["Weston"]', 'Robot Design', 'CREATE', 'Weston built an attachment and programmed the big tree mission (mission 9, Research Platform), our first one for that mission.', '[]', 1, 'update');

-- Core Values moment: help given / received
INSERT INTO moments (date, value, who, text, help, source, created_at)
VALUES ('2026-10-23', 'Teamwork', '["Thea","Nolan"]', 'Thea helped Nolan wire the camera for our Innovation Project.', '["Thea","Nolan"]', 'update', '2026-10-23 12:00:00');
