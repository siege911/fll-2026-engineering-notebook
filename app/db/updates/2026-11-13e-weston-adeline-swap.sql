-- 2026-11-13 (round 4) — Judging talk. Asked by: [who? typed in Claude Code]: "switch westons improvements with adelines sharing"
-- Same as updates/PRESENTATION.md (2026-11-13 round 4). Innovation talk part ids: 8 = sharing, 9 = improvements.
UPDATE talk_parts SET speaker = 'Weston' WHERE id = 8 AND talk = 'ip';
UPDATE talk_parts SET speaker = 'Adeline' WHERE id = 9 AND talk = 'ip';
