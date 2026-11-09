-- 2026-11-09 · answer from [who?] · matches PRACTICE-LOG 2026-11-08 (M12 two parts)
-- Raw: "It actually means both. Mission 12 has two parts and we do one part by itself and the second as part of mission 13."
-- Not stored (unclear): which scoring part (cane raised 20 / support tie 10) is in which run.
UPDATE runs SET note = 'Timed by Fynn + Isla · M12 part 1 (part 2 is in run 8)' WHERE run_number = 6;
UPDATE runs SET note = 'Timed by Fynn + Isla · M12 part 2 (part 1 is in run 6)' WHERE run_number = 8;
