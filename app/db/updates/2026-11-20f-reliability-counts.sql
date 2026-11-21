-- 2026-11-20 · told by Thea · matches PRACTICE-LOG "2026-11-20 — Test counts: M11, M12, M13, M14, M15" + ROBOT-GAME.md 2026-11-20
-- Raw: "Windows in the past 3 out of 5, Forest Elder 3/5, Keystone Species 2/5, Seeds of Renewal 2/5, Biocentric Architecture 3/5"
-- Test date and testers not given: logged 2026-11-20, who = [who?] in markdown.

UPDATE missions SET reliability = 60 WHERE id = 'M11';
UPDATE missions SET reliability = 60 WHERE id = 'M12';
UPDATE missions SET reliability = 40 WHERE id = 'M13';
UPDATE missions SET reliability = 40 WHERE id = 'M14';
UPDATE missions SET reliability = 60 WHERE id = 'M15';
UPDATE missions SET aka = '"Windows in the past"' WHERE id = 'M11' AND (aka IS NULL OR aka = '');

INSERT INTO tests (date, attachment, tries, successes, observed, changed, result, source) VALUES
 ('2026-11-20', 'Mission 11 attachment', 5, 3, 'M11 Window to the Past worked 3 out of 5 times.', '', '60%', 'update'),
 ('2026-11-20', 'Mission 12 attachment', 5, 3, 'M12 Forest Elder worked 3 out of 5 times.', '', '60%', 'update'),
 ('2026-11-20', 'Keystone Species (mascot) attachment', 5, 2, 'M13 Keystone Species worked 2 out of 5 times.', '', '40%', 'update'),
 ('2026-11-20', 'Mission 14 attachment', 5, 2, 'M14 Seeds of Renewal worked 2 out of 5 times (was 5 out of 5 on Oct 2).', '', '40%', 'update'),
 ('2026-11-20', 'Mission 15 attachment', 5, 3, 'M15 Biocentric Architecture worked 3 out of 5 times.', '', '60%', 'update');

INSERT INTO entries (date, who, component, phase, text, core_values, success, source, sample) VALUES
 ('2026-11-20', '["Whole team"]', 'Robot Game', 'ITERATE',
  'We counted tries, 5 each: Window to the Past 3/5, Forest Elder 3/5, Keystone Species 2/5, Seeds of Renewal 2/5, Biocentric Architecture 3/5.',
  '[]', 0, 'update', 0);
