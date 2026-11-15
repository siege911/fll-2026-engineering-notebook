-- 2026-11-15 · told by Coach CJ · matches PRACTICE-LOG 2026-11-15 (notes), 2026-11-14, 2026-11-13, 2026-11-09
-- Raw (short): "Thea's brother ... developed a custom circuit board and is willing to help the team. Isla and Fynn got the Solar Panels working yesterday.
--   We did a practice yesterday which focused on Innovation Project and building our display trifold board materials ...
--   Monday - 6, 7, 14 and a little bit of 2 & 3 - The rest were just tested and tested as working well. Friday - Finished 2 & 3 and worked on 8 & 9 ...
--   We still haven't done a full timed run through of the whole board yet. The ADOT contact occurred a while ago ... we have the paperwork needed.
--   The bridge current cost is at $21 million." Also: "It's spelled Ragan."
-- Not stored (unclear): date we shared with Thea's brother; date of the ADOT talk; who else came to each practice; tries/successes on Nov 9.

-- Spelling: Nate Ragan (was "Reagan")
UPDATE experts  SET name = replace(name,'Reagan','Ragan'), feedback = replace(feedback,'Reagan','Ragan'), improvement = replace(improvement,'Reagan','Ragan'), notes = replace(notes,'Reagan','Ragan');
UPDATE research SET source = replace(source,'Reagan','Ragan'), note = replace(note,'Reagan','Ragan');
UPDATE shares   SET shared_with = replace(shared_with,'Reagan','Ragan'), what_they_said = replace(what_they_said,'Reagan','Ragan'), what_we_changed = replace(what_we_changed,'Reagan','Ragan');
UPDATE gantt    SET task = replace(task,'Reagan','Ragan'), iterations = replace(iterations,'Reagan','Ragan');
UPDATE entries  SET text = replace(text,'Reagan','Ragan') WHERE text LIKE '%Reagan%';

-- Communication: two more people/groups (dates unknown → left empty, shown as "—")
INSERT INTO shares (date, shared_with, who, what_they_said, what_we_changed, source, created_at) VALUES
 (NULL, 'Thea''s older brother', '["Whole team"]',
  'He developed his own custom circuit board last year. He suggested we build our own circuit board, and he is willing to help us with the next version.',
  'Next camera version: our own circuit board, with his help (planned).', 'update', '2026-11-15 12:00:00'),
 (NULL, 'ADOT District Administrator, Northcentral District (Coach CJ talked to them)', '["Whole team"]',
  'We have the paperwork needed to ask to put our camera on the Willard Springs wildlife bridge.',
  'Coach CJ is filling out the paperwork. Bridge cost: $21 million (ADOT''s current projection).', 'update', '2026-11-15 12:00:01');

-- Gantt: solar panels, trifold, ADOT
INSERT INTO gantt (task, owner, start_pos, end_pos, iterations, source, created_at) VALUES
 ('Solar panels (Isla + Fynn)', 'Isla', 2.35, 3.45, '["Oct 12: solar parts bought","Nov 14: Isla and Fynn got the solar panels working"]', 'update', '2026-11-15 12:00:02'),
 ('Trifold boards (Thea + Adeline)', 'Thea', 3.23, 3.45, '["Nov 8: Thea and Adeline started the trifold boards","Nov 14: practice on the display trifold materials"]', 'update', '2026-11-15 12:00:03'),
 ('ADOT permission for the bridge (Coach CJ)', 'Whole team', 2.13, 3.5, '["Oct 5: Nate said we need ADOT''s OK","Coach CJ talked to the Northcentral District Administrator (date?)","Nov 15: we have the paperwork needed"]', 'update', '2026-11-15 12:00:04');

-- Attachments: Fynn's fine-tuning (ids: 5 = Combined 2+3, 9 = M14, 10 = M08, 12 = M09, 13 = M06, 14 = M07)
INSERT INTO attachment_versions (attachment_id, date, note) VALUES
 (13, '2026-11-09', 'fine-tuned, final form (Fynn)'),
 (14, '2026-11-09', 'fine-tuned, final form (Fynn)'),
 (9,  '2026-11-09', 'fine-tuned, final form (Fynn)'),
 (5,  '2026-11-09', 'started fine-tuning (Fynn)'),
 (5,  '2026-11-13', 'finished fine-tuning, final form (Fynn)'),
 (10, '2026-11-13', 'worked on (Fynn)'),
 (12, '2026-11-13', 'worked on (Fynn)');

-- Missions: everything tested working on Nov 9 (from memory; reliability % unchanged, no counts)
UPDATE missions SET status = 'Working' WHERE status = 'Prototyping';

-- Run plan: still no full timed run-through
UPDATE runs SET note = note || ' · not timed in a full run yet (Nov 15)' WHERE timed_on IS NULL;

-- Notebook entries
INSERT INTO entries (date, who, component, phase, text, core_values, success, source) VALUES
 ('2026-11-09', '["Fynn"]', 'Robot Design', 'ITERATE', 'Fynn fine-tuned the attachments for Missions 6, 7 and 14, and a little of the 2 + 3 attachment. All the other missions were tested and worked well. (Coach CJ, from memory)', '[]', 1, 'update'),
 ('2026-11-13', '["Fynn"]', 'Robot Design', 'ITERATE', 'Fynn finished fine-tuning the 2 + 3 attachment and worked on the 8 + 9 attachment. Every attachment should now be in its final form. Still to do: a full timed run of the whole board.', '[]', 1, 'update'),
 ('2026-11-14', '["Isla","Fynn"]', 'Innovation Project', 'CREATE', 'Isla and Fynn got the solar panels working!', '[]', 1, 'update'),
 ('2026-11-14', '["Whole team"]', 'Innovation Project', 'COMMUNICATE', 'Practice focused on the Innovation Project and building our display trifold board materials for the competition.', '["Teamwork"]', 0, 'update'),
 ('2026-11-15', '["Whole team"]', 'Innovation Project', 'ITERATE', 'We shared our camera with Thea''s older brother. He developed his own custom circuit board and is willing to help us build ours. Coach CJ talked to the ADOT District Administrator for the Northcentral District, and we have the paperwork needed to ask for the bridge. (Dates not known.)', '[]', 0, 'update');
