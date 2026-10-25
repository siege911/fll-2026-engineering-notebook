-- 2026-10-05 · told by a student [who? first name not given] · matches PRACTICE-LOG 2026-10-05 "Innovation Project: expert meeting with Nate Reagan" (questions section)
-- Experts card: the questions we asked, each with the answer from our notes.
ALTER TABLE experts ADD COLUMN questions TEXT DEFAULT '[]';   -- JSON array of {q, a}

UPDATE experts SET questions = '[
 {"q":"How many big crashes happen every year in Flagstaff, with the animals?","a":"About 300 animal strikes in a year."},
 {"q":"Another one of our ideas is to make the camera send a blinking light to warn drivers that there is an animal crossing.","a":"A camera with a flashing light has been done before."},
 {"q":"Do you ever use live stream cameras?","a":"Yes, they have a live stream to watch the animals. For our camera: not using a live stream prevents bad stuff."},
 {"q":"How long does it usually take for animals to figure out if a new bridge is safe, and to know the bridge is there for them, with big animals?","a":"The animals go where their mom goes, so if their mom goes on the bridge, they will. (No time given.)"},
 {"q":"For the big new overpass being built on the I-17 at Willard Springs, how are you planning to count the animals? Regular trail cameras from the store, or special expensive equipment?","a":"There might be one camera on the bridge, but he is not sure."}
]' WHERE name = 'Nate Reagan';

INSERT INTO entries (date, who, component, phase, text, core_values, success, source)
VALUES ('2026-10-05', '["Whole team"]', 'Innovation Project', 'RESEARCH',
 'We brought 5 questions for Nate Reagan (Game and Fish): how many animal crashes happen in Flagstaff, our blinking warning light idea, live stream cameras, how long animals take to trust a new bridge, and how they will count animals on the new I-17 overpass at Willard Springs. New idea: the camera makes a blinking light to warn drivers about an animal crossing (Nate said it has been done before).',
 '["Discovery","Innovation"]', 0, 'update');
