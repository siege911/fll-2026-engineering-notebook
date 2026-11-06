# App Progress Tracker

One page showing how far along the app is, from first idea to "done and in use at practice."
Update this at the end of every session (same time as `DECISIONS.md` and `mockups/GALLERY.md`).

**Status key:** ⬜ not started · 🟡 in progress · ✅ done

**Last updated:** 2026-11-02 (Robot Design: attachment photos on the mat for M02+M03, M04, M08+M09, M12, M14, M15) · 2026-11-02 (Innovation Project: Project Photos card, first photos = Nov 1 camera soldering) · 2026-11-02 (Coding page: Our Robot Code, the `code/` folder's history of every program, read live) · 2026-11-02 (Coach CJ: Innovation Project Details section: parts list, camera wiring diagram, click-to-open code + install guides for the camera, Pi and website) · 2026-11-01 (Adeline: every mission has an attachment, only M06 + M07 left to program; M04 + M05 4/5; first M11 program; camera soldering by Nolan + Weston) · 2026-10-23 (Thea: camera wired by Nolan + Thea; M13 programmed by Isla; first M09 attachment + program by Weston) · 2026-10-12 (robot: M11 first attachment, M12 + M13 rebuilt, M04 + M05 programmed) · 2026-10-12 (Innovation Project: camera parts bought, camera box wiring plan in `updates/CAMERA-BUILD.md`) · 2026-10-05 (Innovation Project: first real expert, Nate Reagan from Game and Fish; Experts card shows dates + full notes; sample experts/research removed; later: ALL sample data removed, Innovation Project Problem/Solution/How, 8 steps and Project Plan are now fill-in boxes) · 2026-10-03 (Thea — Innovation Project: picked the Raspberry Pi build, parts list) · 2026-10-02 (AI forest wildlife camera idea saved to the app) · before that 2026-09-28 (CJ — the app now runs on a real database: `app/`, v5 · later: students' real profile pictures added)

**Team:** Rooted Warriors — Thea, Adeline, Fynn, Isla, Nolan, Weston · Coach CJ

---

## The big picture

| Phase | Status | Notes |
|---|---|---|
| 1. Design the capture (what info the app collects) | 🟡 | Every component now has a visual in the v2 app; students still need to add/cut/rename fields in their own words, one component per session |
| 2. Prototype playground (what it looks like) | ✅ | Colors = Rooted Warriors logo palette · Layout = Sidebar HQ (06) · fun stuff (confetti, avatars, countdown, proudest-moment quote) in the app |
| 3. Architecture (CJ) | ✅ | Cloudflare Workers + D1 + R2, team PIN — see `DECISIONS.md` 2026-08-31 |
| 4. Build the real app | 🟡 | **v5 (`app/`) saves to a database** since Sept 28 — all data through Sep 25 loaded, every form saves. Runs on a local dev server (`cd app && npm run dev`). Not on the internet yet, no PIN. Profile pictures ✅ (Sep 28, from `app/images/`); attachment photos ✅ for 7 attachments (Nov 2); photo upload not yet |
| 5. Team starts using it at practice | ⬜ | The finish line — first test: each student logs one real entry in v2 at practice |

---

## Phase 1 — Capture design, by component

For each one: list what the docs say to capture → students add/cut/rename → decision recorded in `DECISIONS.md` → quick visual prototyped.

