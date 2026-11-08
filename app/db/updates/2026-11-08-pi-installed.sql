-- 2026-11-08 — The Camera Station is installed and running on the real Pi (its touchscreen showed the Wi-Fi switch at the office).
-- Told by: [who?]. Markdown: updates/CAMERA-BUILD.md 2026-11-08 "Pi: 🌐 House Wi-Fi joins any Wi-Fi it remembers".
UPDATE ip_platforms
SET status = 'Installed on the Pi (Nov 8) · camera Wi-Fi not made yet, camera not connected yet'
WHERE id = 'pi';
