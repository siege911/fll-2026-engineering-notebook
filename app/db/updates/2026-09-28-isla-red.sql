-- 2026-09-28 — Isla's app color: pink → red (avatar color only; favorite color stays "Pink").
-- Told by: Thea. Markdown: updates/CORE-VALUES.md (Team profile cards, Sep 28 note), updates/APP-CHANGES.md 2026-09-28.
-- #e3000b = the app's "red".
UPDATE team SET color = '#e3000b' WHERE name = 'Isla';
