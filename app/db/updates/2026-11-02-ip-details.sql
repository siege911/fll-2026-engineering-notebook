-- 2026-11-02 · asked by Coach CJ: a whole "Innovation Project Details" section on the Innovation Project page:
--   parts we ordered, the wiring diagram, click-to-open code for the ESP32 camera / Raspberry Pi / DigitalOcean,
--   and how to install each one. Placeholders for what isn't built yet.
-- Matches CAMERA-BUILD.md 2026-11-02 "Parts list for the whole project" (parts + wiring come from its 2026-10-12 entry),
-- camera/INSTALL.md, pi/README.md + pi/INSTALL.md, droplet/INSTALL.md, and DECISIONS 2026-11-02.

-- Every part for the project, grouped by box. status: Bought | Have | Shipping | Need | Optional | Later | Not sure
CREATE TABLE ip_parts (
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  grp         TEXT,      -- Camera box | Solar box | Pi Camera Station
  part        TEXT,
  qty         TEXT,
  status      TEXT,
  date        TEXT,      -- when it was bought / when we knew we had it
  note        TEXT,
  sort_order  INTEGER,
  source      TEXT DEFAULT 'update'
);

INSERT INTO ip_parts (grp, part, qty, status, date, note, sort_order) VALUES
 ('Camera box', 'Seeed Studio XIAO ESP32-S3 Sense (camera, microphone, microSD slot)', NULL, 'Bought', '2026-10-12', 'The camera''s brain. Sleeps on very little power', 1),
 ('Camera box', 'AM312 mini PIR motion sensor (HC-SR312)', '5-pack', 'Bought', '2026-10-12', 'Feels warm animals move', 2),
 ('Camera box', 'DS3231 AT24C32 I2C real-time clock module (with jumper wires)', '2-pack', 'Bought', '2026-10-12', 'Keeps the time when the Pi is out of range. The second one can go on the Pi', 3),
 ('Camera box', '32 GB high-endurance microSD card (FAT32)', NULL, 'Need', NULL, 'On the Oct 12 "still need" list', 4),
 ('Camera box', 'SPDT mini toggle switch', NULL, 'Need', NULL, 'The mode switch (always-on / solar). On the Oct 12 "still need" list', 5),
 ('Camera box', 'CR2032 coin cell for the clock', NULL, 'Need', NULL, 'Only if the clock module didn''t come with one', 6),
 ('Camera box', 'Waterproof box + USB-C panel jack (or a short USB-C extension)', NULL, 'Need', NULL, 'On the Oct 12 "still need" list', 7),
 ('Camera box', 'Breadboard + jumper wires', NULL, 'Need', NULL, 'For testing. On the Oct 12 "still need" list', 8),
 ('Camera box', 'LED + 220 Ω resistor', '1 each', 'Optional', NULL, 'Status light', 9),
 ('Solar box', 'ZPSHYD 6V 3W mini monocrystalline solar panel (DC5521 plug)', NULL, 'Bought', '2026-10-12', 'The Waveshare board needs 6 V or more, so this fits', 10),
 ('Solar box', 'Waveshare Solar Power Manager Module (D)', NULL, 'Bought', '2026-10-12', 'Takes the solar panel (or a USB-C charger), gives 5 V out, holds the battery', 11),
 ('Solar box', '2600 mAh 3.7 V button-top 18650 rechargeable batteries', '2-pack', 'Shipping', '2026-10-12', 'Delayed in shipping (Oct 12)', 12),
 ('Pi Camera Station', 'Raspberry Pi 4 Model B, 8 GB', '1', 'Have', '2026-10-03', 'We already had it', 13),
 ('Pi Camera Station', 'microSD card for the Pi', '1', 'Have', '2026-10-03', 'A USB SSD would last longer (pi/INSTALL.md)', 14),
 ('Pi Camera Station', '7" Raspberry Pi Touchscreen', NULL, 'Not sure', NULL, 'For reviewing and publishing photos [unclear: do we have it yet?]', 15),
 ('Pi Camera Station', 'USB Wi-Fi adapter with an antenna (~$30)', NULL, 'Later', NULL, 'Only for two radios at once (pi/NETWORKING.md setup 2). Not needed with the Wi-Fi switch', 16),
 ('Pi Camera Station', '"m5cam" camera module', NULL, 'Have', '2026-10-03', 'We already had it. Not in the current plan (the XIAO does its job)', 17);

