# Decisions Log

Newest at top. Capture-field and design decisions come from the students; architecture decisions come from CJ.

---

## 2026-10-26 — Pi networking: one radio with a Camera Wi-Fi / House Wi-Fi switch (CJ)

**CJ:** "Can we have a button on the screen that switches the networking from broadcast Wi-Fi to connect to Wi-Fi instead of buying a second adapter?"
**Done:** the touchscreen Home page has **📡 Camera Wi-Fi | 🌐 House Wi-Fi**. Camera Wi-Fi = the Pi's hotspot (camera sends photos); House Wi-Fi = internet (publishing). The Pi starts in Camera Wi-Fi mode and goes back to it by itself after 15 minutes in House Wi-Fi mode (`auto_return_minutes`), or right away if it can't join the house Wi-Fi.
**Why it's OK:** camera v3 keeps photos on its card while it can't reach the Pi and sends them when Camera Wi-Fi is back. **Trade-offs:** no camera photos, Live view or SSH-over-house-Wi-Fi while switched; the Pi 4 has no clock battery, so after a reboot in Camera Wi-Fi mode its time can be off. Fix: a minute on House Wi-Fi, or wire the second DS3231 module to the Pi (`dtoverlay=i2c-rtc,ds3231`).
**Later upgrade:** a USB Wi-Fi adapter (setup 2) does both at once; then `wifi_switch: false`.

---

## 2026-10-25 (later) — Pi Camera Station (CJ): Pi runs the camera Wi-Fi, camera pushes, Pi tags + groups visits, students review and publish by hand

**CJ's asks:** the Pi acts as a gateway/router with its own Wi-Fi for the camera (works out of range of house Wi-Fi) and joins the house Wi-Fi for the internet; photos move camera → Pi as soon as the camera is in range; the Pi tags them as they come in and works out whether photos in a row are the same animal (no double counting); **students review, and publishing is never automatic**; a touchscreen interface (7" Pi Touchscreen) in the Engineering Notebook style that walks them through it. Claude builds a basic level; the students take over the page and the details.
**Built (Claude):**
- **Networking:** NetworkManager hotspot `RootedWarriorsCam` at 10.42.0.1 on a **USB Wi-Fi adapter with an antenna** (needs AP mode, e.g. MediaTek mt76); house Wi-Fi on the built-in radio. One radio can't do both reliably. Alternative: Ethernet for the house. `pi/NETWORKING.md`.
- **Camera v3** (`camera/camera-v3/`): joins the Pi's Wi-Fi without waiting for it, pushes every saved photo to the Pi and deletes it after the Pi says OK, keeps them on the card when out of range; gets the time from the Pi and keeps it in the DS3231 clock module if wired.
- **Camera Station** (`pi/station/`): receives photos, tags them with SpeciesNet in the background, blurs people/vehicles, sets empties aside (deleted after 7 days), groups animal photos into **visits** (same species, < 10 minutes apart) and counts animals per visit as the most seen in one photo ("MaxN"). Touchscreen page: Home (4 steps), Live, Review (species, count, best photo, who checked, "same animal as visit before", approve/hide), Publish (pick → in line for the website), Test (picture changed vs. motion sensor).
**Why visits + MaxN:** it's how camera-trap scientists avoid counting the same animal over and over; the students can merge visits by hand when the AI can't tell. The 10-minute gap is a starting point for the students to test (scientists often use 30).
**Open:** buy the USB Wi-Fi adapter (or use Ethernet); SpeciesNet install on the Pi (not tried yet); the website uploader (after DigitalOcean).

---

## 2026-10-25 — Camera v2 plan (CJ): the camera compares pictures + motion sensor, saves to microSD; Pi tags; DigitalOcean shows

**CJ:** "Let's go with your comparing pictures idea along with the motion sensor. I'd still like to be able to view the camera images live... with the Engineering Notebook theme... show whether the 'comparing pictures' triggered or the 'motion sensor' triggered (or both)."
**Plan:** 1) The **camera** takes a picture every second, shows it live on its own page (notebook colors), and saves it to the microSD card only when the **motion sensor** fires or the **picture changed** (or both); `log.csv` records which. 2) The **Pi 4** collects the saved pictures every 15–30 min over Wi-Fi, tags them (animal / person / empty, then species), blurs people, deletes empties. 3) **DigitalOcean** shows only the finished, tagged pictures.
**Why:** SenseCraft AI has no general "any animal or object" model for the XIAO ESP32S3 Sense (only person, face, gesture, gender, bird, cat, apple, strawberry; checked Oct 24), so motion sensor + picture comparing is the "something came into view" trigger, and the Pi does the real tagging. The same camera code works for Camera 2 in the forest; nothing is lost if the Pi or internet is down; unblurred pictures never leave the house.
**Changes Option C (Oct 24):** the camera, not the online app, compares pictures. The experiment is now "picture changed vs. motion sensor."
**Later (student project idea):** train a "something's there" model on the camera itself (SenseCraft training or Edge Impulse).

---

## 2026-10-24 — Architecture (CJ): one DigitalOcean droplet for both apps; GitHub (siege911)

**CJ:** host the notebook app and the camera app on **one DigitalOcean droplet** (subdomains or subfolders); code on GitHub under **siege911** (not the City account). Replaces the 2026-08-31 plan (Cloudflare Workers + D1 + R2).
**Suggested (Claude), waiting on CJ:** Cloudflare Registrar + DNS (A records, DNS only); Caddy for HTTPS + one team password per site; $6/mo droplet (1 GB) + weekly backups; Node apps run as services on localhost; camera uploads use their own device key; save only motion pictures.
**Done:** local git repo created, first commit as siege911. Not committed: the camera Wi-Fi file (`secrets.h`) and the live database file (`*.db`; data is in `snapshot.json`).

