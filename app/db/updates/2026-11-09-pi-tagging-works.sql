-- 2026-11-09 — The Pi tagged every camera photo with no crashes after switching to CPU-only PyTorch.
-- Told by: [who?]. Markdown: updates/CAMERA-BUILD.md 2026-11-09 "AI crashes (SIGILL)".
UPDATE ip_platforms
SET status = 'Working on the Pi (Nov 9): camera → Pi → AI tagging, no crashes · first real animal still to come',
    updated = '2026-11-09'
WHERE id = 'pi';
