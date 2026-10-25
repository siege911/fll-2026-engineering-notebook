-- 2026-10-02 · told by a student [who? first name not given] · matches PRACTICE-LOG 2026-10-02 "Practice: first test session (M14)"
-- Raw: "october 2 fynn programed mission 14 and got 5/5 in her tests"
INSERT INTO tests (date, attachment, tries, successes, observed, changed, result, source)
VALUES ('2026-10-02', 'Mission 14 attachment', 5, 5, 'Fynn programmed M14 and tested it: 5 out of 5 worked.', '', '100% — first test session of the season', 'update');

UPDATE missions SET status = 'Working', reliability = 100 WHERE id = 'M14';

INSERT INTO entries (date, who, component, phase, text, core_values, success, source)
VALUES ('2026-10-02', '["Fynn"]', 'Robot Game', 'ITERATE',
 'Fynn programmed mission 14 (Seeds of Renewal) and got 5/5 in the tests. Our first test session!',
 '[]', 1, 'update');