-- The camera box wiring, one wire per row (CAMERA-BUILD.md 2026-10-12 wiring plan v1).
-- part NULL = a XIAO pin with nothing on it (why says why). in_code = the camera v3 code uses this wire.
CREATE TABLE ip_wiring (
  id          INTEGER PRIMARY KEY AUTOINCREMENT,
  pin         TEXT,      -- XIAO pin: D0…D10, 3V3, GND, 5V
  gpio        TEXT,
  part        TEXT,
  part_pin    TEXT,
  color       TEXT,      -- wire color on the diagram (CSS color)
  why         TEXT,
  optional    INTEGER DEFAULT 0,
  in_code     INTEGER DEFAULT 0,
  sort_order  INTEGER,
  source      TEXT DEFAULT 'update'
);

INSERT INTO ip_wiring (pin, gpio, part, part_pin, color, why, optional, in_code, sort_order) VALUES
 ('D0',  'GPIO1', 'Motion sensor (AM312)', 'OUT', '#e0a100', 'Wakes the camera when an animal moves', 0, 1, 1),
 ('3V3', NULL,    'Motion sensor (AM312)', '+',   '#d64545', 'Power', 0, 1, 2),
 ('GND', NULL,    'Motion sensor (AM312)', '−',   '#2b2b2b', 'Ground', 0, 1, 3),
 ('D1',  'GPIO2', 'Mode switch (SPDT)', 'middle', '#ef7d22', 'Mode switch: 3V3 = always-on, GND = solar mode', 0, 0, 4),
 ('3V3', NULL,    'Mode switch (SPDT)', 'end 1', '#d64545', 'Holds D1 HIGH in always-on mode', 0, 0, 5),
 ('GND', NULL,    'Mode switch (SPDT)', 'end 2', '#2b2b2b', 'Holds D1 LOW in solar mode', 0, 0, 6),
 ('D2',  'GPIO3', 'Status light (LED + 220 Ω)', '+ (through 220 Ω)', '#3f9b4c', 'Status light (the XIAO''s own orange LED is taken by the microSD card)', 1, 0, 7),
 ('GND', NULL,    'Status light (LED + 220 Ω)', '−', '#2b2b2b', 'Ground', 1, 0, 8),
 ('D3',  'GPIO4', 'Clock (DS3231)', 'SQW', '#b48fd9', 'Wakes the camera on a clock alarm (a check-in every few hours)', 0, 0, 9),
 ('D4',  'GPIO5', 'Clock (DS3231)', 'SDA', '#20b5c9', 'Clock data', 0, 1, 10),
 ('D5',  'GPIO6', 'Clock (DS3231)', 'SCL', '#2a6fdb', 'Clock timing signal', 0, 1, 11),
 ('3V3', NULL,    'Clock (DS3231)', 'VCC', '#d64545', 'Power (3.3 V, so it can''t push current into the coin cell)', 0, 1, 12),
 ('GND', NULL,    'Clock (DS3231)', 'GND', '#2b2b2b', 'Ground', 0, 1, 13),
 ('5V',  NULL,    NULL, NULL, NULL, 'Not used: power comes in through the XIAO''s own USB-C port (phone charger or the solar box)', 0, 0, 14),
 ('D6',  'GPIO43', NULL, NULL, NULL, 'Free (can''t wake the camera from sleep)', 0, 0, 15),
 ('D7',  'GPIO44', NULL, NULL, NULL, 'Free (can''t wake the camera from sleep)', 0, 0, 16),
 ('D8',  'GPIO7', NULL, NULL, NULL, 'Don''t use: the microSD card uses it', 0, 0, 17),
 ('D9',  'GPIO8', NULL, NULL, NULL, 'Don''t use: the microSD card uses it', 0, 0, 18),
 ('D10', 'GPIO9', NULL, NULL, NULL, 'Don''t use: the microSD card uses it', 0, 0, 19);

-- The three computers in the project, their code and their install guides.
-- docs / files are JSON lists of {label|what, path}; paths are from the Engineering Notebook folder.
-- A file that doesn't exist yet shows as a "not built yet" placeholder. The server only shows files listed here.
CREATE TABLE ip_platforms (
  id          TEXT PRIMARY KEY,   -- esp32 | pi | droplet
  icon        TEXT,
  name        TEXT,
  device      TEXT,
  job         TEXT,
  version     TEXT,
  status      TEXT,
  built       INTEGER,            -- 1 = code written, 0 = placeholder
  docs        TEXT DEFAULT '[]',  -- JSON: [{label, path}]
  files       TEXT DEFAULT '[]',  -- JSON: [{path, what}]
  updated     TEXT,               -- last big change to the code / plan / instructions
  sort_order  INTEGER,
  source      TEXT DEFAULT 'update'
);

