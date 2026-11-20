-- 2026-11-20 · sent by [who?]: "I added a folder called "photos" these are updates to all of the pictures. There is a picture of the base robot to add to Robot Design. There are updated pictures of all of the attachments for all of the missions. We also added a Team picture and updated each of the student pictures."
-- Matches PRACTICE-LOG 2026-11-20 "New photos", ROBOT-DESIGN.md 2026-11-20, CORE-VALUES.md (Nov 20 note).
-- Files: originals in ../photos/, smaller copies in app/images/11-20-*.jpg. Old photos kept.
-- Not used: "mission 12a.jpg" is the same file as "mission 14.jpg"; Mission 12 attachment keeps its Nov 2 photo.

-- Robot base + team photo (new settings, shown on Robot Design → The Main Robot and Core Values → Team Profile)
INSERT INTO settings (key, value, note) VALUES
 ('robot_photo', '{"photo":"11-20-robot-base.jpg","date":"2026-11-20","caption":"Our three identical robot bases (built Sep 6 by Thea, Nolan, Weston)"}', 'update 2026-11-20'),
 ('team_photo',  '{"photo":"11-20-team-photo.jpg","date":"2026-11-20","caption":"Rooted Warriors: Adeline, Fynn, Isla, Nolan, Thea, Weston"}', 'update 2026-11-20');

-- New profile pictures
UPDATE team SET photo = '11-20-profile-' || lower(name) || '.jpg' WHERE name IN ('Adeline','Fynn','Isla','Nolan','Thea','Weston');

-- Keep the Nov 2 photos in the versions row (attachment_versions.photo, unused until now)
UPDATE attachment_versions SET photo = '11-2-mission-8-9.jpg' WHERE date = '2026-11-02' AND note LIKE '📷 photo%' AND attachment_id IN (SELECT id FROM attachments WHERE name IN ('Mission 8 attachment','Mission 9 attachment'));
INSERT INTO attachment_versions (attachment_id, date, note, photo)
SELECT id, '2026-11-02', '📷 photo on the mat', photo FROM attachments
WHERE name IN ('Lucky Leaves attachment','Combined 2 + 3 attachment','Mission 12 attachment','Mission 15 attachment','Mission 14 attachment');

-- New photos (final form, one per run)
UPDATE attachments SET photo = '11-20-mission-1.jpg'      WHERE name = 'Drone Survey attachment';
UPDATE attachments SET photo = '11-20-mission-2-3.jpg'    WHERE name = 'Combined 2 + 3 attachment';
UPDATE attachments SET photo = '11-20-mission-4-5.jpg', mission = 'M04 + M05' WHERE name = 'Lucky Leaves attachment';
UPDATE missions    SET attachment = 'Lucky Leaves attachment' WHERE id = 'M05';
UPDATE attachments SET photo = '11-20-mission-6-7-11.jpg' WHERE name IN ('Mission 6 attachment','Mission 7 attachment','Mission 11 attachment');
UPDATE attachments SET photo = '11-20-mission-8-9.jpg'    WHERE name IN ('Mission 8 attachment','Mission 9 attachment');
UPDATE attachments SET photo = '11-20-mission-12b-13.jpg', mission = 'M13 + M12 (cane)' WHERE name = 'Keystone Species (mascot) attachment';
UPDATE attachments SET photo = '11-20-mission-14.jpg'     WHERE name = 'Mission 14 attachment';
UPDATE attachments SET photo = '11-20-mission-15.jpg'     WHERE name = 'Mission 15 attachment';

INSERT INTO attachment_versions (attachment_id, date, note, photo)
SELECT id, '2026-11-20', '📷 final-form photo (run ' ||
  CASE name WHEN 'Drone Survey attachment' THEN '1' WHEN 'Combined 2 + 3 attachment' THEN '2' WHEN 'Lucky Leaves attachment' THEN '3'
            WHEN 'Mission 8 attachment' THEN '4' WHEN 'Mission 9 attachment' THEN '4' WHEN 'Mission 14 attachment' THEN '5'
            WHEN 'Mission 15 attachment' THEN '7' WHEN 'Keystone Species (mascot) attachment' THEN '8' ELSE '9' END || ')', photo
FROM attachments WHERE photo LIKE '11-20-%';