---

## 2026-10-24 (later) — Camera app v1 = Option C; separate camera app + Camera card in the notebook (Thea)

**Decided (Thea):** "Let's do C." The camera sends a picture every 1–2 s and each picture says whether the motion sensor felt something. The app spots motion too, saves pictures, tags animals; the team compares which catches more animals (app vs. sensor). Mockup: `mockups/17-camera-app-v1-option-c.html`.
**Open (Thea's question):** "Do we just have this as another page on our engineering notebook, or should we have it as a separate app?" Options offered: 1) a page inside the notebook app; 2) a separate camera app; 3) separate camera app + a small Camera card in the notebook that shows highlights and links to it (Claude's suggestion: the camera app is the Innovation Project solution judges and Game and Fish could use on its own; the notebook is the team's evidence record).
**Decided (Thea): "Let's do three."** A separate camera app, plus a small Camera card in the notebook app (best pictures, top animal, app vs. sensor score, button to open the camera app). **Why:** the notebook is the record of how we worked; the camera app is the thing we built, and it can be shown to judges, Game and Fish, or ADOT on its own.
**For CJ:** Thea says both apps will be hosted on **DigitalOcean**. That changes the Aug 31 plan (Cloudflare Workers + D1 + R2) for the notebook app. Camera picture uploads every 1–2 s need storage space and keeping it private.

---

## 2026-10-24 — Camera app v1: always on, streams to an online app; motion sensing camera or app? — OPEN (Thea)

**Their words:** "We want to create an app that we can host online, where this camera will stream to the app... In future versions, we might use the motion sensor to turn on the camera, but for now we're going to have it on all the time. We're wondering if it would be simpler and easier to use the app to sense motion, take pictures, and do all the animal tagging."
**Decided:** v1 camera is **always on** (Camera 1 at the house, wall power). Motion-sensor wake-up is for a later version.
**Options offered (team picks):** A) App does everything: camera sends a picture every 1–2 s; app spots motion, saves, tags. B) Camera's motion sensor decides, sends only motion pictures; app tags. C) A + the camera adds "motion sensor: yes/no" to every picture, so the team can test which finds more animals. Claude suggested C (one wire already planned; gives a test to compare).
**Nudges given:** day vs. night (the motion sensor sees body heat in the dark, the camera can't without IR); wind/shadows fool picture-comparing; Nate Reagan said no live stream and blur people. How will they keep strangers and people out of an online app?
**For CJ:** where the app is hosted, how the camera sends pictures to it (picture uploads, not true video), keeping it private (sign-in), animal-tagging model (e.g. MegaDetector finds animal/person/vehicle; SpeciesNet for species).

---

## 2026-10-23 — Profile-picture rings stay each teammate's own color (Thea)

**Request (her words):** "i didnt want the line around the profile pictures to change to the color of the favorite color. change it back to how it was."
**Done:** the ring on each Team Profile card uses the teammate's own app color (Thea lavender, Fynn yellow, Isla red, Adeline pink, Nolan teal, Weston green), not the typed "Fav color." Changing a favorite color in the app now only changes the words, not the ring. (This replaces the Sep 4 rule "ring colored from the favorite color.")
**Then (Thea, same day):** "for fynns color around the picture make it a lighter pretty yellow." Picked Lemon Chiffon, then changed to **Sunshine (#ffd84d)** ("actualy i want it to be sunshine") out of 4 yellows (Butter Yellow, Lemon Chiffon, Sunshine, Honey Glow). Only the ring changes; Fynn's other avatars keep his regular yellow.
**Then (Thea, same day):** "give me a few options for adelines pink to just like fynns." Picked **Cotton Candy (#f9a8d4)** out of 4 pinks (Cotton Candy, Ballet Slipper, Bubblegum, Rose Petal). Ring only.
**Then (Thea, same day):** "give me some options for islas to the same way but with orenge." Picked **Mango (#ffa53d)** out of 4 oranges (Tangerine, Peach, Sunset, Mango). Ring only; Isla stays red everywhere else.
**Then (Thea, same day):** "make sure that westons green is the same green weve been using for the app." It already was: Grass green (#3f9b4c, from the logo palette). Shown next to Pine and Forest; Thea: "Keep Grass green for Weston." No change.

---

## 2026-10-12 — More team color: lavender frames on every card (Thea)

**Request (their words):** "for the whole app add a little bit more purple because that is the team color," then "give me more options but with only the lavender purple we've been using."
**Options shown:** `mockups/15-more-purple-options.html` (A Purple Touches, B Purple Sidebar, C Lilac Background; turned down because they used new purples) and `mockups/16-more-lavender-options.html` (D Lavender Title Bars, E Lavender Frames, F Lavender Sidebar Trim, G Lavender Banner).
**Picked:** E, Lavender Frames ("i like E"). Every card in the app now has a thick lavender border. Rule going forward: when adding purple, use our lavender (#b48fd9), not new shades.

---

## 2026-10-12 — Innovation Project: camera parts bought; power through the XIAO's USB-C ([who?])

**Decision (their words):** "We want the Solar Panel box and the Camera box to be two different options. We want to power the camera with USB C so we could plug it into a typical phone charger if we have power near the camera or the USB C output on the solar panel if we don't have power."
**Parts changed from the Oct 3 list:** Waveshare Solar Power Manager (D) instead of DFRobot Sunflower; ZPSHYD 6 V 3 W panel; 2600 mAh button-top 18650s. **Build order:** camera box first (batteries delayed).
**Wiring plan v1** (Claude, for the team to check): `updates/CAMERA-BUILD.md`. The XIAO's own USB-C port is the power jack; sensors run on 3V3.
**For CJ:** are the 18650s protected cells? (button-top, no "protected" in the listing); solder headers if needed; the solar box's auto-off at low current needs a test once batteries arrive.

---

## 2026-10-09 — "Tap to fill in" on every blank (Thea)

**Request (her words):** "For everything we need to fill out but haven't yet, can you make a tap to fill in thing."
**Done:** blanks on Robot Game (mission Diff, Run, Attachment, Built, Coded; run Launcher), Coding (Sensors, Coded by), Robot Design (tradeoff We picked / Why) and the Core Values mascot name now say "Tap to fill in" and save when typed. Numbers worked out by the app (reliability, expected points, help tally) stay automatic.
**For CJ:** these edits overwrite the row in place and don't record who typed them or when (same as profile cards and mission status). `snapshot.json` shows the current values; copy new ones into the markdown at the next session start.

---

## 2026-10-09 — Notebook Feed opens by teammate picture (Thea)

**Request (her words):** "In the daily log as you press the notebook log… make different buttons to press with everyone's profile pictures. When you press those buttons it leads to whoever you pressed on's notebook feed. Same with whole team."
**Done:** the Notebook Feed box on the Daily Log page now has one picture button per teammate plus a "Whole team" button (team logo), each showing how many entries it has. Tapping one opens the feed already filtered to that person. "See every entry" still opens the full feed.
**How "Whole team" counts:** entries tagged "Whole team" or tagged with all six teammates. Those entries appear **only** in the Whole team feed, never in a single person's feed (Thea, same day). A person's feed shows only entries with their name on them, not "Whole team" entries. Thea confirmed: keep it that way ("no" to adding Whole team entries to each person's feed).
**Also (same day, Thea):** dashboard and Robot Game mission lists show only number + official name (no "we say" nicknames or 🚫 icon); Research Collection and Experts cards are full width.

---

## 2026-10-05 — Remove all sample data; empty spots become boxes we fill in (Adeline and Thea)

**Request (their words):** "Could you get rid of all the sample stuff that we did not do and delete it? If there's nothing there, make it a text box so we can fill it out."
**Done:** deleted the made-up placeholders from the v2 mockup: 7 Core Values moments (Aug 13–29), extra starting points in the Six-Value Tally, the GlowCast Problem / Solution / How We Got Here, the "4 of 8 steps done" progress, and 6 Project Plan (Gantt) bars. (Sample experts and research went earlier the same day.) The "SAMPLE DATA" label on the Innovation Project page is gone.
**Now fill-in-able in the app:** Problem, Our Solution, How We Got Here (text box + Save, then ✏️ Edit); 8-Step Progress (click the step we're on now); Project Plan (task, who owns it, start, end → Add to plan).
**Why:** judges should only see what the team really did.

---

## 2026-10-05 — Innovation Project: expert advice from Nate Reagan (Game and Fish) — OPEN, for the students

Nate Reagan (Arizona Game and Fish) gave advice that touches decisions we already made. **Nothing changed yet. The team picks, and writes down why:**
1. **Live stream?** Oct 3 plan: Camera 1 live streams. Nate: no live stream prevents bad stuff. Options: keep it / drop it / keep it but AI blurs people.
2. **Where does the camera go?** The I-17 wildlife bridge (needs ADOT's permission) or the squirrel nest (backup).
3. **How many cameras?** Nate: cameras over a wide area work best.
4. **Our own data:** Game and Fish won't share data, so the team collects its own (fits the camera plan).
5. **New idea: blinking warning light for drivers** when the camera sees an animal crossing. Nate says it has been done before. Add it / skip it / make ours different (and how)?
**For CJ:** contacting ADOT about permission to put a camera on the wildlife bridge.

---

## 2026-10-03 (later) — Innovation Project: build two cameras + a mode switch (students, with Coach CJ)

**Decision (Thea, for the team):** build **two copies**. **Camera 1** is plugged in behind Thea's family's house, looking at the forest, for testing and live streaming. **Camera 2** goes in the forest on solar and wakes on movement. A **switch** picks "always on mode" (Wi-Fi on) or "solar mode" (sleep). Pictures are collected by walking up, flipping to always-on, downloading over Wi-Fi, and flipping back. Both take **USB-C power**; the solar rig is its own box.
**Why:** test safely at home first; save battery in the forest; one camera design works on both power sources.
**Open:** night vision (add or not).
**For CJ:** soldering, and the 18650 battery + DFRobot board, with an adult; no charging below freezing.

---

## 2026-10-03 (later) — Innovation Project: camera = XIAO ESP32-S3 Sense; Pi 4 pulls pictures over Wi-Fi (students)

**Decision (Thea, for the team):** the forest camera is the **Seeed Studio XIAO ESP32-S3 Sense** (built-in Wi-Fi). The team's **Raspberry Pi 4** connects to it over Wi-Fi to get the pictures (their idea: "pull"). **Why:** cheaper and far less power than a Pi 4 in the forest (from Coach CJ's research), and it reuses the Pi they own.
**Still open (students):** where the Pi lives and how far away; pull vs. push (push saves battery); night-vision parts.

### Earlier the same day — Pi 4 vs low-power XIAO camera (was OPEN)

**Question (Thea):** new research (Coach CJ + Gemini) says a Seeed XIAO ESP32S3 Sense is cheaper and uses far less power than the Pi 4. Options: A) XIAO only, B) Pi 4 only, C) XIAO in the forest + Pi 4 at home tags the animals. **Waiting for the team's pick and their "why."** Details in `updates/INNOVATION-PROJECT.md`.

---

## 2026-10-03 — Innovation Project: Option B, Raspberry Pi build, running 24/7 (students)

**Decision (told by Thea, for the team):** build the forest camera on the team's own **Raspberry Pi 4**, with cheap parts, running **24/7** on solar. Parts on hand: Pi 4, "m5cam" module, microSD.
**Tradeoff to decide next (students):** 24/7 means a ~100 W panel and 20 Ah battery (the most expensive parts). Cheaper: daytime only / a timer. A judge could ask "why 24/7?" — animals move at night is a good answer.
**For CJ:** LiFePO4 battery + 12 V wiring + fuse with an adult; buy a battery with low-temperature charge protection (Flagstaff winters). Shopping list in `updates/INNOVATION-PROJECT.md`.

---

## 2026-10-02 — Innovation Project solution: AI forest wildlife camera (students)

**Decision (told by Thea, for the team):** the Innovation Project solution is a camera placed in the forest with an AI camera that tags animals, solar panels and batteries to charge in the sun, sending images to a website the team built.
**Still to decide (students):** which build option (A buy & add / B Raspberry Pi / C ESP32-CAM, see `updates/INNOVATION-PROJECT.md`), how pictures get out of the forest, where it goes.
**For CJ:** lithium battery + solar wiring needs adult supervision; placement on Forest Service / City land likely needs permission; cellular data would need a SIM plan.

---

## 2026-09-28 — Real photos as profile pictures (students)

**Request (Thea):** use the photos in the new `images` folder ("profile fynn" etc.) as our profile pictures.

**Decision:** each teammate's photo replaces their emoji on the Team Profile card and in every small round avatar across the app. The ring keeps their favorite color. The emoji stays as the back-up if a photo is missing. Photos live in `app/images/`, named `profile <name>.jpg`.
**For CJ:** the attachment photos (`<month>-<day>-mission-<N>.jpg`) are in the same folder but not wired up yet; when the app moves to Cloudflare, `app/images/` goes to R2 along with photo upload.

## 2026-09-28 — The app gets a real database and dev server (CJ)

**Request (CJ):** "Let's make this more of an actual app. Take the previous updates and ensure they are stored into a database. All future updates should update the data and start the dev server."

**Decision:**
- The live app moves from a single HTML file with its data written inside (`mockups/14-…-v4.html`) to **`app/`**: a local dev server (`app/server.mjs`, port 8787) plus a **SQLite database** (`app/db/`). The page looks and reads exactly like v4; it now loads everything from the database, and every form saves to it.
- **All data through the Sep 25 practice** is in `app/db/seed.sql`: team cards, 15 missions with builders/coders, run plan, rubric ratings, 25 notebook entries, moments, 10 attachments with 17 versions, programs, robot specs, tradeoffs, quotes. Also the facts that were typed straight into v4's HTML (robot specs, programs table, mascot card, tournament date). A page-by-page text comparison with v4 showed all 8 pages identical.
- **Future updates** are dated SQL files in `app/db/updates/`, applied once each. Together with the seed they replay the whole season, and they are a readable history of every data change. Markdown still comes first (CLAUDE.md).
- **Zero install:** uses Node's built-in SQLite, so no packages. The schema is plain SQLite that also runs on **Cloudflare D1**, so the Aug 31 plan (Workers + D1 + R2) still stands. This is the local stage of it, not a replacement.
- The page can **add** entries, moments, matches, test sessions, and quotes, and **edit** mission status/reliability, rubric ratings, and profile-card fields. Nothing else can be changed from the browser.
- `app/db/snapshot.json` is rewritten after every change: a readable copy of the database in OneDrive.
- Placeholder rows from the v2 mockup are kept so the pages look the same, but are flagged `sample = 1` (Aug 13–29 moments, Innovation Project gantt/research/experts, plus the IP summary, IP progress, and Core Values starting tally in settings).

**Why not wrangler / D1 locally right now:** it needs an npm install (~100 MB of node_modules) inside a OneDrive folder, and there is no Cloudflare account yet (PROGRESS Phase 3). The same SQL moves to D1 when CJ deploys.

**Tradeoff accepted:** students' own app entries now live only in the database (and its snapshot) until Claude copies them into markdown at the next session. CLAUDE.md's session rhythm now includes that step.

**Still open (for CJ):** PIN gate, photo upload (R2), deploy; what to do with the sample rows; the database is a file in OneDrive, so run the server on one computer at a time.

---

## 2026-09-19 — Logo: no background behind the shield (students)

**Request (a student):** "for the logo make the black and white background go away but keep the logo the same other than that."

**Decision:** the logo image in the app's sidebar now has a **transparent background**. The original file had a black-to-white glow behind the hexagonal shield; everything outside the shield's dark green border was cut away. The shield itself (leaves, cross, trees, banner, circuit roots) is pixel-for-pixel unchanged. The soft drop shadow in the sidebar now follows the shield shape.

**Follow-up (same day):** "outline the logo with black so it doesn't blend in with the green background." A ~4 px black outline was added around the shield edge, baked into the image. Then: "make the outline of the logo a dark green" — outline recolored to a very dark green (#0e2617, darker than the sidebar's #1c3b2a) so it reads as a soft edge rather than a hard black line. Saved as `mockups/rooted-warriors-logo-outlined.png` (the plain transparent cut-out is kept too).

**App:** `mockups/14-rooted-warriors-app-v4.html` in place. The cut-out logo is also saved as `mockups/rooted-warriors-logo-transparent.png` for reuse (print, slides, the real app).

---

## 2026-09-19 — Coding gets its own page (students)

**Request (a student):** "in robot design take everything about coding and make a new section called coding."

**Decision:** **Coding** is now its own page in the sidebar (💻, right under Robot Design). Moved there from Robot Design: the programs table (program, who coded it, sensors, innovative bit) and the base-program-template note. Robot Design keeps the main robot, attachments, test sessions, and tradeoffs; its Programs spec line now just points to the Coding page.

**Added on the Coding page (views of data the app already had, no new facts):**
- **Mission Programs — Who Coded What:** every mission with an attachment, its builder, its coder, and a "written ✅ / needs a program" pill. The "needs a program" rows are the coders' to-do list. Header chip counts programs vs started missions (3 of 9 right now).
- **Coding Notebook Entries:** Daily Log entries that mention programming, newest first.

**Interpretation note:** "section" could also have meant a heading inside Robot Design. Built as a page because the sidebar items are what the team calls sections; easy to fold back in if they prefer.

**App:** new file `mockups/14-rooted-warriors-app-v4.html` (page-structure change → new number; v3 kept for comparison). All Sep 19 data carried over.

**Rubric:** the Robot Design CREATE row "Code / sensors" was the team's lowest self-rating. A page that shows every program, its coder, and what's clever about it is where that evidence lives.

---

## 2026-09-19 — Robot Design: the robot specs card is called "The Main Robot" (students)

**Request (a student):** "for robot design change the name of the robot from the actual robot thing to the main robot."

**Decision:** the Robot Design card that holds the robot specs (shape, wheels, sensors, base status, etc.) is now titled **The Main Robot**. The page subtitle changed to match ("The main robot · attachments · testing · code"). Their words, their name for it.

**App:** `mockups/13-rooted-warriors-app-v3.html` in place (label only).

---

## 2026-09-19 — Daily Log: notebook feed goes behind a button (students)

**Request (a student, their words):** "in the Daily log for the notebook feed make it a button to tap on and it takes you to the notebook feed. i dont want it to be to over welming at first sight."

**Decision:** the Daily Log page opens with just the **New Entry** form and the **Success Calendar**, plus one card with a big **📖 Open the Notebook Feed** button and a one-line teaser (how many entries, latest date and who). Tapping the button takes you to the full feed (all entries, newest first, filter chips by component or teammate) with a **← Back to Daily Log** button. Switching to the Daily Log from the sidebar always lands on the calm view first.

**Why it matters:** the students want the page they type into at practice to feel light. The full notebook is still one tap away for the judges. This is a UI-flow decision, not a data change — every entry still exists.

**App:** `mockups/13-rooted-warriors-app-v3.html` in place (small UI accommodation, same look).

---

## 2026-09-19 — Profile cards: three fields are each teammate's own to fill in (students)

**Request (a student, their words):** "For all the teammates other than Thea have us fill out what we learned, who we worked with most, and notebook entries but not the other ones."

**Decision:** on the Core Values team-spotlight cards, **Learned**, **Worked with most**, and **Notebook entries** are personal fields — each teammate writes their own. They now show "tap to fill in" for Fynn, Isla, Adeline, Nolan, and Weston. Thea's card already had those three blank. Every other field (emoji, role, favorite core value, favorite color, worked on most) stays exactly as Thea entered it on Sep 4.

**Why it matters for judging:** "what I learned" in each student's own words is Core Values evidence (Discovery) and Robot Design COMMUNICATE evidence. It is stronger when it is not written by a teammate.

**Follow-up (same day):** the Role line on four cards (Fynn, Isla, Nolan, Weston) still showed sample text from the v2 build. Flagged; the student said "change those role lines for us to fill in too." Cleared to "tap to fill in." Then "do it for Thea too" — Thea's role line cleared as well. Adeline's "Programmer" role is the only one kept (Thea entered it Sep 4). So each teammate now owns four fields on their card: Role, Learned, Worked with most, Notebook entries.

**App:** `mockups/13-rooted-warriors-app-v3.html` in place — the sample text in those three fields removed for the five teammates; "Notebook entries" no longer auto-counts, it is a typed field like the others.

---

## 2026-09-19 — Practice progress: three new missions, Keystone Species finished, third program (students)

**Milestones (Saturday, Sep 19):**
- **Thea finished the M13 Keystone Species attachment** (v1 was Sep 11). The team used the official name this time.
- **Isla built an attachment for M15 Biocentric Architecture** ("mission 15") — the 40-point mission, new to the inventory.
- **Nolan built the attachment for M02 Exploding Seeds** ("number 2") and **worked on M08 Tangled** ("number 8") — M08 new to the inventory. [unclear: is Nolan's "number 2" attachment the combined 2+3 build from Sep 4, or a separate one? The Mission 2 tradeoff (Adeline's vs Nolan's) is still open — ask.]
- **Weston built the attachment for M14 Seeds of Renewal** ("number 14") — new to the inventory; Weston's first attachment.
- **Fynn programmed M12 Forest Elder**; **Adeline programmed M04 Lucky Leaves** ("mission 4"). [unclear: Isla also wrote an M12 program Sep 11 — did Fynn improve it, or write a second version?]

**Totals:** 9 of 15 missions have an attachment started (280 of 440 pts). 3 missions have a program (M01, M04, M12). Zero test runs counted so far.

**Run plan (nudge, not a decision):** the DRAFT plan now has 8 runs of ~30 s = 245 s, far over the 150 s match. The team needs to decide which missions share a run. M13, M14, and M15 all sit on the interchangeable dock area — a natural grouping to try. Left as a question for the students.

**App:** `mockups/13-rooted-warriors-app-v3.html` updated in place (data only): inventory rows for M02 (Nolan), M08, M13 (finished → Working), M14, M15; Coded column for M04 and M12; three new attachment cards + new versions on the Keystone Species and Mission 2 cards; Coding table rows for M04 (Adeline) and M12 (Fynn); runs 6–8 in the draft plan; six Sep 19 notebook entries; Sep 19 Inclusion moment; proudest-moment quote.

**Rubric:** Robot Design DESIGN "all team members contributed" — all six students credited on one day, the strongest evidence yet. CREATE "Attachments" 6 → 9 missions. CREATE "Code / sensors" now has 3 programs. **Nudge:** ITERATE still has no evidence — three missions have both attachment and program, so the first counted test session is ready to happen.

**Aliases:** "mission 4" → M04 · "mission 15" → M15 · "number 2" → M02 · "number 8" → M08 · "number 14" → M14 · "the forest elder" → M12. Logged in `06-missions-bioglow.md`.

---

## 2026-09-11 — Practice progress: team mascot, first mission programs (students)

**Milestones:**
- **Thea** built the **team mascot** and an **attachment for "the mascot mission."** Best match: **M13 Keystone Species** — the only mission that needs a team-built piece (the keystone species the robot places on the restoration platform). So the mascot does double duty: team identity *and* 30 points. **[CJ: confirm "the mascot mission" = M13.]**
- **Adeline** wrote the **program for Drone Survey (M01)** — the first mission program of the season.
- **Isla** finished the **Forest Elder (M12) attachment** and wrote its **program**. Fynn created an M12 attachment on Sep 4 — [unclear: same attachment finished, or a second build? If two, that is a tradeoff row waiting to happen, like Mission 2.]

**Date:** [unclear: the update said "august 11". Today is Sept 11 and the work fits September (robot base finished Sep 6; Forest Elder attachment started Sep 4). Logged as 2026-09-11 until a student or CJ confirms.] If it really was Aug 11, move the Sep 11 entries in `updates/` and the app.

**App:** `mockups/13-rooted-warriors-app-v3.html` updated in place (data + one small card): M13 in the mission inventory with the alias and Thea credited; Mascot attachment card; M12 finished with Isla added as builder and coder; Coded column filled for M01 and M12; two rows in the Coding table; three Sep 11 notebook entries; run 5 (M13) in the draft run plan (now 155 s — over budget, on purpose, so the team sees it); new **Team Mascot** card on the Core Values page (name and photo blank for the students); Sep 11 Fun moment; proudest-moment quote.

**Rubric:** Robot Design CREATE "Code / sensors" was the team's lowest self-rating (1). Two mission programs are its first evidence. **Nudge:** re-rate it once the programs have been run and counted, and log that as the first test session (ITERATE).

**Alias:** "the mascot mission" → M13 Keystone Species, logged in `06-missions-bioglow.md`.

---

## 2026-09-06 — Robot base design decisions (students, dictated by CJ)

**Shape: low and wide.**
- Low → low center of gravity, so the robot is less likely to tip.
- Wide wheelbase → more accurate turning.
- **Tradeoff accepted:** harder to move in tight spaces on the field.

**Structure: reinforced.** The team added bracing to make the base more rigid.

**Sensors: none.** The team discussed using color sensors and decided not to use any sensors. **Reason:** the base is so compact there was no room left for a sensor. (Tradeoff accepted: no line/color detection — navigation relies on wheel rotations and turns.)

**App:** `mockups/13-rooted-warriors-app-v3.html` — Robot Design page: the wide-base tradeoff row now has the real *why*; two new tradeoff rows (reinforce vs light, color sensors vs none); Shape, Sensors, and Accuracy-vs-Speed specs filled in; a Sep 6 DESIGN notebook entry credited to the whole team.

**Rubric:** these are exactly the "identify → design → tradeoff" statements the Robot Design **DESIGN** row asks for. Every base choice now has options weighed, a pick, and a reason — the tradeoff table reads as *Accomplished* for the DESIGN row.

---

## 2026-09-06 — Robot base design finished; three copies built (students)

**Milestone:** **Thea, Nolan, and Weston** finished the design of the robot base (the drive chassis every attachment mounts to) and **built three identical copies** of it.

**Why it matters for judging:** the base has gone from "Weston is building it" (Sep 4) to a finished, repeatable design. Three matching bases means three attachments can be tested at the same time, and the team has a spare if one breaks at a tournament. That is Robot Design **CREATE** evidence, and it sets up **ITERATE** (test sessions) for every attachment.

**App:** `mockups/13-rooted-warriors-app-v3.html` updated in place (data only, same test build): robot-base status on the Robot Design page, a Sep 6 notebook entry credited to all three builders, and a new tradeoff row — "One robot base, or three identical copies?" — with the *why* left blank for the students to fill in.

**Nudge for next session:** ask the students *why* three copies. Their answer is the tradeoff worksheet entry. Also: the base is now stable enough to measure — the Size, Motors, Sensors, and How-attachments-attach specs are still blank.

---

## 2026-09-06 — Official BIOGLOW missions loaded; mission-alias convention (CJ)

**Source:** FLL Challenge BIOGLOW Robot Game Rulebook (`../fll-challenge-bioglow-rgr.pdf`, pp. 5, 8–12). Captured into **`06-missions-bioglow.md`**: 15 missions with numbers, official names, bag numbers, every scoring condition and bonus, max points, the 🚫 no-equipment flag, plus Equipment Inspection (20) and Precision Tokens (up to 50). Everything on the field = **500 max**.

**Convention (standing instruction from CJ):** whenever the team calls a mission by anything other than its official name or number, record the alias in the alias log at the bottom of `06-missions-bioglow.md`, mapped to the official mission. Current aliases: "Mission 2" → M02 Exploding Seeds · "Mission 3" → M03 Flip the Rock · "Mission 12" → M12 Forest Elder. Drone Survey / Lucky Leaves / Flip the Rock are used as-is.

**App:** `mockups/13-rooted-warriors-app-v3.html` — Robot Game mission inventory replaced with the real 15 missions (max pts, how it scores, "we say" line for aliases, 🚫 flag). Attachments, notebook feed, tradeoff table, robot specs, coding table, and the run plan now show **actual** progress from Aug 26 – Sep 4. Sample practice scores and sample test sessions removed; those cards show a "log your first one" prompt. Run plan is marked DRAFT (built from the attachments in progress; all times are 30 s guesses). Innovation Project page is still sample data and labelled as such.

**Confirmed by CJ (same day):**
- "Mission 2 / 3 / 12" in the Sept 4 notes are official mission numbers (M02, M03, M12). ✅
- Piece counts from the built models: 3 seeds (M02), **4** leaf fragments (M06 — rulebook picture shows only 3, so M06 max is 40), 3 seeds (M14). Field total is 440 mission pts, 510 with inspection + precision tokens.

**For CJ (architecture):** the mission list is static season data — good candidate for a seed table rather than user-entered rows.

---

## 2026-09-04 — Practice progress: profiles, attachments, base program (students)

**App:** **Thea** updated the profile cards for every teammate in the v2 test build — the first real team data in the app.

**Attachments (who built what):**
- Mission 2 — **Adeline** (worked on it)
- Missions 2 + 3, combined into one attachment — **Nolan** (worked on it)
- Mission 12 — **Fynn** (created)

**Robot base:** **Weston** continued building the robot base.

**Programming:** **Adeline** created the initial program template for the robot base — the starting point every mission program will be built from.

**Follow-up for the app:** Mission 2 now has two attachment efforts (Adeline's, and Nolan's combined 2+3 version). Good nudge for the Robot Design page: how will the judges see which one the team chose, and why? That's a tradeoff-worksheet entry waiting to happen.

---

## 2026-08-31 — Robot Game: mission attachment progress (students)

**Milestone:** Built the attachments for the **Drone Survey** and **Lucky Leaves** missions.

**Still in progress:** The **Flip the Rock** mission attachment isn't finished yet.

**Who built what:**
- Drone Survey — **Isla**
- Lucky Leaves — **Fynn**
- Flip the Rock (in progress) — **Nolan**

---

## 2026-09-04 — Layout chosen: "Sidebar HQ" (Layout A) → App v1 test build

**Decision (students):** Of the five Rooted Warriors layouts (mockups 06–10), the team picked **06 Sidebar HQ** — dark forest-green side menu with the crest, cards on cream.

**Built:** `mockups/11-rooted-warriors-app-v1.html` — first clickable version to test. One self-contained file, sample data, no saving yet.

Pages in v1 and what each covers from the checklist:
- **Dashboard** — best score + chart, mission inventory, 20-row rubric heat map, six-value tally, proudest-moment quote, who-did-what contribution bar, latest entries.
- **Robot Game** — editable mission inventory (status dropdown + reliability slider), run plan vs. 150 s with swap time, points-per-second leaderboard, log-a-match form (confetti on a new high score), score history with failed → changed trail.
- **Robot Design** — robot specs (shape, wheels, motors, sensors, wire management, size, attach method, accuracy-vs-speed), coding table (who coded it, sensors, innovative bit), attachments with version timeline (photo slots), test sessions (observation → change → result) + add-test form, tradeoff decisions table.
- **Innovation Project** — Problem / Solution / How-we-got-here, 8-step progress, Gantt chart colored by owner (click a bar → iterations), research collection, experts with feedback → improvement.
- **Core Values** — team profile cards (photo, role, fav value, fav color, worked-on-most, learned, worked-with-most), six-value tally, add-a-moment form, help given ↔ received, recent moments.
- **Daily Log** — new-entry form (date, component, rubric phase, who, text, core values spotted, photo slot), Aug + Sep success calendar, filterable feed (by component or by student).
- **Rubric Check** — all 20 rows with 1–4 buttons, ⚙️ marks, evidence count per phase.

**App Notes items now covered:** mission strategy, attachments (accuracy/consistency, over time w/ pictures, size, who made it, purpose), robot shape/wheels/motors/wires/attach/size, accuracy vs speed, coding (who, innovative), sensors, end-of-practice success calendar, IP main page (problem/solution/how we got here), research collection, Gantt with member colors + click for iterations, experts with feedback, team profile (pictures, worked on most, learned, favorite color, worked with most).

**v2 (same day):** `mockups/12-rooted-warriors-app-v2.html` — real logo embedded in the sidebar; real team roster **Thea, Adeline, Fynn, Isla, Nolan, Weston** replaces the placeholder names. Everything else (roles, favorite values, missions, scores, entries) is still sample data until the students enter their own. `PROGRESS.md` brought up to date.

**Profile cards (Sept 4):** every fact on a team profile card is now tap-to-edit in the app; blank fields show "tap to fill in." First real card: **Thea** — works on the Innovation Project most, favorite core value Fun, favorite color lavender purple; "Learned," "Worked with most," and "Notebook entries" left blank for her to fill in. Other five cards still carry placeholder facts until each student edits their own. Profile-picture ring = the student's favorite color (typed words like "lavender purple" or "dark green" are turned into a color automatically; changing the Fav color field re-colors the ring). Adeline's emoji: 😏; favorite color light pink; role: Programmer; favorite core value Fun; works most on programming. Isla's favorite color: brown, emoji 💩. Nolan's favorite color: teal, emoji 😂, favorite core value Teamwork, works most on attachments. Weston's favorite color: green, emoji 😁, favorite core value Teamwork, works most on building. Thea's emoji 🫠. Fynn's emoji 🤪, favorite core value Fun, works most on programming, favorite color: light yellow ("light/pale/pastel" now lightens the ring automatically).

**Still to design (nudge list):** photo upload for real, tournament countdown to more than one event, "print the notebook" export view, judge-view mode. **For CJ:** saving/persistence (Cloudflare D1), photo storage (R2), team PIN.

---

## 2026-08-31 — Team identity: "Rooted Warriors" logo + official app palette

**Decision:** The team's logo is final: a hexagonal badge with a tree whose trunk is a cross, lavender/green leaves, forest hills, a lavender "ROOTED WARRIORS" banner, and teal circuit-board roots. The app will use the logo's colors as its palette:

- Forest green `#1c3b2a` (dark base / headers)
- Pine green `#2a5c3f` · Grass green `#3f9b4c` (accents, "good" status)
- Lavender `#b48fd9` · Lilac `#d9c6ee` (banner, highlights)
- Circuit teal `#20b5c9` (tech/roots accents)
- Cream `#f4efe1` (light background)

**Status:** Mockups 06–10 (in `mockups/`) apply this palette across 5 different layouts for the students to vote on. Layout not yet chosen. Earlier mockups 01–05 were color-theme explorations from before the logo existed.

---

## 2026-08-31 — Architecture: Cloudflare Workers + D1 + R2 (CJ)

**Decision:** The app will be a real input-driven web app, not a markdown-compiled static site. Stack:

- **Hosting:** Cloudflare **Workers static assets** (not Pages — Pages is in maintenance mode as of 2026). Free tier: unlimited static asset requests, 100k Worker requests/day, no card required.
- **Database:** Cloudflare **D1** (SQLite). Free tier: 5 GB storage, 5M row reads / 100k row writes per day. Hard-stops at limits — cannot surprise-bill.
- **Photos:** Cloudflare **R2** object storage, served through the Worker. Free tier: 10 GB storage, zero egress fees. Requires a card on file (still $0 within limits). Compress images client-side before upload.
- **API:** One Worker with JSON endpoints (Hono or plain fetch handlers), owned by CJ.
- **Auth:** Shared team PIN checked in the Worker — simplest thing that works for students on shared devices.

**Why:**
- Cost is the #1 constraint; this is $0 for the whole season with hard caps, no idle-pause, no expiry, no deploy limits.
- Students log their own entries directly (per `05-daily-log.md`: distributed, ≤10 min, student-written). The markdown + LLM-compile alternative made CJ the pipeline after every meeting and diluted the student-written evidence judges look for.
- Because all photos/API calls route through the Worker, the site can be access-gated for free (PIN, or Cloudflare Access — free ≤50 users). No free static host offers that, and the site will contain photos of minors.

**Rejected alternatives:**
- **Markdown files + LLM compile → static HTML:** kept only as the *export path* — a "print the notebook" view rendering season entries as a clean document for judging tables that expect paper. Not the data store.
- **Supabase** (runner-up): least backend code (built-in REST/storage/auth, no card), but 7-day idle pause needs a keep-alive ping and photo storage is only 1 GB.
- **Netlify:** new-account free tier gutted Sept 2025 (~20 deploys/mo, sites go offline at credit cap).
- **Firebase:** photo storage now requires the uncapped pay-as-you-go plan (Oct 2025 change).
- **PocketBase:** no free hosting left in 2026. **Turso:** no file storage, plan-churn risk. **GitHub Pages:** free tier requires a public repo (photos of kids).

**Open (for CJ):**
- PIN-gate the whole site vs. public dashboard with obscure URL (privacy of student photos says PIN-gate; judges-view convenience says public). Leaning PIN.
- Whether to use Cloudflare Access instead of a hand-rolled PIN.

**Note for students (kid-friendly version):** the app will live on the internet for free, everyone gets to add their own log entries and photos from any device, and there's a secret team code to get in.

---

## 2026-08-28 — Robot Design: drive tires chosen (students)

**Decision:** The robot will use the **49.5 × 20 mm tires** for the drive wheels.

---

## Week of 2026-08-24 — Robot Design: wide wheel base + base robot built (students)

**Decision:** The robot will have a **wide wheel base**.

**Milestone:** The team **built the base robot** (the core chassis that attachments will mount to).
