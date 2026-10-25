-- 2026-10-02 · told by a student [who? first name not given] · matches PRACTICE-LOG 2026-10-02 "Practice, second update: Adeline, Nolan, Weston"
-- Raw: "october 2 adeline finished programing mission 15 and 12 and nolan programed 2 and 3 he got 5/5 times in his tests. weston worked on building the attachments for the tree mission"
UPDATE missions SET programmed_by = json_insert(programmed_by, '$[#]', 'Adeline') WHERE id IN ('M12', 'M15');
UPDATE programs  SET coded_by      = json_insert(coded_by,      '$[#]', 'Adeline') WHERE mission IN ('M12', 'M15');

UPDATE missions SET programmed_by = json_insert(programmed_by, '$[#]', 'Nolan'), status = 'Working', reliability = 100 WHERE id IN ('M02', 'M03');
INSERT INTO programs (program, mission, coded_by, sensors, innovative_bit, sort_order)
VALUES ('Exploding Seeds + Flip the Rock (M02 + M03) program', 'M02', '["Nolan"]', '—',
 'Nolan''s first program, for his combined 2 + 3 attachment (Oct 2) — tested 5/5', 7);

INSERT INTO tests (date, attachment, tries, successes, observed, changed, result, source)
VALUES ('2026-10-02', 'Combined 2 + 3 attachment', 5, 5, 'Nolan programmed missions 2 and 3 and tested them: 5 out of 5 worked.', '', '100%', 'update');

INSERT INTO entries (date, who, component, phase, text, core_values, success, source) VALUES
 ('2026-10-02', '["Adeline"]', 'Robot Design', 'CREATE', 'Adeline finished programming mission 15 (Biocentric Architecture) and mission 12 (Forest Elder).', '["Teamwork"]', 1, 'update'),
 ('2026-10-02', '["Nolan"]', 'Robot Game', 'ITERATE', 'Nolan programmed missions 2 and 3 (Exploding Seeds + Flip the Rock) and got 5/5 in his tests.', '[]', 1, 'update'),
 ('2026-10-02', '["Weston"]', 'Robot Design', 'CREATE', 'Weston worked on building the attachments for the tree mission.', '[]', 1, 'update');
