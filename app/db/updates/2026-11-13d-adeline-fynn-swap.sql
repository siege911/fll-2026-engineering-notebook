-- 2026-11-13 (latest) — Judging talk, third round. Asked by: [who? typed in Claude Code]: "switch adelines pride and enthusiasm with fynns research."
-- Same text as updates/PRESENTATION.md (2026-11-13 latest). Innovation talk part ids: 3 = research, 9 = improvements, 11 = pride & enthusiasm.
UPDATE talk_parts SET speaker = 'Adeline' WHERE id = 3 AND talk = 'ip';
UPDATE talk_parts SET speaker = 'Fynn' WHERE id = 11 AND talk = 'ip';
-- Weston's line named Fynn as the researcher; the Oct 3 Gemini research was Thea + Coach CJ (updates/INNOVATION-PROJECT.md).
UPDATE talk_parts SET say = replace(say, 'After Fynn''s research, we switched', 'After our research, we switched') WHERE id = 9 AND talk = 'ip';
