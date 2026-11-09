-- 2026-11-09 · answer from [who?] · matches PRACTICE-LOG 2026-11-08 (M12 two parts)
-- Raw: "Support tie (10)" → run 6 (M12 alone) = support tie around the post, 10 pts; run 8 (M13 + M12) = cane raised touching the tree, 20 pts.
ALTER TABLE runs ADD COLUMN part_points TEXT DEFAULT '{}';   -- JSON {mission id: points} when a run only does part of a mission
UPDATE runs SET part_points = '{"M12":10}', note = 'Timed by Fynn + Isla · M12 part 1: support tie around the post (cane is in run 8)' WHERE run_number = 6;
UPDATE runs SET part_points = '{"M12":20}', note = 'Timed by Fynn + Isla · M12 part 2: cane raised to the tree (support tie is in run 6)' WHERE run_number = 8;
