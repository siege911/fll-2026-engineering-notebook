-- 2026-11-15 — Camera v4: restarts by itself if stuck, checks pictures, sends one at a time.
-- Pi station: drops a send that stalls for 30 s, refuses pictures that aren't whole.
-- Told by: [who?] (troubleshooting: camera 1 froze for good after joining the Pi's Wi-Fi).
-- Markdown: updates/CAMERA-BUILD.md 2026-11-15 "Camera 1 freezes" + "Camera v4".
UPDATE ip_platforms
SET version = 'Camera v4 (Nov 15)',
    status = 'v3 froze while sending to the Pi (Nov 15) · v4 compiles, restarts itself if stuck · not on the real camera yet · 1 of 2 cameras works',
    files = '[{"path":"camera/camera-v4/camera-v4.ino","what":"The camera program"},{"path":"camera/camera-v4/secrets.example.h","what":"Copy to secrets.h: camera Wi-Fi, the Pi''s address, the camera key (the real secrets.h stays on the laptop)"},{"path":"camera/camera-v3/camera-v3.ino","what":"Older: v3 (Oct 25), sends to the Pi, could freeze while sending"},{"path":"camera/camera-v2/camera-v2.ino","what":"Older: v2 (Oct 25), saves to microSD, the Pi pulls pictures"},{"path":"camera/camera-v1/camera-v1.ino","what":"Older: v1 (Oct 24), live view + motion sensor"}]',
    updated = '2026-11-15'
WHERE id = 'esp32';

UPDATE ip_platforms
SET updated = '2026-11-15'
WHERE id = 'pi';