| Component | Wish-list in App Notes? | Fields decided & recorded? | Visual prototyped? |
|---|---|---|---|
| Robot Design | ✅ (attachments, robot specs, coding, success calendar) | 🟡 v2 shows a proposed set — students to confirm · ✅ Coding page shows the real code from `code/`, every version (Nov 2) | ✅ v2 Robot Design page |
| Robot Game | ✅ ("probably all in Robot Design") | 🟡 v3 has its own page (inventory, run plan, scores, reliability) — students to confirm that's OK · ✅ official 15 missions + points loaded (`06-missions-bioglow.md`) | ✅ v3 Robot Game page |
| Innovation Project | ✅ (problem/solution page, research, Gantt chart, experts) | 🟡 v2 shows a proposed set — students to confirm · ✅ Communication (Oct 26) · ✅ Innovation Project Details: parts, wiring, code + install guides (Nov 2, CJ) · ✅ Project Photos (Nov 2) | ✅ v2 Innovation Project page |
| Core Values | ✅ (team profile cards) | 🟡 v2 adds moments, six-value tally, help given/received — students to confirm · ✅ profile cards filled in for all six teammates (Thea, Sept 4) | ✅ v2 Core Values page |
| Daily Log / Notebook feed | ⬜ (not in App Notes yet — nudge) | 🟡 v2 entry form: date, component, rubric phase, who, text, core values spotted, photo | ✅ v2 Daily Log page |
| Rubric self-assessment (20 rows) | ⬜ (not in App Notes yet — nudge) | 🟡 v2: 1–4 per row + evidence count | ✅ v2 Rubric Check page |

## Phase 2 — Look & feel

| Decision | Status |
|---|---|
| Colors | ✅ Rooted Warriors logo palette (forest, lavender, teal, grass, cream) — `DECISIONS.md` 2026-08-31 |
| Navigation / layout | ✅ Sidebar HQ (`06`) chosen Sept 4 out of 5 layouts |
| Widget-level looks (charts, cards, heat map) | 🟡 first versions in v2 — refine with students as they use it |
| Fun stuff (mascot spot, confetti, avatars, countdown) | ✅ real logo in the sidebar, confetti on new high score, initial avatars, Nov 14 countdown, proudest-moment card |

## Phase 3 — Architecture (CJ's list)

| Item | Status |
|---|---|
| Stack chosen (Workers + D1 + R2) | ✅ |
| Local stage: dev server + SQLite, D1-compatible schema (`app/`) | ✅ Sept 28 |
| PIN-gate whole site vs. public URL | ⬜ open — leaning PIN |
| Cloudflare Access vs. hand-rolled PIN | ⬜ open |
| Cloudflare account + card on file for R2 | ⬜ |

## Phase 4 — Build

| Piece | Status |
|---|---|
| Data model / D1 schema | ✅ `app/db/schema.sql` (21 tables) + `seed.sql` (everything through Sep 25) + dated `db/updates/` files |
| Worker API endpoints | 🟡 same routes run in the local Node server (`app/server.mjs`); port to a Worker at deploy |
| Log entry form (student-facing) | ✅ saves to the database (v5) |
| Dashboard pages (4 components + dashboard + log + rubric + coding) | ✅ all 8 read from the database (v5, Sept 28) — Coding page added Sept 19 at the students' request |
| Photo upload → R2 | ⬜ placeholder slots in v2 |
| PIN login | ⬜ |
| "Print the notebook" export view | ⬜ |
| Deployed at real URL | ⬜ |
| Test run at a practice | 🟡 Sept 4: Thea used v2 to update every teammate's profile card — first real data entered · Sept 6: real missions + build progress loaded into v3, robot base marked done · Sept 11: a student typed the practice update themselves (mascot, first programs) · Sept 19: student update again — six students, nine missions in progress |

---

## Comprehensiveness checklist (from CLAUDE.md — must all be covered before design is "done")

✅ = has a working home in v2 · students may still rename/cut

- [x] Rubric self-assessment view — all 20 rows, rated 1–4 (Rubric Check page + dashboard heat map)
- [x] Daily log entry + browsable feed with photos (Daily Log page; photo = placeholder slot)
- [x] Who-did-what tracking on entries, attachments, and programs (who-picker on entries; built-by / coded-by on missions, attachments, programs; contribution bar on dashboard)
- [x] Innovation Project: steps, research, decisions, experts, feedback → improvement trail
- [x] Robot Design: tradeoff worksheets, test sessions, observation → change → result trail
- [x] Robot Game: mission inventory, run plan vs. 150s, score-over-time chart, reliability %
- [x] Core Values: daily moments, six-value tally, help given/received
- [x] Team Spotlight: per-student card + team gallery (Core Values page — all six cards filled in by Thea on Sept 4)
- [x] Season calendar / tournament countdown (sidebar countdown; Aug–Sep success calendar)
- [x] Something celebratory (confetti + toast on new high score, proudest-moment quote)

