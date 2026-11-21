-- 2026-11-20 · student [who?]: "There are a lot of emojis throughout the entire app. Can you get rid of all of them?"
-- matches updates/APP-CHANGES.md 2026-11-20 "Emojis removed from the whole app". Wording only, no facts change.
-- team.face, experts.face and ip_platforms.icon are kept but the page no longer shows them.
UPDATE attachment_versions SET note = REPLACE(REPLACE(note, ' ✅', ''), '✅', '') WHERE note LIKE '%✅%';
UPDATE attachment_versions SET note = REPLACE(note, '📷 ', '') WHERE note LIKE '%📷%';
UPDATE robot_specs SET value = REPLACE(value, ' ✅', '') WHERE value LIKE '%✅%';
UPDATE ip_platforms SET files = REPLACE(REPLACE(files, '📡 ', ''), '🌐 ', '') WHERE id = 'pi';
