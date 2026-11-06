-- 2026-11-02 · sent by a student [who?]: "these are the photos of the attachments with the missions. put these in the app"
-- Matches PRACTICE-LOG 2026-11-02 "Attachment photos sent" and ROBOT-DESIGN.md 2026-11-02. Mission per photo answered by the student.
-- New column: the attachment's current photo (file name inside app/images/), shown on its card in Robot Design → Attachments Over Time.
ALTER TABLE attachments ADD COLUMN photo TEXT;

UPDATE attachments SET photo = '11-2-mission-15.jpg'  WHERE name = 'Mission 15 attachment';
UPDATE attachments SET photo = '11-2-mission-12.jpg'  WHERE name = 'Mission 12 attachment';
UPDATE attachments SET photo = '11-2-mission-14.jpg'  WHERE name = 'Mission 14 attachment';
UPDATE attachments SET photo = '11-2-mission-8-9.jpg' WHERE name IN ('Mission 8 attachment', 'Mission 9 attachment'); -- one attachment does both
UPDATE attachments SET photo = '11-2-mission-2-3.jpg' WHERE name = 'Combined 2 + 3 attachment';
UPDATE attachments SET photo = '11-2-mission-4.jpg'   WHERE name = 'Lucky Leaves attachment';

-- New fact: one attachment does both M08 and M09
INSERT INTO attachment_versions (attachment_id, date, note)
SELECT id, '2026-11-02', '📷 photo: one attachment does both M08 + M09' FROM attachments WHERE name IN ('Mission 8 attachment', 'Mission 9 attachment');
