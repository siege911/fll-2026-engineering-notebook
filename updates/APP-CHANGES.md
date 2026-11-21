# App Changes

Changelog for the app in `../mockups/`. One line or short block per change, **newest at top**. Record it even for tiny data edits so a rebuild can be checked against this list. Gallery with verdicts: `../mockups/GALLERY.md`.

Format:
```
## YYYY-MM-DD
- **File:** mockups/NN-....html
- **What:** 
- **Why / who asked:** 
```

Backfilled 2026-09-06 from `../DECISIONS.md`, `../PROGRESS.md`, and `../mockups/GALLERY.md`.

## 2026-11-20 — Run Plan: run 3 marked skipped
- **File:** app/public/index.html
- **What:** Run Plan & Time Check reads `settings.game_plan.skip`: a run whose missions are all skipped (run 3, M04 + M05) is crossed out in the table with a "skipped · time" tag and left out of the time bar and the totals ("8 runs (run 3 skipped) · 178s driving + 28s swaps = 206s"). The run row itself is unchanged in the data.
- **Why / who asked:** student [who?]: "Yes, mark it."

## 2026-11-20 — Top Practice Score card on the Dashboard
- **Files:** app/public/index.html · app/db/updates/2026-11-20m-skip-m04-m05.sql (new setting `game_plan`: skip M04 + M05, why "time")
- **What:** New first card on the Dashboard: best practice match score (400) "of" top possible score (460) with a percent bar (87%). Top possible is worked out from the data: every mission not in `game_plan.skip` + Equipment Inspection + Precision Tokens. The hint says which missions we skip and why. Hidden if no matches are saved.
- **Why / who asked:** student [who?]: "Show top practice score was 400 but top possible score is 460. We skipped Missions 4 & 5 due to time."

## 2026-11-20 — Thu + Fri practice entries, best score 400 (data only)
- **File:** app/db/updates/2026-11-20l-practice-400.sql (4 notebook entries Nov 19 + Nov 20; practice match 400 saved on Nov 20). No card shows matches right now (Best Match Score + Score History were removed earlier today).
- **Why / who asked:** student [who?].

## 2026-11-20 — Rubric Map card removed from the Dashboard
- **File:** app/public/index.html
- **What:** The Dashboard's Rubric Map card is gone. Who's Been Doing What is now full width so the last row isn't half empty. The 20 rubric ratings are still saved in the data but nothing in the app shows them now.
- **Why / who asked:** student [who?]: "Remove it too."

## 2026-11-20 — Rubric Check page removed
- **File:** app/public/index.html
- **What:** The Rubric Check page and its menu button are gone. The Dashboard's Rubric Map card stays (counts of rows at each level) but its "Rate →" button and click-through were removed, since there's no page to go to. The 20 ratings are still saved in the data.
- **Why / who asked:** student [who?]: "Get rid of the rubric trek page" (Rubric Check).

