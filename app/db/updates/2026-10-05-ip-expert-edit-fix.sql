-- 2026-10-05 · told by Adeline and Thea · matches PRACTICE-LOG 2026-10-05 "Innovation Project: expert meeting with Nate Reagan"
-- "AI to end the video" in the meeting notes meant "edit" (confirmed by Adeline and Thea).
UPDATE experts SET notes = json_set(notes, '$[9]', 'We could use AI to edit the video or blur out any human'),
  feedback = 'Don''t live stream: that prevents bad stuff. Use AI to edit the video or blur out any people. Cameras over a wide area work best. Get our own data, and ask ADOT before using the I-17 wildlife bridge.'
WHERE name = 'Nate Reagan' AND json_extract(notes, '$[9]') = 'We could use AI to blur out any human';
