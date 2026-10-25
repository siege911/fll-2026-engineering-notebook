-- 2026-09-28 — profile pictures for the Team Profile cards.
-- Told by: a student (first name not given), who added the photos to app/images/ as "profile <name>.jpg".
-- Markdown: updates/CORE-VALUES.md (Team profile cards, Sep 28 note), updates/APP-CHANGES.md 2026-09-28.
-- photo = file name inside app/images/ (served at /images/<file>).
ALTER TABLE team ADD COLUMN photo TEXT;
UPDATE team SET photo = 'profile thea.jpg'    WHERE name = 'Thea';
UPDATE team SET photo = 'profile fynn.jpg'    WHERE name = 'Fynn';
UPDATE team SET photo = 'profile isla.jpg'    WHERE name = 'Isla';
UPDATE team SET photo = 'profile adeline.jpg' WHERE name = 'Adeline';
UPDATE team SET photo = 'profile nolan.jpg'   WHERE name = 'Nolan';
UPDATE team SET photo = 'profile weston.jpg'  WHERE name = 'Weston';
