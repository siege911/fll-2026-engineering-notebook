-- 2026-11-13 (later) — Fix to 2026-11-13b: match the Nate Reagan notes ("We won't get data from Game and Fish, so we get our own"),
-- not "they can't share". Same text as updates/PRESENTATION.md.
UPDATE talk_parts SET say = replace(say, 'and they can''t share their data with us.', 'and we won''t get their data.') WHERE id = 2 AND talk = 'ip';
