-- 2026-10-05 · told by Adeline and Thea · matches PRACTICE-LOG 2026-10-05 "Innovation Project: expert meeting with Nate Reagan"
-- The ~300 animal strikes a year are on I-17 only.
UPDATE experts SET
  notes = json_set(notes, '$[0]', 'About 300 animal strikes in a year on I-17'),
  questions = json_set(questions, '$[0].a', 'About 300 animal strikes in a year, on I-17.')
WHERE name = 'Nate Reagan';
UPDATE research SET note = replace(note, '~300 animal strikes a year;', '~300 animal strikes a year on I-17;') WHERE source LIKE 'Nate Reagan%';
UPDATE entries SET text = replace(text, 'There are about 300 animal strikes in a year,', 'There are about 300 animal strikes in a year on I-17,')
WHERE date = '2026-10-05' AND text LIKE 'We met our first expert, Nate Reagan%';