INSERT INTO ip_platforms (id, icon, name, device, job, version, status, built, docs, files, updated, sort_order) VALUES
 ('esp32', '🎥', 'Wildlife Camera', 'Seeed Studio XIAO ESP32-S3 Sense',
  'Takes a picture every second and shows it live. Saves it to the microSD card when the motion sensor fires or the picture changed. Sends every saved picture to the Pi over the Pi''s camera Wi-Fi, then deletes it from the card. Out of range, pictures wait on the card.',
  'Camera v3 (Oct 25)', 'Compiles · not tested on the real camera yet', 1,
  '[{"label":"How to install","path":"camera/INSTALL.md"}]',
  '[{"path":"camera/camera-v3/camera-v3.ino","what":"The camera program"},{"path":"camera/camera-v3/secrets.example.h","what":"Copy to secrets.h: camera Wi-Fi, the Pi''s address, the camera key (the real secrets.h stays on the laptop)"},{"path":"camera/camera-v2/camera-v2.ino","what":"Older: v2 (Oct 25), saves to microSD, the Pi pulls pictures"},{"path":"camera/camera-v1/camera-v1.ino","what":"Older: v1 (Oct 24), live view + motion sensor"}]',
  '2026-10-25', 1),
 ('pi', '🍓', 'Camera Station', 'Raspberry Pi 4 (8 GB) + 7" touchscreen',
  'Runs its own camera Wi-Fi, takes the camera''s pictures, tags them with SpeciesNet (Google''s camera-trap AI), blurs people, sets empty pictures aside, and groups pictures into visits. We review every visit on the touchscreen and pick what to publish. Nothing goes online by itself.',
  'Station v1 (Oct 25) + Wi-Fi switch (Oct 26)', 'Tested on a Mac in practice mode · not installed on the Pi yet', 1,
  '[{"label":"How it works","path":"pi/README.md"},{"label":"How to install","path":"pi/INSTALL.md"},{"label":"Networking (camera Wi-Fi + house Wi-Fi)","path":"pi/NETWORKING.md"}]',
  '[{"path":"pi/station/server.py","what":"The Camera Station: receives photos, runs the tagging, answers the touchscreen page"},{"path":"pi/station/store.py","what":"The station''s memory, and how visits are grouped and counted"},{"path":"pi/station/ai.py","what":"Talking to SpeciesNet, blurring people, practice-mode answers"},{"path":"pi/station/network.py","what":"The 📡 Camera Wi-Fi / 🌐 House Wi-Fi switch"},{"path":"pi/station/public/index.html","what":"The touchscreen page (ours to change)"},{"path":"pi/station/camera-station.service","what":"Starts the station when the Pi boots"},{"path":"pi/station/50-camera-station.rules","what":"Lets the station flip the Wi-Fi switch"},{"path":"pi/settings.example.json","what":"Copy to settings.json (the real one stays on the Pi)"},{"path":"pi/collector.py","what":"Backup: fetches photos from a camera still on v2"},{"path":"pi/station/uploader.py","what":"Sends the visits we picked to our website"}]',
  '2026-10-26', 2),
 ('droplet', '🌐', 'Team Website', 'DigitalOcean droplet (Ubuntu)',
  'Shows the animal visits we picked on the Pi (people already blurred), behind a team password. Later it also hosts this Engineering Notebook app.',
  'Plan only', 'Not built yet · plan waiting on Coach CJ', 0,
  '[{"label":"Plan + how to install (draft)","path":"droplet/INSTALL.md"}]',
  '[{"path":"droplet/camera-site/server.mjs","what":"Takes uploads from the Pi (checks its key), saves photos and visits, serves the website"},{"path":"droplet/camera-site/public/index.html","what":"The website page: our animal visits, in the notebook colors"},{"path":"droplet/camera-site.service","what":"Starts the camera website when the droplet boots"},{"path":"droplet/Caddyfile","what":"HTTPS for both sites + one team password per site"}]',
  '2026-11-02', 3);
