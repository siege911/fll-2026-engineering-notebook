-- 2026-10-23 · asked by Thea · see DECISIONS 2026-10-23 "Profile-picture rings" and CORE-VALUES Oct 23
-- Raw: "and for fynns color around the picture make it a lighter pretty yellow" → picked "Lemon Chiffon for Fynn"
-- New column: ring color around the Team Profile picture (empty = use the teammate's app color)
ALTER TABLE team ADD COLUMN ring_color TEXT;
UPDATE team SET ring_color = '#fbe89a' WHERE name = 'Fynn';
