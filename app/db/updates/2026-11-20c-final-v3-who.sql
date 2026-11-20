-- 2026-11-20 · follow-up to 2026-11-20b · matches PRACTICE-LOG "2026-11-18 + 2026-11-19 — Robot code: Final v3", ROBOT-CODE.md + ROBOT-DESIGN.md 2026-11-20.
-- Raw: "Fynn and Isla did most of the work."

UPDATE settings SET value = json_set(value, '$."2026-11-18"', json('["Fynn","Isla"]')) WHERE key = 'robot_code_who';

UPDATE entries SET who = '["Fynn","Isla"]'
 WHERE date = '2026-11-18' AND source = 'update' AND text LIKE 'Last fine-tuning before Regionals, saved as Final v3%';

UPDATE missions SET programmed_by = json_insert(programmed_by, '$[#]', 'Isla')
 WHERE id IN ('M01','M02','M03','M08','M09','M14') AND programmed_by NOT LIKE '%"Isla"%';
UPDATE programs SET coded_by = json_insert(coded_by, '$[#]', 'Isla')
 WHERE mission IN ('M01','M02','M03','M08','M09','M14') AND coded_by NOT LIKE '%"Isla"%';