## Robot build progress (the real robot, not the app)

What the team has actually built so far — this is the stuff the app's Robot Design and Robot Game pages will hold once saving works.

| Date | Piece | Official mission | Who | Status |
|---|---|---|---|---|
| Aug 31 | Drone Survey attachment | M01 Drone Survey | Isla | ✅ built |
| Aug 31 | Lucky Leaves attachment | M04 Lucky Leaves | Fynn | ✅ built |
| Aug 31 | Flip the Rock attachment | M03 Flip the Rock | Nolan | 🟡 in progress |
| Sep 4 | "Mission 2" attachment | M02 Exploding Seeds | Adeline | 🟡 worked on |
| Sep 4 | Combined attachment for "Missions 2 + 3" | M02 Exploding Seeds + M03 Flip the Rock | Nolan | 🟡 worked on |
| Sep 4 | "Mission 12" attachment | M12 Forest Elder | Fynn | ✅ created |
| Sep 4 | Robot base (the drive chassis) | — | Weston | 🟡 continued building |
| Sep 6 | Robot base — design finished, **3 identical copies built** | — | Thea, Nolan, Weston | ✅ done |
| Sep 4 | Program template for the robot base (starting point for every mission program) | — | Adeline | ✅ initial version |
| Sep 11 [date to confirm] | Team mascot + "mascot mission" attachment | M13 Keystone Species [confirm with CJ] | Thea | ✅ built |
| Sep 11 [date to confirm] | Forest Elder attachment finished + its program | M12 Forest Elder | Isla | ✅ finished + programmed (not run/counted yet) |
| Sep 11 [date to confirm] | Drone Survey program | M01 Drone Survey | Adeline | ✅ written (not run/counted yet) |
| Sep 19 | Keystone Species attachment finished | M13 Keystone Species | Thea | ✅ finished |
| Sep 19 | "mission 15" attachment | M15 Biocentric Architecture | Isla | ✅ built |
| Sep 19 | "number 2" attachment [unclear: the combined 2+3, or separate?] | M02 Exploding Seeds | Nolan | ✅ built |
| Sep 19 | "number 8" attachment | M08 Tangled | Nolan | 🟡 worked on |
| Sep 19 | "number 14" attachment | M14 Seeds of Renewal | Weston | ✅ built |
| Sep 19 | Forest Elder program | M12 Forest Elder | Fynn | ✅ programmed [unclear: Isla's Sep 11 program improved, or a second one?] |
| Sep 19 | "mission 4" program | M04 Lucky Leaves | Adeline | ✅ written (not run/counted yet) |
| Sep 25 | "mission 12" program | M12 Forest Elder | Thea | ✅ programmed [unclear: same program as Isla's/Fynn's, improved?] |
| Sep 25 | "mission 15" attachment + program | M15 Biocentric Architecture | Isla | ✅ built + programmed |
| Sep 25 | "mission 14" program | M14 Seeds of Renewal | Fynn | ✅ written |
| Oct 2 | "mission 14" program + first test | M14 Seeds of Renewal | Fynn | ✅ **tested 5/5 (100%)** |
| Oct 2 | "mission 15" + "mission 12" programs | M15, M12 | Adeline | ✅ finished (not tested yet) |
| Oct 2 | "2 and 3" program + test | M02 + M03 | Nolan | ✅ **tested 5/5 (100%)** |
| Oct 2 | "the tree mission" attachments | [unclear] | Weston | 🟡 worked on |

Missions with an attachment started: **9 of 15** (M01, M02, M03, M04, M08, M12, M13, M14, M15) — worth 280 of the 440 mission points on the field. Mission programs written: **7 missions** (M01 Adeline · M02 + M03 Nolan · M04 Adeline · M12 Isla + Fynn + Thea + Adeline · M14 Fynn · M15 Isla + Adeline). Test runs counted: **2 sessions** (M14 5/5, M02 + M03 5/5, both Oct 2). Full list and scoring in `06-missions-bioglow.md`.

## Session log

Newest at top. One short entry per practice.

### 2026-10-12 (Thea, app polish)
- **App:** Robot Game difficulty now reads "2/5" tight and centered; Rubric Check has a "What the numbers mean" card at the top (and the old gray line under the title is gone); every card got a thick lavender frame (Thea picked option E from mockups #15–#16).
- **Rubric language:** Core Values: Thea led the look of the team's app and chose from options. That's *Teamwork*/*Inclusion* evidence of a student making a real design decision.

### 2026-10-02 (student update)
- **Robot Game:** Fynn programmed **M14 Seeds of Renewal** and ran the season's **first test session: 5/5**. M14 → Working, 100%.
- **Also:** Adeline finished the M12 + M15 programs; Nolan programmed M02 + M03 (his first) and tested **5/5**; Weston worked on "the tree mission" attachments. Programs 5 → **7 missions**.
- **Rubric language:** Robot Design ITERATE "Testing" moves off *Beginning* for the first time — two counted, dated test results on one day.

### 2026-09-28 (no practice — CJ, app build)
- **App:** v5 in `app/`, a dev server and database. Everything from the practice logs through Sep 25 is in the database, and the pages look exactly like v4. Every form saves now, so students can log their own entries at practice.
- **How updates work now:** markdown first, then a dated file in `app/db/updates/`, then start the dev server and check the page (CLAUDE.md).
- **Rubric language:** a notebook that keeps every student-written entry, dated and credited, is the base for every COMMUNICATE and "all team members" row.

### 2026-09-25 (Friday practice — student update)
- **There:** Thea, Isla, Fynn. **Away:** Nolan, Weston, Adeline.
- **Programming:** Thea programmed **Forest Elder (M12)** (her first program). Isla built and programmed the **M15 Biocentric Architecture** attachment. Fynn programmed **M14 Seeds of Renewal**. Programs: 3 → **5 missions**.
- **Rubric language:** Robot Design CREATE "Code / sensors" keeps moving from *Developing* toward *Accomplished* — five mission programs by four different coders. DESIGN "skills in all members": Thea (a builder) now codes too. ITERATE "Testing" still *Beginning* — zero counted runs.
- **Open:** M12 has three coders (same program?); did the M15 attachment change?
- **App:** v4 updated in place — Coding page, attachment cards, notebook, Teamwork moment, quote.

### 2026-09-19 (Saturday practice — student update)
- **Attachments:** Thea finished **Keystone Species (M13)**. Isla built **M15 Biocentric Architecture**. Nolan built **M02 Exploding Seeds** and started **M08 Tangled**. Weston built **M14 Seeds of Renewal** — his first attachment. Three missions new to the inventory in one day.
- **Programming:** Fynn programmed **Forest Elder (M12)**; Adeline programmed **Lucky Leaves (M04)**. Three missions now have a program.
- **Rubric language:** Robot Design DESIGN "all team members contributed" — every one of the six students is credited with a build or a program on the same day. That row reads as *Accomplished* for this practice. CREATE "Attachments" moved from 6 to 9 missions. ITERATE "Testing" is still *Beginning* — no counted runs yet, but three missions are ready to test.
- **Open:** Nolan's "number 2" vs the combined 2+3; Fynn's vs Isla's M12 program; the draft run plan is 245 s.
- **App:** v3 updated in place — practice data; then three student UI requests the same day: Role / Learned / Worked with most / Notebook entries blanked on the profile cards for each teammate to fill in, the Daily Log's notebook feed moved behind an "Open the Notebook Feed" button so the page is calm at first sight, the specs card renamed "The Main Robot," and **Coding became its own page → v4** (`mockups/14-rooted-warriors-app-v4.html`).

### 2026-09-11 (date per the student: "august 11" — logged as Sept 11 until confirmed)
- **Mascot:** Thea built the **team mascot** and an attachment for "the mascot mission" — best match M13 Keystone Species, where the robot delivers a team-built creature. The mascot is that creature. [confirm with CJ]
- **Programming:** Adeline wrote the **Drone Survey (M01) program**. Isla **finished the Forest Elder (M12) attachment** and wrote its program. First two mission programs of the season.
- **Rubric language:** Robot Design CREATE "Code / sensors" moves from *Beginning* (self-rated 1, no evidence) toward *Developing* — two programs exist, credited by coder. Running them and counting successes is the next step toward *Accomplished* on ITERATE.
- **App:** v3 updated in place — M13 in the inventory, Mascot attachment, Coding rows, Team Mascot card on the Core Values page, three notebook entries.

### 2026-09-06 (no practice — coach update)
- **Robot base:** Thea, Nolan, and Weston finished the base design and built **three identical copies**. Every attachment now has a base to test on, with a spare.
- **Base decisions (dictated by CJ):** low + wide base — low center of gravity, wide wheelbase for accurate turns, tradeoff = harder in tight spaces. Reinforced the base for rigidity. Discussed color sensors, decided on **no sensors** — the compact base had no room for one.
- **Rubric language:** a finished, repeatable base is Robot Design **CREATE** moving toward *Accomplished*; three copies set the team up for **ITERATE** (test sessions) — the next thing to log.
- **Missions:** official BIOGLOW mission list (numbers, names, points, bags) captured from the Robot Game Rulebook into `06-missions-bioglow.md`, with an alias log for the names we use ("Mission 2" = M02 Exploding Seeds, etc.).
- **App:** v3 test build loads the real 15 missions, Equipment Inspection, and Precision Tokens; attachments, notebook entries, and robot specs now reflect what the team actually built.

### 2026-09-04
- **App:** Thea updated the profile cards for every teammate in v2 — the first time real team data went into the app.
- **Attachments:** Adeline worked on the Mission 2 attachment. Nolan worked on combining the Mission 2 and Mission 3 attachments into one. Fynn created an attachment for Mission 12.
- **Robot base:** Weston continued building the robot base.
- **Programming:** Adeline created the initial program template for the robot base.
- **Rubric language:** two students building attachments for the *same* missions and then combining them is evidence for Robot Design "Evaluate → iterate" moving from *Developing* toward *Accomplished*; a shared base template is evidence for "Plan / clear mission strategy."

### 2026-08-31
- **Attachments:** Drone Survey (Isla) and Lucky Leaves (Fynn) built; Flip the Rock (Nolan) in progress.
- **App:** logo palette + five layout mockups (06–10) ready for the vote.

## Still to design with the students

- Their own words for every field label (one component per session)
- ~~Real roles, favorite values/colors, "what I learned" on each profile card~~ ✅ done Sept 4 (Thea) — each student can still tweak their own
- Why three copies of the base? (students write the tradeoff *why* — row is waiting on the Robot Design page)
- Measure the finished base: size, motors, how attachments attach (specs still blank)
- Name the mascot and add its picture to the Team Mascot card (Core Values page)
- Confirm "the mascot mission" = M13 Keystone Species, and whether the practice was Aug 11 or Sept 11
- Forest Elder attachment: did Isla finish Fynn's, or are there two? (tradeoff row if two)
- Tournament calendar beyond Nov 14 (scrimmages, state?)
- "Print the notebook" view for judging tables
- Judge-view mode (read-only, no forms)