## 2026-11-20 — Small people circles: color + first letter
- **File:** app/public/index.html
- **What:** Every small person circle (names on entries, missions, attachments, Who's Been Doing What, the who-picker buttons, Daily Log people buttons) now shows the person's color with the first letter of their name instead of a tiny photo. The big profile pictures on Core Values → Team Profile are unchanged.
- **Why / who asked:** student [who?]: "With all the really tiny profile pictures that we can't see, make the circle just the color of whoever it is, with the letter of their first name. Don't change the larger circle of each person on the Core Values page."

## 2026-11-20 — Mascot photo + Nate Ragan's pictures
- **Files:** app/db/updates/2026-11-20k-mascot-nate-photos.sql · app/server.mjs (experts send `photo`, `tphoto`) · app/public/index.html · app/images/11-20-mascot.jpg, 11-20-mascot-square.jpg, 11-20-nate-ragan-with-team.jpg, 11-20-profile-nate-ragan.jpg (from ../photos/)
- **What:** New experts columns `photo` (profile picture) and `team_photo`. Experts card: Nate's round profile picture (cropped from the left of the team photo) and the full photo of Nate with the team underneath, captioned "Nate Ragan (left) with the Rooted Warriors". Core Values → Team Mascot: the empty "Photo" box is now the mascot photo (click for the big one).
- **Why / who asked:** student [who?]: "We added our Team Mascot Photo and a Picture of Nate Ragan with the Team. Nate Ragan is the guy on the left if we want to crop it for a profile picture."

## 2026-11-20 — Emojis removed from the whole app
- **Files:** app/public/index.html · app/db/updates/2026-11-20j-no-emojis.sql
- **What:** No emojis anywhere in the app: menu icons, buttons ("Save match"), pop-up messages, hints, tags, the run plan's timer and buffer marks, the IP computer tiles, code-history markers, the view-only badge. Where an emoji meant something it became words or numbers: calendar legend "Purple = practice day · Green = match day"; Help Given ↔ Received shows counts instead of dots; rubric rows that also count for Core Values show "CV" instead of a gear; expert and profile fallbacks show the first letter. Data: removed ✅ and 📷 from attachment version notes, ✅ from "Robot base status", and the Wi-Fi emojis from a Pi file description. Install guides shown on the IP page hide their emojis (the guide files themselves keep them, since they name buttons on the Pi). Kept: plain arrows (→ ↔ ↗) and the robot code exactly as written. Team faces, the expert's face and the computer icons are still saved but not shown.
- **Why / who asked:** student [who?]: "There are a lot of emojis throughout the entire app. Can you get rid of all of them?"

## 2026-11-20 — Robot Game + Robot Design combined into one page, in talk order
- **File:** app/public/index.html
- **What:** The Robot Game page is gone; its cards moved onto Robot Design, now called **Robot Design & Game** (nav button too). Card order follows the Robot Design talk: 1 Isla — The Main Robot, Tradeoff Decisions, Mission Inventory, Run Plan & Time Check · 2 Adeline — Who's Been Doing What (copy of the Dashboard card) · 3 Weston — Attachments Over Time · 4 Fynn — Test Sessions, Points-per-Second Leaderboard, Log a Practice Match · 5 Thea — Our Robot Code (copy of the Coding card) · 6 Nolan — no card. The old Run Plan copy is now the real card. Run Plan and Points-per-Second are full width now, so they no longer scroll sideways. Dashboard's Mission Inventory "Edit →" opens this page.
- **Why / who asked:** student [who?]: "combine the robot game and robot design but make it go along like the script."

## 2026-11-20 — Attachments Over Time: one picture + a version list
- **File:** app/public/index.html
- **What:** Robot Design → Attachments Over Time. Each attachment shows only its newest picture (its main photo, or the newest version photo if it has no main one). Versions are now a dated bullet list ("Aug 31 · V1 built ✅"); a version with an older picture gets a "📷 picture" link that opens it. Removed the small version thumbnails and the striped empty boxes. Hint text changed to "Newest picture on top · click 📷 to see an older version".
- **Why / who asked:** student [who?]: "Just show the latest attachment picture. List the adjustments over time as a list with a link to older pictures … don't put smaller thumbnail pictures or striped empty boxes."

## 2026-11-20 — Small text a bit bigger, whole app
- **File:** app/public/index.html
- **What:** Every CSS font size under 13px raised: 9→11, 10→12, 11→13, 12→13 px (about 50 places: table headers, tags, hints, labels, meta lines, run-plan bar). 13px and up unchanged. Chart text inside SVG drawings (font-size="8"–"12") not changed: it scales with the drawing. Side effect: on Robot Game, the Run Plan and Points-per-Second tables are a little wider than their cards at laptop width and scroll sideways.
- **Why / who asked:** student [who?]: "make all the really small text a bit bigger."

## 2026-11-20 — How attachments attach off the Main Robot card (data only)
- **File:** app/db/updates/2026-11-20i-drop-how-attach.sql
- **What:** Deleted the blank robot_specs row "How attachments attach" (Robot Design → Main Robot).
- **Why / who asked:** student [who?]: "get rid of how attachments attach too."

## 2026-11-20 — Size + Wire management off the Main Robot card (data only)
- **File:** app/db/updates/2026-11-20h-drop-size-wires.sql
- **What:** Deleted the two blank robot_specs rows "Size (W × D)" and "Wire management" (Robot Design → Main Robot).
- **Why / who asked:** student [who?]: "just get rid of that column and the wire management."

## 2026-11-20 — Difficulty for M11–M15 (data only; fixes a mistake)
- **File:** app/db/updates/2026-11-20f-reliability-counts.sql (mistake: saved as reliability + test sessions) → app/db/updates/2026-11-20g-difficulty-not-reliability.sql (fix)
- **What:** Difficulty M11 3, M12 3, M13 2, M14 2, M15 3. Removed the 5 wrong test rows and notebook entry; reliability for M11–M15 put back to the slider estimates set in the app.
- **Why / who asked:** Thea.

## 2026-11-20 — Tradeoff pick renamed: "No color sensors"
- **File:** app/db/updates/2026-11-20e-no-color-sensors.sql
- **What:** Robot Design → Tradeoff Decisions, "Color sensors, or no sensors?": pick "No sensors" → "No color sensors".
- **Why / who asked:** Thea. The robot does use the hub's gyro, so "No sensors" could confuse a judge.

## 2026-11-20 — Temporary page removed; Score History removed
- **File:** app/public/index.html
- **What:** Score History card (match chart + match table) taken off the Robot Game page; Log a Practice Match stays. Then the whole **Temporary** page was removed (nav link + page), with the cards on it: 8-Step Progress (off the IP page Nov 17), Best Match Score (off the Dashboard today), Score History. Matches logged in the app are still saved in the data; only these displays are gone. Old versions are in git history if a card should come back.
- **Why / who asked:** Thea: "get rid of score history in robot game", then "get rid of the temporary page".

## 2026-11-20 — Blanks filled from our judging talks (data only)
- **File:** app/db/updates/2026-11-20d-fill-blanks-from-talks.sql
- **What:** Tradeoffs (tires, three bases, combined 2 + 3, new no-gears robot), robot specs (Motors, Sensors = gyro), "Sensors" on every mission program, 3 notebook entries (3 ideas, Pi → tiny camera, no-gears robot).
- **Why / who asked:** Thea: "fill out anything that hasn't been filled out." Only facts from the Nov 15 talks and the Final v3 code; the rest stays blank (list in ROBOT-DESIGN.md 2026-11-20).

## 2026-11-20 — Dashboard: Best Match Score removed, Mission Inventory full width
- **File:** app/public/index.html
- **What:** Took the "Best Match Score" card (big number + score chart) off the Team Dashboard. Mission Inventory now spans the full width of the page. The score-over-time chart is still on the Robot Game page.
- **Why / who asked:** Thea.

## 2026-11-20 — Final v3 robot code
- Data only: `code/Final v3 - Nov 18/` (new Pybricks backup) + `app/db/updates/2026-11-20b-final-v3-code.sql` (notebook entry) + `2026-11-20c-final-v3-who.sql` (Fynn + Isla made it). Asked by [who?]. `site/` re-exported.

## 2026-11-20 — New photos: robot base, team photo, profile pictures, final attachment photos
- **Files:** `app/db/updates/2026-11-20-new-photos.sql`, `app/images/11-20-*.jpg` (smaller copies of `photos/`), `app/public/index.html`, `site/` (export)
- **What:** Robot Design → The Main Robot shows the robot base photo (`settings.robot_photo`). Core Values → Team Profile shows the team photo on top (`settings.team_photo`). New profile pictures for all six. Each attachment's main photo is now the Nov 20 final-form one; the little version boxes in Attachments Over Time now show their photo (Nov 2 and Nov 20), click to see it big. Lucky Leaves attachment now listed for M04 + M05; mascot attachment for M13 + M12 (cane).
- **Why / who asked:** [who?] added the `photos/` folder: "There is a picture of the base robot to add to Robot Design… updated pictures of all of the attachments… a Team picture and updated each of the student pictures." `mission 12a.jpg` not used (same file as `mission 14.jpg`).

## 2026-11-19 — View-only website copy for Regionals (`site/`)
- **Files:** `app/export-static.mjs` (new), `app/package.json` (`npm run export`), `app/public/index.html`, `site/` (generated), `.claude/launch.json` (`site-preview`)
- **What:** `npm run export` (from `app/`) builds `site/`: the app page with all the database data and the shared code files / install guides baked in (`window.VIEW_ONLY`), plus `logo.png` and `images/`. In that copy nothing can be typed or saved: forms and "Tap to fill in" blanks are hidden, status menus and rubric buttons are locked, and the sidebar says "👀 View-only copy · saved <date>". It also tells search engines not to list it. The laptop app works exactly as before. The database is only read.
- **Why / who asked:** CJ, to put the notebook online (free static hosting from GitHub) for the competition without touching the database.
- **Remember:** the online copy only changes when someone runs `npm run export` and pushes `site/`.

## 2026-11-17 — Innovation Project + Robot Design follow the judging script; new Temporary page
- **File:** `app/public/index.html`
- **What:** Cards reordered so scrolling down the page matches the script (`presentation/2026-11-17-judging-script.md`), top to bottom.
  - Innovation Project: The Problem (Isla) → Experts & Their Feedback, Research Collection, Project Plan (Gantt) (Adeline) → Our Solution, Project Photos (Thea) → Camera Wiring Diagram, The Code & How to Install It, Communication (Nolan) → How We Got Here (Weston) → Innovation Project Details: Parts We Ordered. The Problem / Our Solution / How We Got Here strip was split into three separate cards so each sits where its speaker talks.
  - Robot Design: The Main Robot, Tradeoff Decisions (Isla) → Attachments Over Time (Weston) → Test Sessions (Fynn). Tradeoffs moved up from the bottom.
  - New **Temporary** page (last in the sidebar): cards taken off a page go here instead of being deleted. The 8-Step Progress card is back, on this page.
- **Later:** The Main Robot card made full width, like the other Robot Design cards (student request).
- **Later:** Robot Design also shows **live copies** of the script's cards from other pages (originals stay where they were): Run Plan & Time Check (Robot Game) and Who's Been Doing What (Dashboard) after Tradeoff Decisions, Our Robot Code (Coding) at the bottom. Page order now: The Main Robot → Tradeoff Decisions → Run Plan → Who's Been Doing What → Attachments Over Time → Test Sessions → Our Robot Code. Built with `data-mirror` + `setupMirrors()`; `rcShow` opens the program on the page you're looking at. Tap-to-fill blanks in the copies save normally.
- **Nothing deleted.** Cards the script shows from other pages (Run Plan on Robot Game, Who's Been Doing What on Dashboard, Our Robot Code on Coding) stayed where they were.
- **Why / who asked:** A student [who?]: "so we can scroll from top to bottom on our script and it matches."

## 2026-11-17 — Innovation Project: Experts card moved up
- **File:** `app/public/index.html` (`#page-ip`)
- **What:** The Experts & Their Feedback card (Nate Ragan) now sits right under the first box (The Problem / Our Solution / How We Got Here), above Research Collection. It used to be after 8-Step Progress. Then the Project Plan (Gantt) card moved right under Experts, so the order is now: first box → Experts → Gantt → Research Collection → 8-Step Progress → Communication. Last, the **8-Step Progress card was removed** (the page skips it when it's missing; step data still in the database). See DECISIONS.md. Then the **Camera Wiring Diagram** card moved up from Innovation Project Details to right under the Gantt chart (above Research Collection), and **The Code & How to Install It** card moved right under the wiring.
- **Why / who asked:** A student [who?] wanted Nate Ragan's box higher up the page.

## 2026-11-15 — Coding page: "Final" code folders
- **Files:** `app/robotcode.mjs`, `app/public/index.html`; data `app/db/updates/2026-11-15d-final-code.sql`; folder `code/Final v1` → `code/Final v1 - Nov 3`
- **What:** Our Robot Code now reads folders named `<name> - Mon D` (e.g. `Final v2 - Nov 9`) and shows the name under the date. A loose `.py` beats a zip copy of the same name in one folder. Mission numbers read from names like `mission12a.py` / `mission13_12b.py`. A new program that grew out of an old one (`mission4.py` → `mission4_5.py`) shows "grew from …" and its first version shows what changed from the old one. Files with no mission number (`main_base.py`, `robot.py`) show their first comment line. Each version shows who made it (`robot_code_who`). Data: Fynn in "Coded by" for 11 missions, Adeline's mission menu in Programs We've Written, notebook entries Nov 3 / 9 / 13.
- **Why / who asked:** Coach CJ added Final v1, v2, v3 to the code folder.
- **Later same day:** `code/Final v3 - Nov 13` removed (moved to the Trash): same files as Final v2 and as the Nov 15 hub backup, which was added to `Final v2 - Nov 9`. Data: `app/db/updates/2026-11-15e-no-final-v3.sql` (Final v2 credited to Adeline + Fynn; Nov 13 notebook entry no longer says "Final v3"). Coach CJ asked.

## 2026-11-15 — Tournament date: Regionals Nov 21
- **Data:** `app/db/updates/2026-11-15c-tournament-nov21.sql` (sidebar countdown). Word doc + practice timer headers say Nov 21 too. Who asked: Coach CJ.

## 2026-11-15 — Nov 9 / 13 / 14 practices + Coach CJ's notes
- **Data:** `app/db/updates/2026-11-15b-practices-nov9-14.sql`: Communication (Thea's brother, ADOT), Gantt (solar panels, trifold, ADOT), Fynn's attachment fine-tuning, every mission → Working, 5 notebook entries, "Reagan" → "Ragan".
- **File:** `app/public/index.html`: dates with no known day show "date?" instead of breaking the Communication table.
- **Also (not the app):** judging talks fixed (research lines, facts, spelling, typos, Mission 14) in the Word doc, timer and `PRESENTATION.md`.
- **Who asked:** Coach CJ.

## 2026-11-15 — Judging talks: team's own words (not part of the app)
- **File:** `presentation/Rooted-Warriors-Judging-Talks.docx`, `presentation/2026-11-14-judging-script.html`
- **What:** talk words replaced with the team's hand edits; Show + Notes rewritten; the timer now says how far over 5:00 a talk is. No app change.
- **Why / who asked:** Coach CJ's account, for the team. Suggested app reorder + documentation to-do: `APP-TALK-ORDER-AND-TODO.md`.

## 2026-11-15 — Camera v4 in Innovation Project Details (data only)
- `app/db/updates/2026-11-15-camera-v4.sql`: Wildlife Camera row → Camera v4 (Nov 15), new status, v4 files first, v3 listed as older. Camera Station "last big change" → Nov 15 (stalled-send fix). Facts in `updates/CAMERA-BUILD.md` 2026-11-15. [who? asked]

## 2026-11-14 — Nolan's research + links in the Research Collection
- **Files:** `app/db/updates/2026-11-14b-nolan-crossing-research.sql` (9 research rows found by Nolan + notebook entry; new `research.url` column), `app/server.mjs` (sends `url`), `app/public/index.html` (each source in the Research Collection is a link that opens its website, with ↗).
- **Why / who asked:** [who?]: "Nolan did a bunch of Research for the team. Please add this Research to our App including some key points from each of these websites." Links added so judges can open the real sources.

## 2026-11-14 — Removed Our Judging Talk from the app (Coach CJ)
- **Files:** `app/public/index.html`, `app/server.mjs` (talk cards, talk save route and `/presentation` route removed; both files back to their pre-Nov 13 versions), `app/README.md`, `app/db/updates/2026-11-14-remove-talk-parts.sql` (drops `talk_parts`).
- **Why / who asked:** Coach CJ: "Remove the presentation talking points from the Season App and just give me a Word Doc to download." → `presentation/Rooted-Warriors-Judging-Talks.docx`.

## 2026-11-13 (round 6) — Robot Design talk: one turn each (data + script page)
- `app/db/updates/2026-11-13g-rd-one-turn-each.sql`: 12 Robot Design parts merged into 6 (one per student, two rubric rows each, in order). `presentation/2026-11-14-judging-script.html`: same merge in its built-in copy; "Who Says How Much" now says everyone talks once in each talk. [who? asked]

## 2026-11-13 (round 5) — Innovation talk: one turn each (data + script page)
- `app/db/updates/2026-11-13f-ip-one-turn-each.sql`: 12 Innovation parts merged into 6 (one per student, two rubric rows each, in order). `presentation/2026-11-14-judging-script.html`: same merge in its built-in copy; intro and "Who Says How Much" text updated. [who? asked]

## 2026-11-13 (round 4) — Judging talk (data only)
- `app/db/updates/2026-11-13e-weston-adeline-swap.sql`: Weston ↔ Adeline (Sharing / Improvements). Same in `presentation/2026-11-14-judging-script.html` and `updates/PRESENTATION.md`. [who? asked]

## 2026-11-13 (latest) — Judging talk round 3 (data only)
- `app/db/updates/2026-11-13d-adeline-fynn-swap.sql`: Adeline ↔ Fynn (Research / Pride); Weston's line "After Fynn's research" → "After our research". Same in `presentation/2026-11-14-judging-script.html` and `updates/PRESENTATION.md`. [who? asked]

## 2026-11-13 (even later) — Judging talk round 2 (data only)
- `app/db/updates/2026-11-13b-talk-swap.sql`, `2026-11-13c-nolan-problem-wording.sql`: Isla's opening back to the first version; Nolan ↔ Adeline (Problem definition / Pride); Nolan's problem part longer. Same text in `presentation/2026-11-14-judging-script.html` (built-in copy) and `updates/PRESENTATION.md`. [who? asked]

## 2026-11-13 — Our Judging Talk, editable in the app
- **Files:** `app/db/updates/2026-11-13-judging-talks.sql` (new table `talk_parts`, 24 parts), `app/server.mjs` (talk parts in `/api/data`; `PATCH /api/talk_parts/<id>` can change the words, who says it, and what to show, and records `edited_at` + `source = 'app'`; serves `/presentation`), `app/public/index.html` (new **🎤 Our Judging Talk** card at the top of the Innovation Project page and the Robot Game page), `presentation/2026-11-14-judging-script.html` (when opened from the app at `/presentation`, it shows the app's words; double-clicked, it uses its own Nov 13 copy).
- **What:** every part of both talks, in rubric order, with ✏️ Edit, a speaker picker, the time estimate (calm pace, with hand-offs) vs. 5:00, and each person's word count. The text is also in `updates/PRESENTATION.md`.
- **Why / who asked:** [who?] "make it to where we can make manual changes to the innovation and robot game paragraphs through the app." Same request: Isla's opening got more detail; Isla and Weston switched Team involvement ↔ Explanation & impact.

**From 2026-09-28 on**, the live app is `../app/` (page: `app/public/index.html`, data: `app/db/`). Data-only changes get one line naming their `app/db/updates/` file.

## 2026-11-09 (practice 2026-11-08)
- **File:** `app/db/updates/2026-11-09b-m12-parts-points.sql` + `app/server.mjs` + `app/public/index.html`: new `runs.part_points`; the run plan's Est. pts counts only the M12 part done in each run (run 6 support tie 10, run 8 cane 20) instead of 30 twice. Team answered which part goes where.
- **File:** `app/db/updates/2026-11-09-m12-two-parts.sql`: data only: runs 6 and 8 notes say M12 part 1 / part 2 (team answered why M12 is in two runs).
- **File:** `app/db/updates/2026-11-08-mission-times-trifold.sql` (+ fix `2026-11-08b-moment-help-fix.sql`)
- **What:** data: run plan rebuilt as Fynn + Isla's 9 timed run groups; M01 12 s, M12 7 s; M10 → Prototyping; M15 "fix yellow arm" note; notebook entries for the timing and the trifold boards; Teamwork moment. New `runs.timed_on` and `runs.note` columns. Photo of the notes: `app/images/11-8-mission-timing-notes.webp`.
- **File:** `app/server.mjs`, `app/public/index.html`
- **What:** Robot Game run plan: Time column shows ⏱ for really-timed runs and "guess" for the rest; new Notes column (the team's margin notes); the DRAFT line counts how many runs are timed. Points-per-second hint lists the real mission times.
- **Why / who asked:** [who?] sent Fynn + Isla's timing notes; the app had no way to tell a real time from a 30-second guess.

## 2026-11-09 — Pi station: Problems page; tagging survives AI crashes
- **Files:** `pi/station/server.py` (batches of 5, one at a time after a crash, set aside after 2 crashes, problem list + `/api/problems`, `/api/problems/retry`), `store.py` (`retry_failed`), `ai.py` (plain-words error, `-X faulthandler`), `public/index.html` (⚠️ Problems page + badge, purple Home banner removed, shorter menu buttons), `pi/README.md`, `pi/INSTALL.md`.
- **Why / who asked:** [who?]: "maybe we create a dedicated page for viewing errors so we can see them if needed but not on the Home page", after SIGILL crashes.

## 2026-11-08 — Pi station: tagging works with no internet
- **Files:** `pi/station/ai.py` (finds the downloaded SpeciesNet model and passes `--model`), `pi/station/server.py` (`speciesnet_model` setting), `pi/INSTALL.md` (offline check).
- **Why / who asked:** [who?] sent the tagger error: `Failed to resolve 'api.kaggle.com'` in 📡 Camera Wi-Fi mode.

## 2026-11-08 — Pi station: Live picture through the Pi; real tagger error on screen
- **Files:** `pi/station/server.py` (`/api/live.jpg` gets the camera's picture; `/api/time` and Live count as hearing from the camera), `pi/station/public/index.html` (Live page loads from the Pi, one picture at a time, says why if the camera doesn't answer; error banner shows the error's last lines). Data: `app/db/updates/2026-11-08-camera-sends.sql`.
- **Why / who asked:** [who?]: "The Live page on the Pi just shows 'Camera at IP address'. I want the actual live camera." and the "tagger helper had a problem" banner.

## 2026-11-08 — Pi station: 🌐 House Wi-Fi joins any remembered Wi-Fi
- **Files:** `pi/station/network.py` (finds remembered Wi-Fi in range, strongest first; keeps the failure reason after falling back), `pi/station/public/index.html` (shows which Wi-Fi it's on), `pi/station/server.py` + `pi/settings.example.json` (`house_connection` blank by default), `pi/NETWORKING.md`, `pi/INSTALL.md`, `pi/README.md`. Data: `app/db/updates/2026-11-08-pi-wifi-any-remembered.sql` (Pi row's version/updated).
- **Why / who asked:** [who?] at the office: "Can we just have the Home Wifi automatically connect to a WiFi that it already remembers from the OS?"

## 2026-11-08 — Camera install guide: how to format the microSD card on a Mac
- **File:** `camera/INSTALL.md` (step 1, new "Formatting the microSD card on a Mac": Disk Utility, MS-DOS (FAT), Master Boot Record). Shown in Innovation Project Details by itself; no data change.
- **Why / who asked:** [who?] asked "What do we need to do to format the micro SD for the camera on a Mac?"

## 2026-11-05 — Innovation Project install guides point to our GitHub repo
- **Files:** `pi/INSTALL.md` (step 3: deploy key + clone `siege911/fll-2026-engineering-notebook`; new "Getting new code later"), `droplet/INSTALL.md` (step 4, same), `camera/INSTALL.md` (where to get the code). Shown in Innovation Project Details by themselves; no data change.
- **Why / who asked:** Coach CJ, "Update the instructions for the Innovation Project to this repo", after the folder went up to GitHub.

## 2026-11-02 — Robot Design: each attachment card shows its photo on the mat
- **Files:** `app/images/11-2-mission-{15,12,14,8-9,2-3,4}.jpg` (sent as .webp, saved as .jpg), `app/db/updates/2026-11-02-attachment-photos.sql` (new column `attachments.photo`; M08 + M09 share one photo + a version note "one attachment does both"), `app/server.mjs` (`photo` in the attachments API), `app/public/index.html` (Attachments Over Time: photo under the purpose, whole picture shown, click to see it big).
- **Why / who asked:** [who?] "these are the photos of the attachments with the missions. put these in the app". Mission per photo answered by the student.
- **Still not shown:** the older photos `8-31-…`, `9-4-…`, `9-25-mission-*.jpg` in `app/images/`.

## 2026-11-02 — Innovation Project: new "Project Photos" card (Nov 1 soldering photos)
- **Files:** `app/images/11-1-soldering-1.jpg`, `11-1-soldering-2.jpg` (sent as .webp, saved as .jpg), `app/db/updates/2026-11-02-ip-solder-photos.sql` (new table `ip_photos`: date, who, caption, photo), `app/server.mjs` (`ip_photos` in the API), `app/public/index.html` (Project Photos card above Innovation Project Details: photo grid, click to open full size, who + date + caption under each).
- **Why / who asked:** [who?] "nov 1 we did sodering so put these pictures in innovation progect for the app". The app had no spot for Innovation Project photos, so this adds one (small card, rule 7). Evidence for Innovation Project CREATE.

## 2026-11-02 — Coding: Our Robot Code marks which copy the robot runs
- **Files:** `app/db/updates/2026-11-02-m13-code-copy.sql` (new setting `robot_code_runs`: file name → date the copy was first saved; `mission13.py` → copy B, Oct 5), `app/public/index.html` (`renderRobotCode`: "✅ the robot runs this one" / "not the one the robot runs"; the 🤔 question only shows for files not decided yet).
- **Why / who asked:** [who?] answered "Copy B (Oct 5)".

## 2026-11-02 — Coding: new "Our Robot Code" card (the code/ folder in the app)
- **Files:** `app/robotcode.mjs` (new: reads `code/` — one `M-D` folder per practice, Pybricks backup zips and loose `.py` files; tells apart new / changed / same-as-before; read-only, `.py` only), `app/server.mjs` (`robot_code` in `GET /api/data`), `app/public/index.html` (`#page-coding`: Our Robot Code card: history grid program × practice, then each program's versions newest first with what changed (green added, red taken out) and Copy; `renderRobotCode`, `lineDiff`).
- **No database change:** the code is read straight from the folder, like the camera code on the Innovation Project page, so new practice folders show up by themselves. Written record: `updates/ROBOT-CODE.md`.
- **Why / who asked:** [who?] "we have all of our code in the code folder. Incorporate it into the app."

## 2026-11-02 — Innovation Project: new "Innovation Project Details" section
- **Files:** `app/db/updates/2026-11-02-ip-details.sql` (new tables `ip_parts`, `ip_wiring`, `ip_platforms` + their rows), `app/server.mjs` (the three tables; `GET /api/file?path=…` read-only viewer for the code/guides listed in `ip_platforms`, never secrets; `exists` flag per file), `app/public/index.html` (`#page-ip`: section header + Parts We Ordered, Camera Wiring Diagram (SVG drawn from `ip_wiring`), The Code & How to Install It (3 computers, click to open each guide/file); `renderIPDetails`, `wiringSvg`, `ipdOpen`, `md` mini markdown reader).
- **New docs:** `camera/INSTALL.md`, `droplet/INSTALL.md` (placeholder plan).
- **Why / who asked:** Coach CJ: parts, wiring diagram, click-to-open code for the ESP32 / Pi / DigitalOcean, install steps for each, placeholders for what isn't built. Keep it updated with major changes (rule in `CLAUDE.md`).

## 2026-11-01 — Data: Adeline's practice update (+ Oct 26 app entries)
- `app/db/updates/2026-11-01-m04-m05-m11-solder.sql` — M04 + M05 Working at 80% (4/5 test, Adeline); first M11 program (Weston, Nolan); M08 Working; M06 + M07 attachments (Nolan, Oct 26; Weston worked on them Nov 1); Isla added to M04/M05 coders (Oct 26); Fynn-helped-Weston moment (Oct 26); 5 notebook entries incl. camera soldering (Nolan, Weston). Told by Adeline.

## 2026-10-26 — Dashboard: swapped Rubric Map and Latest Notebook Entries
- **File:** app/public/index.html
- **What:** "Latest Notebook Entries" (still the full-width box) moved up to where the rubric box was, right under Best Match Score and Mission Inventory. The rubric box (same 4 count boxes, same size) moved to the bottom, next to "Who's Been Doing What", and is renamed "Rubric Heat Map" → "Rubric Map".
- **Why / who asked:** Thea: "on the dashboard can you switch the rubric heat map and change the name to rubric map with the latest notebook entries but keep the same shapes".

## 2026-10-26 — Data: removed a share Thea typed in Communication
- `app/db/updates/2026-10-26-remove-share-test.sql` — deleted the share typed in the app at 23:31 (Oct 11, "Theas family", Thea, "They really liked it."). Thea: "I just loged somthing in communication can you take it out and delete it." Saving from the Communication form works (this row proved it).

## 2026-10-26 — Innovation Project: new "Communication" section
- **Files:** `app/db/updates/2026-10-26-ip-communication.sql` (new `shares` table + first row: Oct 5, Nate Ragan), `app/server.mjs` (`shares` table; the page may add rows), `app/public/index.html` (`#page-ip`: new Communication card at the bottom, after Experts; `renderShares`, `addShare`).
- **What:** a table of every time we shared our project (date, who we shared with, who shared, what they said, what we changed) and a form under it to add a new one (date, who we shared with, pick who shared, what they said, what we changed).
- **Why / who asked:** Thea: "in innovation can you make a new section that is called communication." Picked "Sharing our project" from 4 options.
- **Not tested:** saving a new row from the form (it would add a fake share to the real notebook).

## 2026-10-26 — Innovation Project: Project Plan (Gantt) filled in
- **Data:** `app/db/updates/2026-10-26-ip-gantt.sql` — 9 bars from the dated notes in `INNOVATION-PROJECT.md` / `CAMERA-BUILD.md` (7 real, Oct 2 – Oct 26; 2 marked "suggested" with guessed dates: real camera + Pi test, presentation practice to Nov 14). Same table in `INNOVATION-PROJECT.md` 2026-10-26.
- **File:** `app/public/index.html` (`.gantt .gbar` + `renderIP`): a bar too short to fit the owner's name no longer squashes it; the name is hidden there (the picture next to the task, and hovering the bar, still show who).
- **Why / who asked:** Thea: "for the gantt chart can you fill it out using all the information you have."

## 2026-10-26 — Innovation Project: Research Collection and 8-Step Progress swapped
- **File:** `app/public/index.html` (`#page-ip`): Research Collection now comes right after Problem / Solution / How We Got Here, and 8-Step Progress moved to where Research Collection was (after the Project Plan, before Experts). New order: Problem/Solution/How → Research Collection → Project Plan → 8-Step Progress → Experts.
- **Why / who asked:** Thea: "in innovation project switch the research collection and the 8-step progress."

## 2026-10-26 — Dashboard: Rubric Heat Map shows how many of each number
- **File:** `app/public/index.html` (`renderDash` `#d-heat`, new `.heatcount` styles): the 20 little rating boxes are replaced by 4 big count boxes, in the same colors: how many rows are rated 4 (Exceeds, green), 3 (Accomplished, teal), 2 (Developing, lavender), 1 (Beginning, beige). Hovering a box lists which rubric rows have that number; tapping goes to Rubric Check. The line under it now just says "Grow every row to 3+ by Nov 14!" (the counts it used to list are in the boxes).
- **Why / who asked:** Thea: "change it to how many of each number is there." Picked "4 count boxes only" from 3 options (4 count boxes only / count boxes + the 20 / count bars).

## 2026-10-23 — Robot Game: Score History + Log a Practice Match move with the other boxes
- **File:** `app/public/index.html` (`#page-game` Leaderboard card: `grid-row:span 2; align-self:start`). On a narrower screen (two columns) Score History and Log a Practice Match used to drop to a new row below the very tall Points-per-Second Leaderboard, far from the Run Plan, so they didn't move up and down with it when a mission button was tapped. Now the Leaderboard takes up two rows on the right, and Score History + Log tuck right under the Run Plan on the left and move with it. On a wide screen (three columns) they stay in their own column on the right.
- **Why / who asked:** Thea: "when i press a mission on robot game score history and log a practice match didnt move with everything else. like up or down. please fix that."

## 2026-10-23 — Robot Game: Log a Practice Match moved under Score History
- **File:** `app/public/index.html` (`#page-game`): Score History and Log a Practice Match now stack together in the right-hand column; the Run Plan & Time Check box stands on its own on the left (still ending after its table). Leaderboard stays in the middle. (Replaces the Oct 12 layout where the match log sat under the Run Plan.)
- **Why / who asked:** Thea: "put log a practice match under score history."

## 2026-10-23 — Robot Game: Score History box ends after its table
- **File:** `app/public/index.html` (`#page-game` Score History card, `align-self:start`): the box used to stretch as tall as the Points-per-Second Leaderboard next to it, leaving a big empty space. Now it ends right after its own table, with its top lined up with the boxes beside it. (Same fix as the Run Plan box on Oct 12.)
- **Why / who asked:** Thea: "in robot game in score history the box is way to long make it shorter and line everything up after."

## 2026-10-23 — Whole-app error check; wide tables now stay inside their boxes
- **Checked:** all 8 pages. No server errors, no browser errors, no "undefined"/"NaN" text, no broken pictures. Empty boxes (Score History chart, Project Plan) show their "nothing yet" messages, as they should.
- **Fixed — File:** `app/public/index.html` (`.card` style: `min-width:0; overflow-x:auto`). The Points-per-Second Leaderboard table (Robot Game) and the Mission Inventory table (Dashboard) were wider than their boxes, so their last column spilled out under the next box. Now a too-wide table scrolls sideways inside its own box.
- **Why / who asked:** Thea: "can you check the entire app for any errers."

## 2026-10-23 — Core Values: Isla's picture ring is Mango orange
- `app/db/updates/2026-10-23-isla-ring-mango.sql` — Isla's ring → #ffa53d. Thea picked it from 4 orange swatches.

## 2026-10-23 — Core Values: Adeline's picture ring is Cotton Candy
- `app/db/updates/2026-10-23-adeline-ring-cotton-candy.sql` — Adeline's ring → #f9a8d4. Thea picked it from 4 pink swatches.

## 2026-10-23 — Core Values: Fynn's picture ring changed to Sunshine
- `app/db/updates/2026-10-23-fynn-ring-sunshine.sql` — Fynn's ring #fbe89a → #ffd84d. Thea: "actualy i want it to be sunshine."

## 2026-10-23 — Core Values: Fynn's picture ring is Lemon Chiffon
- **Files:** `app/db/updates/2026-10-23-fynn-ring-lemon.sql` (new `team.ring_color` column; Fynn = #fbe89a), `app/server.mjs` (team field `ring`), `app/public/index.html` (`renderCV`: ring uses `ring` if set, else the teammate's app color).
- **Why / who asked:** Thea: "for fynns color around the picture make it a lighter pretty yellow" → picked Lemon Chiffon from 4 yellow swatches.

## 2026-10-23 — Core Values: profile-picture rings back to each teammate's own color
- **File:** `app/public/index.html` (`renderCV` Team Profile cards): the ring around each profile picture now uses the teammate's app color (the same color as their little avatars and bars) instead of following the typed "Fav color." Removed the old favorite-color-to-ring code (`favHex`, `COLOR_WORDS`, `tint`, `shade`). Rings are back to: Thea lavender, Fynn yellow, Isla red, Adeline pink, Nolan teal, Weston green.
- **Why / who asked:** Thea: "we changed the colors on core values but i didnt want the line around the profile pictures to change to the color of the favorite color. change it back to how it was." (After the team typed new favorite colors in the app, Isla's ring had turned pink and Nolan's white.)

## 2026-10-23 — Coding: side note taken off "Mission Programs — Who Coded What"
- **File:** `app/public/index.html` (`#page-coding`): removed the small grey note next to the title ("Every mission with an attachment, and whether its program exists yet").
- **Why / who asked:** Thea: "for the same section get rid of the saying on the side of the title."

## 2026-10-23 — Coding: one button per mission on "Mission Programs — Who Coded What"
- **File:** `app/public/index.html` (`renderCoding`, new `codeMissionTable` / `pickCodeMission`): the same lavender **All, M01 … M15** buttons as Robot Game's Mission Inventory now sit above the Coding page's "Mission Programs — Who Coded What" table. Tap a mission to see only its row (even a mission not started yet, so you can fill in its coder); **All** shows every started mission like before.
- **Why / who asked:** Thea: "for coding for the mission programs-who coded it change it to the same buttons of each mission as robot game in the mission inventory."

## 2026-10-23 — Robot Game: "150 SECONDS" label taken off the top
- **File:** `app/public/index.html` (`#page-game` page header): removed the purple "150 SECONDS" chip next to the Robot Game title. The time limit still shows as the red 150 s line in the Run Plan & Time Check box.
- **Why / who asked:** Thea asked what it was ("whaat is the 150 seconds thing"), then: "take it away."

## 2026-10-23 — Robot Game: Run Plan box renamed "Run Plan & Time Check"
- **File:** `app/public/index.html` (`#page-game` Run Plan card title): "Run Plan vs. 150 s" → "Run Plan & Time Check".
- **Why / who asked:** Thea: "the title is confusing." Picked from 4 options (Run Plan (150-Second Match) / Do Our Runs Fit in 2½ Minutes? / Run Plan & Time Check / Our Match Plan).

## 2026-10-23 — Data: camera wiring, M13 program, M09 attachment + program
- `app/db/updates/2026-10-23-camera-wiring-m13-m09.sql` — new M09 attachment + program (Weston), M13 program (Isla), M09 status → Prototyping, notebook entries, Core Values moment (Thea helped Nolan). Told by Thea.

## 2026-10-12 — Data: robot work (M11, M12, M13, M04, M05)
- `app/db/updates/2026-10-12-robot-m11-m12-m13-m04-m05.sql` — new M11 attachment, M12 + M13 rebuilds, M04/M05 coders and statuses, notebook entries, Core Values moment (Isla helped Fynn). Told by [who?].

## 2026-10-12 — Robot Game: Log a Practice Match moved under the Run Plan
- **File:** `app/public/index.html` (`#page-game`): Run Plan and Log a Practice Match now stack together in the left column, so the match log sits right under the Run Plan (filling the empty space next to the Points-per-Second Leaderboard). Score History stays at the bottom.
- **Why / who asked:** Thea: "move up the log in robot game to go after the plan run."

## 2026-10-12 — Robot Game: Run Plan box ends after its last run
- **File:** `app/public/index.html` (Run Plan card, `align-self:start`): the Run Plan box used to stretch to match the Points-per-Second Leaderboard next to it (15 rows), leaving a big empty space under "Tangled." Now it ends right after its own table.
- **Why / who asked:** Thea: "why is the box for the run plan so long when the information stops after tangled."

## 2026-10-12 — Robot Game: Run Plan time bar fixed
- **File:** `app/public/index.html` (`renderGame`, `.runplan` styles): the colored bar above the Run Plan table was broken. Runs 5–8 had no color (only 4 colors were set up for 8 runs), every box said "R1 — · 30s" so the words got cut off into junk, and the "0s / 75s / 150s" under it was wrong because the bar actually stretched to 273 s. Now: colors repeat so every run has one; each box just says R1…R8 (hover shows its missions and time); the swap gaps are drawn to scale; a red dashed **150 s** line shows where the buzzer goes off, so you can see which runs don't fit; the ruler reads 0s → the plan's real total.
- **Why / who asked:** Thea: "in the run plan section something is wrong with the thing above the table can you fix it."

## 2026-10-12 — Robot Game: one button per mission
- **File:** `app/public/index.html` (`missionTable`, new `pickMission`): a row of buttons above the Mission Inventory table on Robot Game: **All, M01 … M15**. Tap a mission's button and the table shows only that mission's row (same columns, still editable); tap **All** to see every mission again. Hovering a button shows the mission's name. Dashboard's mission list is unchanged.
- **Why / who asked:** Thea: "for robot game make a bunch of buttons for each mission but in the mission nothing else changes." Picked "Show only that mission" from 3 options (jump to row / show only that mission / pop-up card). Then (Thea): "yes make it lavender" → the tapped mission button is lavender instead of dark green (`.filterbar.lav`; the Daily Log filter buttons stay green).

## 2026-10-12 — Lavender frames on every card (option E)
- **File:** `app/public/index.html` (`.card` style): every card's thin beige border is now a thick lavender (#b48fd9) border. Options compared first in `mockups/15-more-purple-options.html` and `mockups/16-more-lavender-options.html`.
- **Why / who asked:** Thea: "add a little bit more purple because that is the team color" → only our lavender → "i like E."

## 2026-10-12 — Rubric Check: gray line under the title taken off
- **File:** `app/public/index.html` (`#page-rubric` header): removed the small line under "Rubric Check" ("Rate ourselves honestly, 1–4 · ⚙️ rows count for Core Values too"). The "What the numbers mean" card already explains the numbers. The ⚙️ note still shows when you hover over a gear.
- **Why / who asked:** Thea: "take away the reminder of the numbers at the top of the page" (the one above "What the numbers mean" and under the title).

## 2026-10-12 — Rubric Check: "What the numbers mean" card at the top
- **File:** `app/public/index.html` (`#page-rubric`): new card above the rating cards showing the four levels as colored number boxes (same colors as the rating buttons) with a short meaning for each: 1 Beginning, 2 Developing, 3 Accomplished (our goal for every row), 4 Exceeds (judge has to write down why). The small grey hint at the bottom of the page now only explains "entries."
- **Why / who asked:** Thea asked "what does the 1 2 3 4 numbers mean," then: "yes put it at the top of the numbers."

## 2026-10-12 — Difficulty fraction squeezed together
- **File:** `app/public/index.html`: on the Robot Game mission list, a filled-in difficulty now reads "2/5" with the numbers close together (the tap-to-edit box shrinks to fit the number once it's filled in; new `.diff .fill` style). Still tappable to change.
- **Why / who asked:** Thea: "make the two numbers closer together to look like this. 2/5" Then: "put them in the middle of the difficulty section" → the Difficulty column (header and every row) is now centered (`.diff{text-align:center}`).

## 2026-10-12
- Data only: `app/db/updates/2026-10-12-ip-camera-parts.sql` (notebook entry: camera parts bought, wiring starts).

## 2026-10-09 (after See every entry) — "Diff" column renamed "Difficulty"
- **File:** `app/public/index.html` (`missionTable`): Robot Game mission list column header "Diff" → "Difficulty". Then (Thea): a filled-in difficulty shows as a fraction, e.g. "3/5", instead of ●●●○○ dots; the number stays tappable so it can be changed.
- **Why / who asked:** Thea asked what "Diff" meant, then: "yes change it to difficulty."

## 2026-10-09 (after Coding) — "See every entry" is a lavender chip
- **File:** `app/public/index.html`: on the Daily Log's Notebook Feed card, the small "see every entry" link is now its own button styled like the "36 entries this season" chip (lavender pill, `.chip`), under the teammate pictures. Then the 📖 book emoji was taken off it (Thea).
- **Why / who asked:** Thea: "make that look like the '36 entries this season' at the top."

## 2026-10-09 (after fill-ins) — Coding mission list: no "We say"
- **File:** `app/public/index.html`: the Coding page's "Mission Programs — Who Coded What" table no longer shows the "We say: …" nickname line. No page shows nicknames now; they still live in `06-missions-bioglow.md` (alias log) and the database.
- **Why / who asked:** Thea: "also in Coding get rid of the 'we say' thing."

## 2026-10-09 (after titles) — "Tap to fill in" on every blank we haven't filled out
- **Files:** `app/server.mjs`: page may now edit missions `diff`, `run`, `att`, `built`, `prog`; runs `l` (launcher); programs `sensors`; tradeoffs `pick`, `why`; setting `mascot.name`. `runs`, `programs`, `tradeoffs` got a row key (`run_number` / `id`) so single rows can be edited. `app/public/index.html`: new `blank()`, `fill()`, `saveFill()` helpers. A blank ("—", empty, 0, "Not decided yet") shows the lavender "Tap to fill in"; tap, type, Enter saves. Names are checked against the team (unknown name → "Who is …?" and nothing saved); Diff must be 1–5. Spots: Robot Game mission list (Diff, Run, Attachment, Built, Coded) and Run Plan (Launcher); Coding (Sensors, Coded by); Robot Design tradeoffs (We picked, Why); Core Values mascot Name (replaces "Tap to name it!").
- **Left as-is (worked out by the app, not typed):** Reliability (already a slider), Expected pts, Help given ↔ received, Best match score (fills in when a match is logged).
- **Checked:** routes saved with their current values only (no new data); bad name and Diff 9 were refused.
- **Why / who asked:** Thea: "for everything we need to fill out but haven't yet, can you make a tap to fill in thing."

## 2026-10-09 (final) — Page titles get a thin lavender outline
- **File:** `app/public/index.html` (CSS `h1`): all 8 page titles (Team Dashboard, Robot Game, Robot Design, Coding, Innovation Project, Core Values, Daily Log, Rubric Check) get a super-thin `--lavender` (#b48fd9) outline (`-webkit-text-stroke:1.5px` drawn behind the letters, so about 0.75px shows). The grey subtitle under each title has no outline.
- **Why / who asked:** Thea: "give the titles a super thin outline of the lavender purple we've been using."

## 2026-10-09 (last) — Proper capitalization: no lowercase starts
- **File:** `app/public/index.html`: every label, hint, button and placeholder that started with a small letter now starts with a capital ("Tap to fill in", "Tap to add a photo", "Tap to name it!", "Built by Thea · Sep 11", "Our mascot is…", "Every program…", "Every mission…", "Entries from the Daily Log…", "Written ✅", "Needs a program", "We say:", "· Size … · Built by", Project Plan dropdowns "Early/Mid/End of …", score placeholder "Like 205"). New display-only `cap()` helper capitalizes the first letter of saved text when shown: attachment version notes ("V1 built ✅", "Programmed (Fynn)"…), notebook entries, Core Values moments, test "what we saw", research notes. Database text is unchanged (students' words kept as typed). ALL-CAPS box titles left as they are (Thea chose "lowercase starts" only).
- **Why / who asked:** Thea: "in the whole app can you use proper capitalization."

## 2026-10-09 (even later) — Each feed shows its owner's picture
- **File:** `app/public/index.html` (`entryHtml(e, me)`): in a teammate's Notebook Feed, an entry shared by several people shows that teammate's picture instead of the first name listed (Sep 6 "Thea, Nolan, Weston" entry was showing Thea's photo in Nolan's and Weston's feeds). Other places (dashboard, Coding page, "every entry") still show the first name's picture.
- **Why / who asked:** Thea: "in Nolan and Weston's it also has a picture of me, change it to them."

## 2026-10-09 (later still) — Whole-team entries only in the Whole team feed
- **File:** `app/public/index.html` (`renderLog`): a teammate's feed and entry count now skip `isWhole` entries (the ones tagged with all six names were showing up in every person's feed). Counts went Thea 11→8, Fynn 8→5, Isla 7→4, Adeline 8→5, Nolan 8→5, Weston 7→4; Whole team stays 7. The dashboard "Who's been doing what" tally is unchanged.
- **Why / who asked:** Thea: "take out the whole team entries from everyone else's and just have it in whole team."

## 2026-10-09 (later) — Whole-team entries show the "W" picture
- **File:** `app/public/index.html` (`entryHtml`): entries counted as whole team (`isWhole`: tagged "Whole team" or all six names) now show the grey "W" avatar instead of the first name's photo (it was showing Thea's picture on all-six-names entries). Applies everywhere entries appear.
- **Why / who asked:** Thea: "in the whole team there is pictures of Thea in there so if that is a whole team entry then make the profile picture the W."

## 2026-10-09 — Daily Log: teammate picture buttons open each feed
- **File:** `app/public/index.html`: Notebook Feed card's single "Open the Notebook Feed" button replaced by `#log-people`: a "Whole team" button (logo) + one profile-picture button per teammate, with entry counts; `openFeed(f)` sets the filter. New `isWhole()` (tagged "Whole team" or all six names); "Whole team" added to the feed's filter bar. "📖 see every entry" link kept. New `.feed-people` styles.
- **Why / who asked:** Thea (see `DECISIONS.md` 2026-10-09).

## 2026-10-09 (end of session) — Experts card full width
- **File:** `app/public/index.html`: the Innovation Project page's Experts & Their Feedback card is now `wide` too, matching Research Collection.
- **Why / who asked:** Thea said yes when asked if it should match the Research Collection card.

## 2026-10-09 (later still) — Research Collection full width
- **File:** `app/public/index.html`: the Innovation Project page's Research Collection card is now `wide` (full row), and the Type tag and "Found by" header no longer wrap, so "AI research" stays on one line.
- **Why / who asked:** Thea: "make the AI research all together not separated, if you need to expand the whole white thing."

## 2026-10-09 (later) — Robot Game mission list: just number + name too
- **File:** `app/public/index.html` (`missionTable`): the Robot Game page's Mission Inventory no longer shows the "we say: …" nickname line or the 🚫 no-equipment icon, and the "🚫 = no-equipment rule" key under the table is gone. Nicknames still live in `06-missions-bioglow.md` and on the Coding page's table.
- **Why / who asked:** Thea: "do the same thing for robot game."

## 2026-10-09 — Dashboard mission list: just number + name
- **File:** `app/public/index.html` (`missionTable`): on the Team Dashboard's Mission Inventory, the "we say: …" nickname line and the 🚫 no-equipment icon are hidden, so each row shows only the mission number and official name. Both still show on the Robot Game page's full mission table.
- **Why / who asked:** Thea: "get rid of the 'we say' thing and only have the name and number of the mission."

## 2026-10-05 (later) — All sample data removed; fill-in boxes
- **Data:** `app/db/updates/2026-10-05-remove-samples.sql`: deleted 7 sample moments, 6 sample gantt rows, settings `cv_tally_base` / `ip_summary` / `ip_progress`; `gantt` gets `source` + `created_at`. Also `2026-10-05-ip-strikes-i17.sql` (300 strikes = on I-17).
- **Files:** `app/server.mjs`: the page may add `gantt` rows and fill in settings `ip_summary` (problem/solution/how) and `ip_progress` (now) via `PATCH /api/settings/<key>`; edited settings get note "typed in the app <time>". `app/public/index.html`: SAMPLE chip removed; Problem/Solution/How = text box + Save (✏️ Edit once filled, text escaped); 8 steps clickable; Project Plan add form + empty hint; tally counts only real moments/entries (0s shown, no NaN).
- **Why / who asked:** Adeline and Thea: "get rid of all the sample stuff that we did not do… if there's nothing there, make it a text box so we can fill it out."

## 2026-10-05 (later) — Bridge cost fix
- Data only: `app/db/updates/2026-10-05-ip-bridge-cost-fix.sql` (I-17 wildlife bridge: $24 million, not billion, on Nate's card). Told by Adeline and Thea.

## 2026-10-05 (later) — Expert note fix
- Data only: `app/db/updates/2026-10-05-ip-expert-edit-fix.sql` ("AI to end the video" → "edit the video" on Nate's card). Told by Adeline and Thea.

## 2026-10-05 (later) — Our questions on the expert card
- **Data:** `app/db/updates/2026-10-05-ip-expert-questions.sql`: new `experts.questions` column (JSON list of question + answer); Nate's 5 questions; notebook entry (blinking warning-light idea).
- **Files:** `app/server.mjs` (`qs` field, parsed as JSON) · `app/public/index.html` (fold-out "Our questions" list on each expert card).
- **Why / who asked:** Adeline and Thea sent the questions the team asked Nate; pairing each question with its answer shows judges we prepared for the interview.

## 2026-10-05 — Innovation Project: first real expert (Nate Ragan)
- **Data:** `app/db/updates/2026-10-05-ip-expert-nate.sql`: Nate Ragan (Arizona Game and Fish) on the Experts card, research row, notebook entry. The sample (GlowCast) experts and research rows deleted, now that real ones exist. New `experts` columns: `date`, `met_by`, `notes` (JSON list).
- **Files:** `app/server.mjs` (experts map: `d`, `by`, `notes`; `notes` parsed as JSON) · `app/public/index.html` (Experts card shows "met <date> · who", a fold-out "What we learned" list, and a hint when there are no experts).
- **Why / who asked:** Adeline and Thea's expert-meeting notes had 16 facts; the card only had room for one feedback line. The rubric asks for experts with dates and what they said.

---

## 2026-10-02 — Adeline, Nolan, Weston update
- Data only: `app/db/updates/2026-10-02-adeline-nolan-weston.sql` (Adeline added as coder on M12 + M15; Nolan coder on M02 + M03 with a new program row; M02 + M03 test 5/5; M02, M03 → Working 100%; three notebook entries). Told by Thea.

## 2026-10-02 — M14 first test
- Data only: `app/db/updates/2026-10-02-m14-test.sql` (M14 test session 5/5 by Fynn, M14 status Working + reliability 100%, notebook entry). Told by Thea.

## 2026-10-03 — Innovation Project: two cameras
- Data only: `app/db/updates/2026-10-03-ip-two-cameras.sql` (notebook entry: house + forest cameras, mode switch). Told by Thea.

## 2026-10-03 — Innovation Project: XIAO + Pi over Wi-Fi
- Data only: `app/db/updates/2026-10-03-ip-xiao-wifi.sql` (notebook entry: chose the XIAO camera, Pi 4 collects pictures over Wi-Fi). Told by Thea.

## 2026-10-03 — Innovation Project research: XIAO camera
- Data only: `app/db/updates/2026-10-03-ip-xiao-research.sql` (first real research row + notebook entry). Told by Thea.

## 2026-10-03 — Innovation Project Option B
- Data only: `app/db/updates/2026-10-03-ip-option-b.sql` (notebook entry: picked the Raspberry Pi build, parts on hand). Told by Thea.

## 2026-10-02 — Innovation Project idea
- Data only: `app/db/updates/2026-10-02-ip-forest-camera.sql` (one Innovation Project notebook entry: the forest wildlife camera idea). Told by Thea.

## 2026-09-28 — Isla's color → red
- Data only: `app/db/updates/2026-09-28-isla-red-fav.sql` (Isla's favorite color Pink → Red, so her profile-card ring is red too). Asked by Thea after seeing the ring still pink.
- Data only: `app/db/updates/2026-09-28-isla-red.sql` (Isla's avatar color #ec4899 → #e3000b; favorite color stays Pink). Asked by Thea.

## 2026-09-28 — Isla's color → pink
- Data only: `app/db/updates/2026-09-28-isla-pink.sql` (Isla's avatar color #8b5a2b → #ec4899, favorite color Brown → Pink). Asked by Thea.

## 2026-09-28 — profile pictures
- **Files:** `app/db/updates/2026-09-28-profile-photos.sql` (new `team.photo` column + each student's file name), `app/server.mjs` (serves `app/images/` at `/images/…`; sends `photo` with the team data), `app/public/index.html` (round avatars and Team Profile cards show the photo; bigger 88px picture on the cards; emoji / first letter still used if there's no photo).
- **What:** every student's real photo now appears as their profile picture everywhere in the app.
- **Why / who asked:** Thea: "we created a folder called images … please update the app to add the photos as our profile pictures."
- **Not done yet:** the attachment photos in the same folder (`8-31-mission-1.jpg`, `9-4-…`, `9-25-…`) are not shown in the app yet. Note: `9-25-mission-13.jpg` and `9-25-mission-14.jpg` are the exact same picture — one is probably the wrong file.

## 2026-09-28 — v5: the app runs on a database
- **Files:** new `app/` folder: `server.mjs` (dev server + API), `public/index.html` (the page, from v4), `public/logo.png`, `db/schema.sql`, `db/seed.sql`, `db/db.mjs` (apply / snapshot / sql / reset), `db/updates/`, `README.md`, `package.json`. New `.claude/launch.json` (server `rooted-warriors`, port 8787). `mockups/14-…-v4.html` unchanged and frozen.
- **What:** all v4 data (and the facts typed into its HTML: robot specs, programs table, mascot card, Innovation Project text, tournament date) moved into the database. The page loads it from `/api/data`. Forms now save: notebook entry, Core Values moment, match (plus the high-score quote), test session (plus its notebook entry), mission status/reliability, rubric rating, profile-card fields. Sidebar says "v5"; footer says "saved in the team database." Verified: all 8 pages' text identical to v4, and each form tested on a throwaway copy of the database, then reloaded to confirm it saved.
- **Small fixes made along the way:** dates use the computer's local day (v4 used UTC, which stamps evening practices with tomorrow's date). The Success Calendar now adds months automatically (v4 stopped at September). A test session's notebook entry credits the builder(s) correctly when an attachment has two builders.
- **Why / who asked:** CJ: "make this more of an actual app … stored into a database. All future updates should update the data and start the dev server."

## 2026-09-25 — v4: Sep 25 practice data
- **File:** mockups/14-rooted-warriors-app-v4.html (in place)
- **What:** Mission inventory `prog`: M12 + Thea, M14 → Fynn, M15 → Isla (Coding chip now "5 of 9 started missions have a program"; the "needs a program" to-do list shrinks to M02, M03, M08, M13). Programs We've Written table: Thea added on the M12 row; new rows for M14 (Fynn) and M15 (Isla). Attachment cards: Sep 25 version lines on Mission 12 (programmed, Thea), Mission 15 (built + programmed, Isla), Mission 14 (programmed, Fynn). Three Sep 25 notebook entries; Sep 25 Teamwork moment; new proudest-moment quote at the front.
- **Why / who asked:** a student's practice update (first name not given).

## 2026-09-19 (later) — v4: outline on the logo (black, then dark green)
- **File:** mockups/14-rooted-warriors-app-v4.html (in place) · new asset mockups/rooted-warriors-logo-outlined.png
- **What:** ~4 px outline, first black, then recolored to dark green #0e2617 at the student's next request ("make the outline of the logo a dark green"). Outline is around the shield edge, baked into the sidebar logo PNG (alpha mask grown, filled black, original composited on top; 8 px padding added so the outline isn't clipped). Artwork inside the shield unchanged.
- **Why / who asked:** a student: "outline the logo with black so it doesn't blend in with the green background."

## 2026-09-19 (later) — v4: logo background removed
- **File:** mockups/14-rooted-warriors-app-v4.html (in place) · new asset mockups/rooted-warriors-logo-transparent.png
- **What:** The sidebar logo PNG's black-to-white glow background was cut to transparent (flood fill from the edges over grayscale pixels; stops at the shield's dark green border; edge pixels softened). Shield artwork unchanged. Existing CSS drop shadow now hugs the shield.
- **Why / who asked:** a student: "make the black and white background go away but keep the logo the same other than that."

## 2026-09-19 (later) — v4: new Coding page
- **File:** mockups/14-rooted-warriors-app-v4.html (new file, copied from v3; v3 kept)
- **What:** New sidebar page **💻 Coding** (after Robot Design). Moved from Robot Design: the Coding card → "Programs We've Written" (full width) with the base-template note folded into its footer; the "Base program template" spec line replaced by a "Programs → see Coding page" link. Robot Design subtitle now "The main robot · attachments · testing · tradeoffs." New cards on Coding: **Mission Programs — Who Coded What** (generated from the mission inventory: attachment, built by, coded by, written ✅ / needs a program) and **Coding Notebook Entries** (Daily Log entries mentioning programming). Header chip: "3 of 9 started missions have a program." New `renderCoding()` in `renderAll()`. Title/sidebar say v4.
- **Why / who asked:** a student: "take everything about coding and make a new section called coding." New page = new numbered file per the folder convention.

## 2026-09-19 (later) — v3 Robot Design: specs card renamed "The Main Robot"
- **File:** mockups/13-rooted-warriors-app-v3.html
- **What:** Robot Design page — card title "The Actual Robot Thing" → **"The Main Robot"**; page subtitle "The actual robot · …" → "The main robot · …". Labels only, no data change.
- **Why / who asked:** a student: "change the name of the robot from the actual robot thing to the main robot."

## 2026-09-19 (later) — v3 Daily Log: notebook feed behind an "Open" button
- **File:** mockups/13-rooted-warriors-app-v3.html
- **What:** Daily Log page — the Notebook Feed card no longer lists every entry on page load. In its place: a centered card with a teaser line ("22 entries this season · latest: Sep 19 — Thea") and a large **📖 Open the Notebook Feed** button. Tapping it hides the New Entry form + calendar and shows the full feed (filters + entries) with a **← Back to Daily Log** button. Navigating to the Daily Log from the sidebar resets to the calm view. New helpers `openFeed()` / `closeFeed()`; `renderLog()` fills the teaser.
- **Why / who asked:** a student: "make it a button to tap on and it takes you to the notebook feed. i dont want it to be to over welming at first sight." See `../DECISIONS.md` 2026-09-19.

## 2026-09-19 (later) — v3 profile cards: three fields blanked for teammates to fill in
- **File:** mockups/13-rooted-warriors-app-v3.html
- **What:** Core Values page, team spotlight cards for Fynn, Isla, Adeline, Nolan, Weston — **Learned**, **Worked with most**, and **Notebook entries** cleared of sample text so they show "tap to fill in." Notebook entries is now a typed field on every card (it had auto-counted for five of them). All other fields untouched. Thea's card unchanged (already blank there). **Follow-up:** Role line cleared for Fynn, Isla, Nolan, Weston, then Thea too (sample text from v2); Adeline's "Programmer" kept.
- **Why / who asked:** a student: "for all the teammates other than Thea have us fill out what we learned, who we worked with most, and notebook entries but not the other ones." See `../DECISIONS.md` 2026-09-19.

## 2026-09-19 — v3 updated in place: Sep 19 practice (3 new missions, 2 programs)
- **File:** mockups/13-rooted-warriors-app-v3.html
- **What:** Robot Game — inventory: M13 Keystone Species status Prototyping → Working (attachment finished), attachment renamed "Keystone Species (mascot) attachment"; M02 status → Working with alias "number 2" and a note that Nolan built it Sep 19; M04 Coded = Adeline, alias "mission 4"; M08 Tangled started (alias "number 8," Nolan, Prototyping, run 8); M12 Coded = Isla · Fynn, alias "the forest elder"; M14 Seeds of Renewal started (alias "number 14," Weston, run 6); M15 Biocentric Architecture started (alias "mission 15," Isla, run 7). DRAFT run plan: runs 6–8 added (total ≈ 245 s — intentionally over, so the team sees they must combine missions). Robot Design — Coding table: M12 row now Isla · Fynn with a "same program or second version?" question; new M04 Lucky Leaves row (Adeline). Attachment cards: Keystone Species card gets a Sep 19 "finished ✅" version; Combined 2+3 card gets a Sep 19 "Nolan built number 2 — is it this one?" version; Mission 12 card gets "programmed (Fynn)"; three new cards — Mission 15 (Isla), Mission 14 (Weston), Mission 8 (Nolan, in progress). Daily Log — six Sep 19 entries, one per student. Core Values — Sep 19 Inclusion moment (all six). Dashboard — proudest-moment quote now the Sep 19 build day.
- **Why / who asked:** A student's Saturday Sep 19 practice update (see `PRACTICE-LOG.md`). Data only, no new UI.

## 2026-09-11 — v3 updated in place: mascot mission, first programs
- **File:** mockups/13-rooted-warriors-app-v3.html
- **What:** Robot Game — M13 Keystone Species now shows the alias "the mascot mission," attachment "Mascot attachment," built by Thea, status Prototyping, run 5; run 5 added to the DRAFT run plan (total now 155 s, over budget — intentional, so the team sees it). M01 Coded = Adeline; M12 Built = Fynn + Isla, Coded = Isla. Robot Design — Coding table gained rows for the Drone Survey program (Adeline) and the Forest Elder program (Isla); Mission 12 attachment card shows two builders and a Sep 11 "finished ✅ + programmed" version; new Mascot attachment card (M13). Attachment cards now accept more than one builder. Daily Log — three Sep 11 entries (Thea, Adeline, Isla). Core Values — new **Team Mascot** card (built by Thea, name and photo left blank for the students, note that it doubles as the M13 piece); Sep 11 Fun moment. Dashboard — proudest-moment quote now the Sep 11 mascot milestone.
- **Why / who asked:** A student's practice update (dated "august 11" in the message; logged as Sep 11 pending confirmation — see `PRACTICE-LOG.md`). The app had no home for a mascot, so a small card was added (allowed under CLAUDE.md practice-update step 6).

## 2026-09-06 (later) — v3 updated in place: base finished + base decisions
- **File:** mockups/13-rooted-warriors-app-v3.html
- **What:** Robot Design page — robot-base status set to done (3 copies); Sep 6 notebook entry credited to Thea, Nolan, Weston; new tradeoff row "One robot base, or three identical copies?" with *why* left blank. Then: wide-base tradeoff row got its real *why*; two new tradeoff rows (reinforce vs light, color sensors vs none); Shape, Sensors, and Accuracy-vs-Speed specs filled in; a Sep 6 DESIGN notebook entry credited to the whole team.
- **Why / who asked:** Students (dictated by CJ) reported the base finished and the base design decisions. Details in `../DECISIONS.md` 2026-09-06.

## 2026-09-06 — v3: real BIOGLOW missions, real build progress
- **File:** mockups/13-rooted-warriors-app-v3.html (new file; v2 kept for comparison)
- **What:** Robot Game mission inventory replaced with the real 15 missions (numbers, names, max pts, how each scores, "we say" alias line, 🚫 no-equipment flag), plus Equipment Inspection and Precision Tokens. Attachments, notebook feed, tradeoff table, robot specs, coding table, and run plan now show actual progress Aug 26 – Sep 4. Sample practice scores and sample test sessions removed → "log your first one" prompts. Run plan marked DRAFT (30 s guesses). Innovation Project page still sample data, labelled.
- **Why / who asked:** CJ loaded the official mission list from the rulebook and asked that it be used everywhere.

## 2026-09-04 — Profile cards tap-to-edit; Thea's real data
- **File:** mockups/12-rooted-warriors-app-v2.html (in place)
- **What:** Every fact on a team profile card is tap-to-edit; blank fields show "tap to fill in." Profile-picture ring colored from the typed favorite color (words like "lavender purple" / "dark green" auto-converted; "light/pale/pastel" lightens). Thea entered facts for all six teammates (see `CORE-VALUES.md`).
- **Why / who asked:** Thea, at practice — first real team data in the app.

## 2026-09-04 — v2: real logo + real roster
- **File:** mockups/12-rooted-warriors-app-v2.html (new file)
- **What:** Same as v1 with the real Rooted Warriors logo embedded in the sidebar and the real team roster (Thea, Adeline, Fynn, Isla, Nolan, Weston) replacing placeholder names. Everything else still sample data.
- **Why / who asked:** Students / CJ, same day as v1.

## 2026-09-04 — v1: first clickable app (Sidebar HQ)
- **File:** mockups/11-rooted-warriors-app-v1.html (new file)
- **What:** First clickable version, one self-contained file, sample data, no saving. Seven pages: Dashboard (best score + chart, mission inventory, 20-row rubric heat map, six-value tally, proudest-moment quote, contribution bar, latest entries); Robot Game (editable inventory with status + reliability slider, run plan vs 150 s with swap time, points-per-second leaderboard, log-a-match form with confetti on new high score, score history with failed → changed trail); Robot Design (specs, coding table, attachments with version timeline and photo slots, test sessions + add-test form, tradeoff table); Innovation Project (Problem/Solution/How-we-got-here, 8-step progress, Gantt colored by owner with click → iterations, research collection, experts with feedback → improvement); Core Values (profile cards, six-value tally, add-a-moment, help given ↔ received, recent moments); Daily Log (entry form: date, component, rubric phase, who, text, core values spotted, photo slot; Aug + Sep success calendar; filterable feed); Rubric Check (20 rows, 1–4 buttons, ⚙️ marks, evidence count). Borrowed the "run plan vs 150 s" bar from mockup 10.
- **Why / who asked:** Students voted Sidebar HQ (mockup 06) as the layout out of 06–10; v1 turns it into a working shell. Covers the App Notes wish-list items listed in `../DECISIONS.md` 2026-09-04.

## 2026-08-31 — Round 2 mockups: logo palette, five layouts
- **Files:** mockups/06-rooted-sidebar-hq.html, 07-rooted-badge-hero.html, 08-rooted-bento-board.html, 09-rooted-journal-feed.html, 10-rooted-canopy-roots.html (new files)
- **What:** Same dashboard sample data in the official logo palette (forest `#1c3b2a`, pine `#2a5c3f`, grass `#3f9b4c`, lavender `#b48fd9`, lilac `#d9c6ee`, circuit teal `#20b5c9`, cream `#f4efe1`), five different layouts for a layout vote. Result: 06 chosen Sep 4; 10's run-plan bar borrowed; 07–09 not voted on.
- **Why / who asked:** Team logo finalized Aug 31; students to vote on layout.

## Before 2026-08-31 [unclear: exact date] — Round 1 mockups: five color themes
- **Files:** mockups/01-dashboard-neon-glow.html, 02-dashboard-space-mission.html, 03-dashboard-clean-sport.html, 04-dashboard-retro-arcade.html, 05-dashboard-brick-builder.html (new files)
- **What:** Same dashboard home page and sample data in five looks (Neon Glow, Space Mission, Clean Sport, Retro Arcade, Brick Builder) for a style vote.
- **Why / who asked:** Step 2 prototype playground, before the logo existed. Never voted on; superseded by the logo palette on Aug 31.
