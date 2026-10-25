-- 2026-10-12 · told by a student [who? first name not given] · matches PRACTICE-LOG 2026-10-12 "Robot: M12 rebuilt, M13 rebuilt, first M11 attachment, M04 + M05 programs"
-- Raw: "Oct, 12 Adeline programed and rebuilt mission 12. Nolan rebuilt an attachment for mission 13. Weston built an attachment for mission 11. Thea worked on the app. Fynn programed for mission 4 and 5. Isla helped Fynn."

-- M12 Forest Elder: Adeline rebuilt the attachment (v2) and programmed it (already listed as a coder)
UPDATE missions    SET built_by = json_insert(built_by, '$[#]', 'Adeline') WHERE id = 'M12';
UPDATE attachments SET built_by = json_insert(built_by, '$[#]', 'Adeline') WHERE name = 'Mission 12 attachment';
INSERT INTO attachment_versions (attachment_id, date, note)
SELECT id, '2026-10-12', 'v2 rebuilt + programmed (Adeline)' FROM attachments WHERE name = 'Mission 12 attachment';

-- M13 Keystone Species: Nolan rebuilt the attachment
UPDATE missions    SET built_by = json_insert(built_by, '$[#]', 'Nolan') WHERE id = 'M13';
UPDATE attachments SET built_by = json_insert(built_by, '$[#]', 'Nolan') WHERE name = 'Keystone Species (mascot) attachment';
INSERT INTO attachment_versions (attachment_id, date, note)
SELECT id, '2026-10-12', 'rebuilt (Nolan)' FROM attachments WHERE name = 'Keystone Species (mascot) attachment';

-- M11 Window to the Past: Weston built the first attachment
INSERT INTO attachments (name, mission, purpose, built_by, sort_order)
VALUES ('Mission 11 attachment', 'M11', 'Put the root cover down so it touches the mat (M11 Window to the Past, "mission 11")', '["Weston"]', 11);
INSERT INTO attachment_versions (attachment_id, date, note)
SELECT id, '2026-10-12', 'v1 built ✅ (Weston)' FROM attachments WHERE name = 'Mission 11 attachment';
UPDATE missions SET attachment = 'Mission 11 attachment', built_by = '["Weston"]', status = 'Prototyping' WHERE id = 'M11';

-- M04 Lucky Leaves + M05 Reaching Roots: Fynn programmed, Isla helped
UPDATE missions SET programmed_by = json_insert(programmed_by, '$[#]', 'Fynn') WHERE id = 'M04';
UPDATE programs SET coded_by      = json_insert(coded_by,      '$[#]', 'Fynn') WHERE mission = 'M04';
UPDATE missions SET programmed_by = '["Fynn"]', status = 'Prototyping' WHERE id = 'M05';
INSERT INTO programs (program, mission, coded_by, sensors, innovative_bit, sort_order)
VALUES ('Reaching Roots (M05) program', 'M05', '["Fynn"]', '—', 'First M05 program (Oct 12); Isla helped Fynn', 8);

-- Notebook entries
INSERT INTO entries (date, who, component, phase, text, core_values, success, source) VALUES
 ('2026-10-12', '["Adeline"]', 'Robot Design', 'ITERATE', 'Adeline programmed and rebuilt mission 12 (Forest Elder).', '[]', 1, 'update'),
 ('2026-10-12', '["Nolan"]', 'Robot Design', 'ITERATE', 'Nolan rebuilt the attachment for mission 13 (Keystone Species).', '["Teamwork"]', 1, 'update'),
 ('2026-10-12', '["Weston"]', 'Robot Design', 'CREATE', 'Weston built an attachment for mission 11 (Window to the Past), our first one for that mission.', '[]', 1, 'update'),
 ('2026-10-12', '["Fynn","Isla"]', 'Robot Game', 'CREATE', 'Fynn programmed mission 4 (Lucky Leaves) and mission 5 (Reaching Roots). Isla helped Fynn.', '["Teamwork"]', 1, 'update'),
 ('2026-10-12', '["Thea"]', 'Core Values', 'CREATE', 'Thea worked on the team app.', '[]', 1, 'update');

-- Core Values moment: help given / received
INSERT INTO moments (date, value, who, text, help, source, created_at)
VALUES ('2026-10-12', 'Teamwork', '["Isla","Fynn"]', 'Isla helped Fynn program mission 4 (Lucky Leaves) and mission 5 (Reaching Roots).', '["Isla","Fynn"]', 'update', '2026-10-12 12:00:00');
