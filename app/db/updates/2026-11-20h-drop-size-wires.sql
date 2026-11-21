-- 2026-11-20 · student [who?]: "for the main robot in size, just get rid of that column and the wire management"
-- matches updates/ROBOT-DESIGN.md 2026-11-20 (Size + Wire management taken off the Main Robot card). Both were still blank.
DELETE FROM robot_specs WHERE label IN ('Size (W × D)', 'Wire management');
