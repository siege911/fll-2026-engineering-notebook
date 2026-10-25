-- 2026-09-28 — Isla's color: brown → pink (avatar color + favorite color).
-- Told by: Thea. Markdown: updates/CORE-VALUES.md (Team profile cards, Sep 28 note), updates/APP-CHANGES.md 2026-09-28.
-- #ec4899 = the app's "pink" (same shade the favorite-color ring uses), a bit darker than Adeline's light pink #f472b6.
UPDATE team SET color = '#ec4899', fav_color = 'Pink' WHERE name = 'Isla';
