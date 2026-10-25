-- Rooted Warriors — baseline data, as of the 2026-09-25 practice.
-- Generated 2026-09-28 from mockups/14-rooted-warriors-app-v4.html (its in-page data and the facts written into its HTML).
-- Every real fact here is also in the markdown record: updates/*.md, DECISIONS.md, PROGRESS.md.
-- Rows with sample = 1 (and settings noted "SAMPLE") are made-up placeholders from the v2 mockup.
-- Do not edit to record new practices — add a dated file in db/updates/ instead (see app/README.md).

-- Team (profile cards entered by Thea 2026-09-04; Role/Learned/Worked with most/Notebook entries blanked 2026-09-19 for each teammate to fill in)
INSERT INTO team (name, color, face, role, fav_value, fav_color, worked_on_most, learned, worked_with_most, notebook_entries, sort_order) VALUES
 ('Thea', '#b48fd9', '🫠', '', 'Fun', 'Lavender purple', 'Innovation Project', '', '', '', 1),
 ('Fynn', '#e9c631', '🤪', '', 'Fun', 'Light yellow', 'Programming', '', '', '', 2),
 ('Isla', '#8b5a2b', '💩', '', 'Fun', 'Brown', 'Team games & presentation', '', '', '', 3),
 ('Adeline', '#f472b6', '😏', 'Programmer', 'Fun', 'Light pink', 'Programming', '', '', '', 4),
 ('Nolan', '#20b5c9', '😂', '', 'Teamwork', 'Teal', 'Attachments', '', '', '', 5),
 ('Weston', '#3f9b4c', '😁', '', 'Teamwork', 'Green', 'Building', '', '', '', 6);

-- Official BIOGLOW missions (06-missions-bioglow.md) + build/program progress through 2026-09-25 (updates/ROBOT-GAME.md)
INSERT INTO missions (id, name, aka, max_points, how_it_scores, no_equipment, difficulty, run_number, attachment, built_by, programmed_by, reliability, status, est_seconds) VALUES
 ('M01', 'Drone Survey', '', 30, 'Drone off the mat 20 · +10 if LiDAR map flipped w/ scan marker in survey area', 1, 0, 1, 'Drone Survey attachment', '["Isla"]', '["Adeline"]', 0, 'Prototyping', 30),
 ('M02', 'Exploding Seeds', '"Mission 2" · "number 2"', 30, '10 per seed off the stalk (3 seeds)', 0, 0, 2, 'Mission 2 attachment · Combined 2+3', '["Adeline","Nolan"]', '[]', 0, 'Working', 30),
 ('M03', 'Flip the Rock', '"Mission 3"', 30, 'Research flag down 20 · +10 if rock back in start position', 0, 0, 2, 'Flip the Rock attachment · Combined 2+3', '["Nolan"]', '[]', 0, 'Prototyping', 30),
 ('M04', 'Lucky Leaves', '"mission 4"', 30, '1st leaf out 10 · +20 for 2nd leaf if katydid stays put · katydid out of habitat = 0', 1, 0, 3, 'Lucky Leaves attachment', '["Fynn"]', '["Adeline"]', 0, 'Prototyping', 30),
 ('M05', 'Reaching Roots', '', 20, 'Plant root partly extended 10 OR fully extended 20', 1, 0, NULL, '—', '[]', '[]', 0, 'Not started', 30),
 ('M06', 'Leafcutter Frenzy', '', 40, 'Ant touching nest + 10 per leaf fragment inside (4 fragments)', 0, 0, NULL, '—', '[]', '[]', 0, 'Not started', 30),
 ('M07', 'Humongous Fungus', '', 30, 'Mycelium fully extended 20 · +10 if other team''s plant root is fully extended too', 1, 0, NULL, '—', '[]', '[]', 0, 'Not started', 30),
 ('M08', 'Tangled', '"number 8"', 30, 'Vine touching the mat 30', 0, 0, 8, 'Mission 8 attachment', '["Nolan"]', '[]', 0, 'Prototyping', 30),
 ('M09', 'Research Platform', '', 30, 'Platform raised 10 · camera trap deployed 10 · seed off the tree 10', 1, 0, NULL, '—', '[]', '[]', 0, 'Not started', 30),
 ('M10', 'Fragile Microhabitats', '', 20, 'Spider habitat untouched 10 · snail habitat untouched 10 (don''t bump them!)', 1, 0, NULL, '—', '[]', '[]', 0, 'Not started', 30),
 ('M11', 'Window to the Past', '', 20, 'Root cover down, touching the mat 20', 0, 0, NULL, '—', '[]', '[]', 0, 'Not started', 30),
 ('M12', 'Forest Elder', '"Mission 12" · "the forest elder"', 30, 'Cane raised & touching tree 20 · support tie around post 10', 1, 0, 4, 'Mission 12 attachment', '["Fynn","Isla"]', '["Isla","Fynn","Thea"]', 0, 'Prototyping', 30),
 ('M13', 'Keystone Species', '"the mascot mission"', 30, 'Our own keystone species on the platform + young trees raised 30 (build it from bag 20)', 0, 0, 5, 'Keystone Species (mascot) attachment', '["Thea"]', '[]', 0, 'Working', 30),
 ('M14', 'Seeds of Renewal', '"number 14"', 30, '5 per seed in the replantation station · +5 each if touching the mat (3 seeds)', 0, 0, 6, 'Mission 14 attachment', '["Weston"]', '["Fynn"]', 0, 'Prototyping', 30),
 ('M15', 'Biocentric Architecture', '"mission 15"', 40, 'Nesting canopy 10 · garden skylight 10 · compost hatch 10 · +10 for the one your dock needs', 1, 0, 7, 'Mission 15 attachment', '["Isla"]', '["Isla"]', 0, 'Prototyping', 30);

INSERT INTO scoring_extras (name, max_points, how) VALUES
 ('Equipment Inspection', 20, 'Robot + all equipment fits in one launch area, under 12 in tall'),
 ('Precision Tokens', 50, 'Start with 6 · lose one each time you touch the robot outside home · 6 or 5 left = 50, 4 = 35, 3 = 25, 2 = 15, 1 = 10');

-- DRAFT run plan: every time is a 30 s guess. Sep 11 = 155 s, Sep 19 = 245 s (over 150 s)
INSERT INTO runs (run_number, missions, est_seconds, launcher) VALUES
 (1, '["M01"]', 30, '—'),
 (2, '["M02","M03"]', 35, '—'),
 (3, '["M04"]', 30, '—'),
 (4, '["M12"]', 30, '—'),
 (5, '["M13"]', 30, '—'),
 (6, '["M14"]', 30, '—'),
 (7, '["M15"]', 30, '—'),
 (8, '["M08"]', 30, '—');

-- Rubric self-ratings (1–4) as they stand in the v4 build
INSERT INTO rubric (id, section, phase, row_name, core_values, level) VALUES
 (1, 'ip', 'IDENTIFY', 'Problem definition', 0, 3),
 (2, 'ip', 'IDENTIFY', 'Research', 1, 3),
 (3, 'ip', 'DESIGN', 'Project plan', 0, 2),
 (4, 'ip', 'DESIGN', 'Team involvement', 1, 3),
 (5, 'ip', 'CREATE', 'Innovation', 1, 4),
 (6, 'ip', 'CREATE', 'Model / drawing', 0, 2),
 (7, 'ip', 'ITERATE', 'Sharing', 0, 3),
 (8, 'ip', 'ITERATE', 'Improvements', 0, 2),
 (9, 'ip', 'COMMUNICATE', 'Explanation & impact', 1, 3),
 (10, 'ip', 'COMMUNICATE', 'Pride & enthusiasm', 1, 3),
 (11, 'rd', 'IDENTIFY', 'Mission strategy', 0, 3),
 (12, 'rd', 'IDENTIFY', 'Use of resources', 1, 2),
 (13, 'rd', 'DESIGN', 'All members contributed', 1, 3),
 (14, 'rd', 'DESIGN', 'Skills in all members', 0, 3),
 (15, 'rd', 'CREATE', 'Attachments', 0, 2),
 (16, 'rd', 'CREATE', 'Code / sensors', 0, 1),
 (17, 'rd', 'ITERATE', 'Testing', 0, 3),
 (18, 'rd', 'ITERATE', 'Improvements', 1, 2),
 (19, 'rd', 'COMMUNICATE', 'Process & lessons', 1, 4),
 (20, 'rd', 'COMMUNICATE', 'Pride & enthusiasm', 1, 3);

-- Notebook entries, oldest first (updates/PRACTICE-LOG.md)
INSERT INTO entries (date, who, component, phase, text, core_values, success, source, created_at) VALUES
 ('2026-08-26', '["Thea","Adeline","Fynn","Isla","Nolan","Weston"]', 'Robot Design', 'CREATE', 'Decided on a wide wheel base and built the base robot — the chassis every attachment will mount to.', '["Teamwork"]', 1, 'update', '2026-08-26 12:00:00'),
 ('2026-08-28', '["Thea","Adeline","Fynn","Isla","Nolan","Weston"]', 'Robot Design', 'DESIGN', 'Decided: the drive wheels will use the 49.5 × 20 mm tires.', '["Teamwork"]', 0, 'update', '2026-08-28 12:00:00'),
 ('2026-08-31', '["Nolan"]', 'Robot Design', 'CREATE', 'Started the Flip the Rock (M03) attachment — not finished yet.', '[]', 0, 'update', '2026-08-31 12:00:00'),
 ('2026-08-31', '["Fynn"]', 'Robot Design', 'CREATE', 'Built the Lucky Leaves (M04) attachment.', '[]', 1, 'update', '2026-08-31 12:00:00'),
 ('2026-08-31', '["Isla"]', 'Robot Design', 'CREATE', 'Built the Drone Survey (M01) attachment.', '[]', 1, 'update', '2026-08-31 12:00:00'),
 ('2026-09-04', '["Adeline"]', 'Robot Design', 'DESIGN', 'Wrote the first version of the program template for the robot base — every mission program will start from it.', '["Teamwork"]', 1, 'update', '2026-09-04 12:00:00'),
 ('2026-09-04', '["Weston"]', 'Robot Design', 'CREATE', 'Kept building the robot base.', '[]', 0, 'update', '2026-09-04 12:00:00'),
 ('2026-09-04', '["Fynn"]', 'Robot Design', 'CREATE', 'Created the Mission 12 (Forest Elder) attachment.', '[]', 1, 'update', '2026-09-04 12:00:00'),
 ('2026-09-04', '["Nolan"]', 'Robot Design', 'CREATE', 'Worked on combining the Mission 2 and Mission 3 attachments into one — Exploding Seeds + Flip the Rock in a single run.', '["Innovation"]', 0, 'update', '2026-09-04 12:00:00'),
 ('2026-09-04', '["Adeline"]', 'Robot Design', 'CREATE', 'Worked on the Mission 2 (Exploding Seeds) attachment.', '[]', 0, 'update', '2026-09-04 12:00:00'),
 ('2026-09-04', '["Thea"]', 'Core Values', 'COMMUNICATE', 'Updated every teammate''s profile card in the app — the first real team data in it!', '["Inclusion","Teamwork"]', 1, 'update', '2026-09-04 12:00:00'),
 ('2026-09-06', '["Thea","Nolan","Weston"]', 'Robot Design', 'CREATE', 'Finished the design of the robot base and built THREE copies of it — every attachment now has a base to test on.', '["Teamwork"]', 1, 'update', '2026-09-06 12:00:00'),
 ('2026-09-06', '["Thea","Adeline","Fynn","Isla","Nolan","Weston"]', 'Robot Design', 'DESIGN', 'Base decisions: low + wide (low center of gravity, more accurate turns; tradeoff = harder in tight spaces). Reinforced the base to make it rigid. Discussed color sensors — decided to use no sensors because the compact base had no room for one.', '["Teamwork","Discovery"]', 0, 'update', '2026-09-06 12:00:00'),
 ('2026-09-11', '["Isla"]', 'Robot Design', 'CREATE', 'Finished the attachment for the Forest Elder (M12) and did the programming for it.', '["Teamwork"]', 1, 'update', '2026-09-11 12:00:00'),
 ('2026-09-11', '["Adeline"]', 'Robot Design', 'CREATE', 'Did the programming for Drone Survey (M01) — our first mission program!', '[]', 1, 'update', '2026-09-11 12:00:00'),
 ('2026-09-11', '["Thea"]', 'Robot Design', 'CREATE', 'Made the team mascot AND an attachment for "the mascot mission" (M13 Keystone Species) — the robot will carry our mascot onto the restoration platform.', '["Fun","Innovation"]', 1, 'update', '2026-09-11 12:00:00'),
 ('2026-09-19', '["Adeline"]', 'Robot Design', 'CREATE', 'Programmed mission 4 (Lucky Leaves) — second mission program for Adeline.', '["Teamwork"]', 1, 'update', '2026-09-19 12:00:00'),
 ('2026-09-19', '["Fynn"]', 'Robot Design', 'CREATE', 'Programmed the Forest Elder (M12).', '["Teamwork"]', 1, 'update', '2026-09-19 12:00:00'),
 ('2026-09-19', '["Weston"]', 'Robot Design', 'CREATE', 'Built the attachment for number 14 (Seeds of Renewal) — first attachment after finishing the robot base.', '[]', 1, 'update', '2026-09-19 12:00:00'),
 ('2026-09-19', '["Nolan"]', 'Robot Design', 'CREATE', 'Built the attachment for number 2 (Exploding Seeds) and worked on number 8 (Tangled).', '[]', 1, 'update', '2026-09-19 12:00:00'),
 ('2026-09-19', '["Isla"]', 'Robot Design', 'CREATE', 'Built an attachment for mission 15 (Biocentric Architecture) — the 40-point mission!', '[]', 1, 'update', '2026-09-19 12:00:00'),
 ('2026-09-19', '["Thea"]', 'Robot Design', 'CREATE', 'Finished the Keystone Species (M13) attachment — the one that carries our mascot.', '[]', 1, 'update', '2026-09-19 12:00:00'),
 ('2026-09-25', '["Fynn"]', 'Robot Design', 'CREATE', 'Programmed mission 14 (Seeds of Renewal) — the attachment Weston built.', '["Teamwork"]', 1, 'update', '2026-09-25 12:00:00'),
 ('2026-09-25', '["Isla"]', 'Robot Design', 'CREATE', 'Built and programmed the attachment for mission 15 (Biocentric Architecture).', '[]', 1, 'update', '2026-09-25 12:00:00'),
 ('2026-09-25', '["Thea"]', 'Robot Design', 'CREATE', 'Programmed mission 12 (Forest Elder).', '["Teamwork"]', 1, 'update', '2026-09-25 12:00:00');

-- Core Values moments. Real: 2026-09-11 onward (updates/CORE-VALUES.md). Aug 13–29 rows are SAMPLE placeholders from the v2 mockup.
INSERT INTO moments (date, value, who, text, help, source, sample, created_at) VALUES
 ('2026-08-13', 'Impact', '["Fynn","Isla"]', 'Talked about who our buoy would actually help — divers, tide-pool kids, scientists.', NULL, 'update', 1, '2026-08-13 12:00:00'),
 ('2026-08-15', 'Discovery', '["Fynn"]', 'Fynn found out algae glow is called bioluminescence and taught us all.', NULL, 'update', 1, '2026-08-15 12:00:00'),
 ('2026-08-20', 'Inclusion', '["Isla","Adeline"]', 'Isla made sure Adeline presented her own hook sketches instead of doing it for her.', '["Isla","Adeline"]', 'update', 1, '2026-08-20 12:00:00'),
 ('2026-08-22', 'Innovation', '["Weston"]', 'Weston used a takeout container as the buoy body. Genius.', NULL, 'update', 1, '2026-08-22 12:00:00'),
 ('2026-08-27', 'Teamwork', '["Weston","Nolan"]', 'Weston stayed late to help Nolan find the line-follower bug.', '["Weston","Nolan"]', 'update', 1, '2026-08-27 12:00:00'),
 ('2026-08-27', 'Fun', '["Isla","Weston"]', 'Marshmallow tower challenge — best warm-up yet.', NULL, 'update', 1, '2026-08-27 12:00:00'),
 ('2026-08-29', 'Teamwork', '["Thea","Nolan"]', 'Thea held the robot steady for 10 straight tests while Nolan tweaked code.', '["Thea","Nolan"]', 'update', 1, '2026-08-29 12:00:00'),
 ('2026-09-11', 'Fun', '["Thea"]', 'Thea built our team mascot — and it rides the robot as our Keystone Species piece!', NULL, 'update', 0, '2026-09-11 12:00:00'),
 ('2026-09-19', 'Inclusion', '["Thea","Adeline","Fynn","Isla","Nolan","Weston"]', 'Every single teammate built or programmed something today — three new missions got attachments in one practice.', NULL, 'update', 0, '2026-09-19 12:00:00'),
 ('2026-09-25', 'Teamwork', '["Fynn","Thea"]', 'Only three of us were there, and we still wrote three programs — Fynn coded the attachment Weston built, and Thea added to the Forest Elder program Isla and Fynn started.', NULL, 'update', 0, '2026-09-25 12:00:00');

-- Attachments + versions (updates/ROBOT-DESIGN.md, updates/ROBOT-GAME.md)
INSERT INTO attachments (id, name, mission, purpose, built_by, size, sort_order) VALUES
 (1, 'Drone Survey attachment', 'M01', 'Launch the drone off the mat (M01 Drone Survey)', '["Isla"]', '—', 1),
 (2, 'Lucky Leaves attachment', 'M04', 'Pull the leaves out of the nest without moving the katydid (M04 Lucky Leaves)', '["Fynn"]', '—', 2),
 (3, 'Flip the Rock attachment', 'M03', 'Knock the research flag down, then put the rock back (M03 Flip the Rock)', '["Nolan"]', '—', 3),
 (4, 'Mission 2 attachment', 'M02', 'Pop the seeds off the stalk (M02 Exploding Seeds)', '["Adeline"]', '—', 4),
 (5, 'Combined 2 + 3 attachment', 'M02 + M03', 'One attachment for Exploding Seeds AND Flip the Rock in the same run', '["Nolan"]', '—', 5),
 (6, 'Mission 12 attachment', 'M12', 'Raise the cane and hook the support tie on the post (M12 Forest Elder)', '["Fynn","Isla"]', '—', 6),
 (7, 'Keystone Species (mascot) attachment', 'M13', 'Carry our team mascot — the team-built keystone species — onto the restoration platform (M13 Keystone Species, "the mascot mission")', '["Thea"]', '—', 7),
 (8, 'Mission 15 attachment', 'M15', 'Raise the nesting canopy, push the skylight in, open the compost hatch (M15 Biocentric Architecture, "mission 15")', '["Isla"]', '—', 8),
 (9, 'Mission 14 attachment', 'M14', 'Drop the seeds into the replantation station (M14 Seeds of Renewal, "number 14")', '["Weston"]', '—', 9),
 (10, 'Mission 8 attachment', 'M08', 'Pull the vine down until it touches the mat (M08 Tangled, "number 8")', '["Nolan"]', '—', 10);

INSERT INTO attachment_versions (attachment_id, date, note) VALUES
 (1, '2026-08-31', 'v1 built ✅'),
 (2, '2026-08-31', 'v1 built ✅'),
 (3, '2026-08-31', 'v1 in progress'),
 (4, '2026-09-04', 'v1 in progress'),
 (5, '2026-09-04', 'v1 in progress'),
 (5, '2026-09-19', 'Nolan built the "number 2" attachment ✅ — is it this one? ask Nolan'),
 (6, '2026-09-04', 'v1 created ✅ (Fynn)'),
 (6, '2026-09-11', 'finished ✅ + programmed (Isla)'),
 (6, '2026-09-19', 'programmed (Fynn)'),
 (6, '2026-09-25', 'programmed (Thea)'),
 (7, '2026-09-11', 'v1 built ✅'),
 (7, '2026-09-19', 'finished ✅'),
 (8, '2026-09-19', 'v1 built ✅'),
 (8, '2026-09-25', 'built + programmed ✅ (Isla)'),
 (9, '2026-09-19', 'v1 built ✅'),
 (9, '2026-09-25', 'programmed ✅ (Fynn)'),
 (10, '2026-09-19', 'v1 in progress');

-- Coding page: Programs We've Written (was hard-coded in the v4 HTML)
INSERT INTO programs (program, mission, coded_by, sensors, innovative_bit, sort_order) VALUES
 ('Robot base template', NULL, '["Adeline"]', '—', 'Every mission program starts from this one template', 1),
 ('Drone Survey (M01) program', 'M01', '["Adeline"]', '—', 'First mission program of the season (Sep 11) — fill in what''s clever about it', 2),
 ('Forest Elder (M12) program', 'M12', '["Isla","Fynn","Thea"]', '—', 'Isla wrote it the day the attachment was finished (Sep 11); Fynn programmed it again Sep 19; Thea programmed it Sep 25 — one program improved three times, or different versions? Fill in what''s clever about it', 3),
 ('Lucky Leaves (M04) program', 'M04', '["Adeline"]', '—', 'Adeline''s second mission program (Sep 19) — the katydid has to stay put, so how does the program keep it safe?', 4),
 ('Seeds of Renewal (M14) program', 'M14', '["Fynn"]', '—', 'Fynn coded Weston''s attachment (Sep 25) — fill in what''s clever about it', 5),
 ('Biocentric Architecture (M15) program', 'M15', '["Isla"]', '—', 'Isla built the attachment AND wrote its program (Sep 25) — the 40-point mission. Fill in what''s clever about it', 6);

-- Robot Design: The Main Robot card (was hard-coded in the v4 HTML; updates/ROBOT-DESIGN.md "Robot specs")
INSERT INTO robot_specs (label, value, sort_order) VALUES
 ('Shape', 'Low + wide base, reinforced for rigidity (wide base decided week of Aug 24; low + reinforced confirmed Sep 6)', 1),
 ('Size (W × D)', '— measure it!', 2),
 ('Wheels', '49.5 × 20 mm tires (decided Aug 28)', 3),
 ('Motors', '— fill in', 4),
 ('Sensors', 'None — color sensors discussed, but the compact base had no room for one (Sep 6)', 5),
 ('Wire management', '— fill in', 6),
 ('How attachments attach', '— fill in', 7),
 ('Accuracy vs Speed', 'Leaning accuracy — wide base for precise turns, accepted slower moves in tight spots', 8),
 ('Robot base status', 'Design finished ✅ — <b>3 identical copies built</b> (Thea, Nolan, Weston · Sep 6)', 9);

-- Tradeoff decisions (updates/ROBOT-DESIGN.md)
INSERT INTO tradeoffs (date, question, options, pick, why, sort_order) VALUES
 ('2026-09-06', 'Low and wide, or tall and narrow?', 'Low + wide base vs taller, narrower base', 'Low, wide base', 'Low center of gravity so it doesn''t tip. Wide wheelbase makes turns more accurate. Tradeoff we accepted: harder to move in tight spaces on the field.', 1),
 ('2026-09-06', 'Reinforce the base or keep it light?', 'Extra bracing vs fewer pieces', 'Reinforced base', 'Made the base more rigid so it doesn''t flex or twist — attachments line up the same way every run.', 2),
 ('2026-09-06', 'Color sensors, or no sensors?', 'Color sensors (line / color detection) vs none', 'No sensors', 'The base is so compact there was no room left for a sensor. Tradeoff we accepted: no line or color detection — the robot navigates by wheel rotations and turns alone.', 3),
 ('2026-08-28', 'Which drive tires?', '(students: which tires did you compare?)', '49.5 × 20 mm tires', '(students: write why here)', 4),
 ('2026-09-06', 'One robot base, or three identical copies?', 'One base everyone shares vs three matching bases', 'Three identical bases (Sep 6)', '(students: write why here — more attachments tested at once? a spare if one breaks?)', 5),
 ('2026-09-04', 'One attachment for Missions 2 + 3, or two separate ones?', 'Adeline''s Mission 2 attachment vs Nolan''s combined 2 + 3 attachment', 'Not decided yet', 'Test both, then pick — and write down why. That''s exactly what judges want to see.', 6);

-- Innovation Project. The 8 steps are real (01-innovation-project.md); gantt / research / experts are SAMPLE (updates/INNOVATION-PROJECT.md: nothing real recorded yet)
INSERT INTO ip_steps (n, name) VALUES
 (1, 'Explore the theme'),
 (2, 'Define the problem'),
 (3, 'Research'),
 (4, 'Plan the project'),
 (5, 'Build a prototype'),
 (6, 'Share & get feedback'),
 (7, 'Improve'),
 (8, 'Present');

INSERT INTO gantt (task, owner, start_pos, end_pos, iterations, sample) VALUES
 ('Pick the problem', 'Fynn', 0, 0.6, '["6 ideas listed","Voted with 2 votes each","Algae bloom alerts chosen"]', 1),
 ('Research sources', 'Fynn', 0.4, 1.4, '["3 websites","Library book on plankton","Ms. Rivera sent 3 papers"]', 1),
 ('Interview experts', 'Isla', 0.8, 1.8, '["Emailed 4 experts","Ms. Rivera said yes","Mr. Okafor (lifeguard) next week"]', 1),
 ('Prototype buoy', 'Weston', 1.2, 2.6, '["Cardboard v1 — floats!","v2 with light sensor (in progress)","v3 with waterproof case (planned)"]', 1),
 ('Alert map screen', 'Isla', 1.6, 2.8, '["Paper sketch","Cardboard phone mockup"]', 1),
 ('Presentation', 'Thea', 2.6, 3.6, '["Outline drafted"]', 1);

INSERT INTO research (source, type, found_by, note, sample) VALUES
 ('NOAA — Harmful algal blooms', 'Website', 'Fynn', 'Blooms can be predicted by water temp', 1),
 ('"Glow: Life in the Deep" (library book)', 'Book', 'Weston', 'How bioluminescence works', 1),
 ('Ms. Rivera — 3 research papers', 'Expert', 'Fynn', 'Sensors that measure light in water', 1),
 ('Local dive shop survey (12 people)', 'Survey', 'Isla', '10 of 12 wanted alerts', 1);

INSERT INTO experts (name, role, face, feedback, improvement, sample) VALUES
 ('Ms. Rivera', 'Marine biologist', '👩‍🔬', '"Measure the glow at night AND day so you know the baseline."', 'Added a day/night comparison to the buoy plan', 1),
 ('Mr. Okafor', 'Beach lifeguard', '🏖️', '"People won''t download an app — use text messages."', 'Switched from app to SMS alerts', 1),
 ('Coach CJ', 'Team coach', '🧢', '"Can a kid explain it in one sentence?"', 'Wrote the one-sentence pitch on the Problem card', 1);

-- Proudest-moment quotes, oldest first (newest shows on the dashboard)
INSERT INTO quotes (quote, by_line, date, source, created_at) VALUES
 ('Two attachments built in one practice — Drone Survey and Lucky Leaves!', 'Team milestone · Aug 31', '2026-08-31', 'update', '2026-08-31 12:00:00'),
 ('We have a team mascot — and it scores points! Thea built it plus the attachment that carries it for Keystone Species.', 'Team milestone · Sep 11', '2026-09-11', 'update', '2026-09-11 12:00:00'),
 ('Biggest build day yet — three new missions got attachments, Keystone Species is finished, and all six of us did something!', 'Team milestone · Sep 19', '2026-09-19', 'update', '2026-09-19 12:00:00'),
 ('Three of us, three programs! Five missions have a program now — M01, M04, M12, M14, and M15.', 'Team milestone · Sep 25', '2026-09-25', 'update', '2026-09-25 12:00:00');

-- Settings
INSERT INTO settings (key, value, note) VALUES
 ('tournament', '{"name":"Regionals","date":"2026-11-14"}', 'sidebar countdown'),
 ('mascot', '{"name":"","built_by":"Thea","date":"2026-09-11","mission":"M13","photo":null}', 'Core Values page: Team Mascot card'),
 ('coding_note', '"Base program template: Adeline wrote v1 (Sep 4) — every mission program starts from it. Resources: Python (PyBricks) docs"', 'Coding page footer'),
 ('cv_tally_base', '{"Teamwork":15,"Discovery":12,"Fun":14,"Innovation":9,"Inclusion":7,"Impact":4}', 'SAMPLE: made-up starting counts from the v2 mockup, added on top of real moments'),
 ('ip_progress', '{"done":4,"now":5}', 'SAMPLE: 8-step progress'),
 ('ip_summary', '{"problem":"Divers and tide-pool visitors can''t see bioluminescent algae blooms coming, so they miss them — or accidentally trample fragile glowing habitats at night.","solution":"<b>GlowCast</b> — a floating sensor buoy that measures water glow and texts a \"bloom alert\" with a safe-viewing map to the community.","how":"Started with 6 problem ideas → voted → researched 9 sources → interviewed 2 experts → built a cardboard buoy → got feedback → now building v2 with a real light sensor.","sample":true}', 'SAMPLE: Innovation Project problem / solution / how we got here');
