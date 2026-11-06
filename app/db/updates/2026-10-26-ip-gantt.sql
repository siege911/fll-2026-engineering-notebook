-- 2026-10-26 · asked by Thea ("for the gantt chart can you fill it out using all the information you have")
-- Matches INNOVATION-PROJECT.md 2026-10-26 "Project Plan (Gantt) filled in from these notes". Rows 8–9 are suggested, dates guessed.
-- Positions = months from Aug 1 (Oct d → 2 + (d-1)/31, Nov d → 3 + (d-1)/30); end = the day after the last day.
INSERT INTO gantt (task, owner, start_pos, end_pos, iterations, source, created_at) VALUES
 ('Choose the camera design', 'Thea', 2.03, 2.10,
  '["Oct 2: idea, AI forest wildlife camera","Oct 3: Option B, Raspberry Pi build","Oct 3: research (Gemini): low-power XIAO camera","Oct 3: XIAO camera + Pi 4 gets the pictures over Wi-Fi","Oct 3: two cameras (house + forest) + mode switch"]', 'update', '2026-10-26 12:00:00'),
 ('Expert interview: Nate Reagan, Game and Fish', 'Whole team', 2.13, 2.16,
  '["Oct 5: wrote 5 questions","Oct 5: met Nate, notes and answers saved"]', 'update', '2026-10-26 12:00:01'),
 ('Buy the camera parts', 'Whole team', 2.06, 2.39,
  '["Oct 3: parts list","Oct 12: parts bought (batteries delayed)"]', 'update', '2026-10-26 12:00:02'),
 ('Wire the camera box', 'Nolan', 2.35, 2.74,
  '["Oct 12: wiring plan v1","Oct 23: Nolan wired it, Thea helped"]', 'update', '2026-10-26 12:00:03'),
 ('Decide what to change from Nate''s advice', 'Whole team', 2.13, 2.84,
  '["Oct 5: open: live stream, bridge or squirrel nest, how many cameras, warning light","Oct 25: people get blurred, and we review photos before publishing","Still open"]', 'update', '2026-10-26 12:00:04'),
 ('Program the camera', 'Thea', 2.74, 2.84,
  '["Oct 24: v1, picture every 2 s + motion sensor","Oct 25: v2, picture changed + motion sensor, saves to microSD","Oct 25: v3, sends photos to the Pi","Not tested on the real camera yet"]', 'update', '2026-10-26 12:00:05'),
 ('Pi Camera Station (with Coach CJ)', 'Whole team', 2.77, 2.84,
  '["Oct 25: collector","Oct 25: tagger (SpeciesNet), blurs people","Oct 25: Camera Station: visits, review, publish by hand","Oct 26: Camera Wi-Fi / House Wi-Fi switch"]', 'update', '2026-10-26 12:00:06'),
 ('Test the camera + Pi for real (suggested)', 'Thea', 2.84, 3.23,
  '["Suggested: dates are a guess, change if needed","First real test: camera v3 → Pi"]', 'update', '2026-10-26 12:00:07'),
 ('Practice our presentation (suggested)', 'Whole team', 3.00, 3.47,
  '["Suggested: dates are a guess, change if needed","Regionals Nov 14"]', 'update', '2026-10-26 12:00:08');
