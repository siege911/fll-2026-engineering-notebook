-- 2026-09-28 — Isla's favorite color: Pink → Red, so her Team Profile ring is red too (it is colored from fav_color).
-- Told by: Thea ("islas color is not red could you try again" — she was looking at the pink ring on the profile card).
-- Markdown: updates/CORE-VALUES.md (Team profile cards, Sep 28 note), updates/APP-CHANGES.md 2026-09-28.
UPDATE team SET fav_color = 'Red' WHERE name = 'Isla';
