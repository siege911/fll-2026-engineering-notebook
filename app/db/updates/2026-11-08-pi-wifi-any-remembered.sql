-- 2026-11-08 — Pi Camera Station: 🌐 House Wi-Fi now joins any remembered Wi-Fi in range.
-- Told by: the team (session at the office; [who?]). Markdown: updates/CAMERA-BUILD.md (2026-11-08 entry), DECISIONS.md 2026-11-08.
UPDATE ip_platforms
SET version = 'Station v1 (Oct 25) + Wi-Fi switch (Oct 26, any remembered Wi-Fi Nov 8)',
    updated = '2026-11-08'
WHERE id = 'pi';
