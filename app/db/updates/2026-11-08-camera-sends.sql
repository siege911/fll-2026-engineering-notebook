-- 2026-11-08 (later) — Camera v3 works on a real camera: joins the Pi's Wi-Fi, saves to microSD, sends to the Pi. One of the two built cameras works.
-- Told by: [who?]. Markdown: updates/CAMERA-BUILD.md 2026-11-08 (later) "Camera sends to the Pi".
UPDATE ip_platforms
SET status = 'Works on a real camera (Nov 8): joins the Pi, saves to microSD, sends · 1 of 2 cameras works',
    updated = '2026-11-08'
WHERE id = 'esp32';
UPDATE ip_platforms
SET status = 'Installed on the Pi (Nov 8) · camera connected · Live page + tagger error being fixed'
WHERE id = 'pi';
