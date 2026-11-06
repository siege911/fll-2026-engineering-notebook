-- 2026-10-26 · asked by Thea: "I just loged somthing in communication can you take it out and delete it"
-- Removes the share Thea typed in the app (shares id 2, 2026-10-26 23:31:41): Oct 11, "Theas family", who Thea, said "They really liked it."
DELETE FROM shares WHERE id = 2 AND source = 'app' AND shared_with = 'Theas family';
