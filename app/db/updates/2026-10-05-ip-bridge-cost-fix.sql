-- 2026-10-05 · told by Adeline and Thea · matches PRACTICE-LOG 2026-10-05 "Innovation Project: expert meeting with Nate Reagan"
-- The I-17 wildlife bridge cost $24 million, not billion (corrected by Adeline and Thea).
UPDATE experts SET notes = json_set(notes, '$[1]', 'The I-17 wildlife bridge cost $24 million and is supposed to reduce collisions by 90%')
WHERE name = 'Nate Reagan' AND json_extract(notes, '$[1]') LIKE '%$24 billion%';
