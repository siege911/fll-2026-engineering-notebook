-- 2026-10-05 · told by a student [who? first name not given] · matches PRACTICE-LOG 2026-10-05 "Innovation Project: expert meeting with Nate Reagan (Arizona Game and Fish)"
-- The team has a real expert and real research now, so the sample (GlowCast) experts and research rows come out.
DELETE FROM experts WHERE sample = 1;
DELETE FROM research WHERE sample = 1;

-- Experts card: when we met them, who met them, and the full list of what we learned.
ALTER TABLE experts ADD COLUMN date TEXT;
ALTER TABLE experts ADD COLUMN met_by TEXT;
ALTER TABLE experts ADD COLUMN notes TEXT DEFAULT '[]';   -- JSON array

INSERT INTO experts (name, role, face, feedback, improvement, date, met_by, notes, sample)
VALUES ('Nate Reagan', 'Arizona Game and Fish Department', '🦌',
 'Don''t live stream: that prevents bad stuff. Use AI to blur out any people. Cameras over a wide area work best. Get our own data, and ask ADOT before using the I-17 wildlife bridge.',
 'Still deciding: live stream or not, the wildlife bridge or the squirrel nest (backup), one camera or several.',
 '2026-10-05', 'Whole team',
 '["About 300 animal strikes in a year","The I-17 wildlife bridge is supposed to reduce collisions by 90% (cost: \"$24 billion\", probably million, checking)","Baby animals go where their mom goes, so if the mom uses the bridge, they will too","GPS collars on elk: they tranquilize them to put collars on; the battery lasts 3 years, then the collar falls off","Game and Fish has a live stream to watch the animals","There might be one camera on the bridge (he is not sure)","A camera with a flashing light has been done before","Officers use satellite cameras that send a notification to your phone","Not using a live stream prevents bad stuff from happening","We could use AI to blur out any human","We won''t get data from Game and Fish, so we get our own","We need ADOT''s permission to use the bridge","Backup: put the camera on the squirrel nest and track that","Cameras in a wide perimeter would be the most effective","Thermal goggles to see animals at night","Not a lot of AI; drones for law-enforcement investigations"]',
 0);

INSERT INTO research (source, type, found_by, note, sample)
VALUES ('Nate Reagan, Arizona Game and Fish — interview', 'Expert', 'Whole team',
 '~300 animal strikes a year; the I-17 wildlife bridge should cut collisions 90%. Game and Fish use GPS collars, thermal goggles, satellite cameras and drones, not much AI.', 0);

INSERT INTO entries (date, who, component, phase, text, core_values, success, source)
VALUES ('2026-10-05', '["Whole team"]', 'Innovation Project', 'RESEARCH',
 'We met our first expert, Nate Reagan from Arizona Game and Fish. There are about 300 animal strikes in a year, and the I-17 wildlife bridge is supposed to reduce collisions by 90%. Baby animals follow their mom across. He said not to live stream, to use AI to blur out people, and that cameras over a wide area work best. We need ADOT''s permission to use the bridge; if that doesn''t work out, we could watch the squirrel nest.',
 '["Discovery"]', 1, 'update');
