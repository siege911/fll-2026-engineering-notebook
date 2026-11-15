# Practice Log

One entry per practice, **newest at top**. This is the raw material for the team's Engineering Notebook and for the app's Daily Log page. Keep the students' words; add structure underneath.

**How to add an entry:** copy the template at the bottom, fill in what you know, mark anything unclear with `[unclear: ...]`. Real dates only (never "today"). Every fact here should also appear in the right component file (`ROBOT-DESIGN.md`, `ROBOT-GAME.md`, `INNOVATION-PROJECT.md`, `CORE-VALUES.md`) and in the app.

**Backfill note:** entries dated 2026-09-06 and earlier were copied on 2026-09-06 from `../DECISIONS.md` and `../PROGRESS.md`. Those sources did not keep the students' raw words, so the "Raw update" sections below are summaries, not quotes. Who was present at each practice was not recorded; only who did what.

---

## 2026-11-15 (Sunday) — Robot code: Final v1 and Final v2 added to the code folder (not a practice)
**Told by:** Coach CJ (sent 2026-11-15)

**Raw update (their words):**
> I updated our "code" folder with the latest Code iterations. Final v1 is just the capture of everything on November 3. Adeline did the main work on Nov 3 to move to the Final v2 which includes the code for selecting the missions during the competition. We tested it on Nov 9. Fynn did the updates on Nov 9 and Nov 13 to the code for Final v3 to fine-tune all of the missions.

**Follow-up, same day (Coach CJ):**
> Does this file have different data? This is the absolute latest backup from the active code so should be v3. If these are the same then just use this as v2 and remove the v3. Fynn did do some fine tuning work be we may not have created the backups at the right time.

**What happened**
- Robot Design (CODE): new folders in `code/`: **Final v1** (everything as of Nov 3) and **Final v2** (Adeline's mission menu, tested Nov 9, with Fynn's fine-tuning from Nov 9 + Nov 13 in it; includes the Nov 15 hub backup). A `Final v3` folder was removed: it was the same code, and so was the Nov 15 backup. Also the `11-2` backup (Nov 2). Full write-up: `ROBOT-CODE.md` 2026-11-15.
- Adeline's menu (`main_base.py` + `robot.py`): pick any of the 9 runs with the hub buttons, CENTER stops a run, the next run is ready right after one finishes. The 9 menu slots match our run plan.

**Problems / open questions**
- Answered same day: no separate backup of Adeline's menu before Fynn's fine-tuning exists, so Final v2 holds both.
- [unclear: run 5 in the run plan is M10 + M14, but no program has M10 in its name.]
- [unclear: `main_base.py` says "Quantum Warriors" at the top.]

**App changes made:** Coding page reads the `Final …` folders and shows "grew from" for joined-up programs; `2026-11-15d-final-code.sql` + `2026-11-15e-no-final-v3.sql` (Fynn added to "Coded by", Adeline's menu in "Programs We've Written", who made each Final version, notebook entries for Nov 3, Nov 9, Nov 13).
**Rubric rows touched:** Robot Design CODE (clear, modular code: one shared `robot.py`, one `run()` per mission), ITERATE (v1 → v2 → v3), Robot Game strategy (menu matches the run plan).

---

## 2026-11-15 (Sunday) — Notes from Coach CJ: Thea's brother, ADOT, bridge cost (not a practice)
**Told by:** Coach CJ (sent 2026-11-15, together with the Nov 9, Nov 13 and Nov 14 practices below)

**Raw update (their words):**
> We mentioned Thea's brother. He developed a custom circuit board and is willing to help the team. Isla and Fynn got the Solar Panels working yesterday. We did a practice yesterday which focused on Innovation Project and building our display trifold board materials for the competition.
>
> We also had a practice two days ago (Friday) and the previous Monday where Fynn finished fine-tuning all of the attachments. So every attachment should be in it's final form. I know she specifically worked on the following Missions:
> Monday - 6, 7, 14 and a little bit of 2 & 3 - The rest were just tested and tested as working well.
> Friday - Finished 2 & 3 and worked on 8 & 9
> Note: This is from memory so if you have more specific data, use your data.
> We still haven't done a full timed run through of the whole board yet.
>
> The ADOT contact occurred a while ago. I don't have a date but we have the paperwork needed.
>
> Regarding facts: The bridge current cost is at $21 million. It may go up to $24 million, but current projections from ADOT show $21 million so let's use that.

**What happened**
- Innovation Project (ITERATE, sharing): **Thea's older brother** has developed his own custom circuit board and is willing to help the team build ours (next version of the camera). Same as Nolan's paragraph in the judging talk. [unclear: when we shared it with him, and his name if he's OK being named]
- Innovation Project (sharing / plan): **Coach CJ talked to the ADOT District Administrator for the Northcentral District** about putting our camera on the Willard Springs wildlife bridge, and **we have the paperwork needed**. [unclear: date of the talk]
- Innovation Project (problem facts): **the bridge costs $21 million**, ADOT's current projection. It may go up to $24 million later (that's the number Nate Ragan gave on Oct 5). We use $21 million.
- Spelling: our Game and Fish expert is **Nate Ragan** (the notebook had it wrong until today; fixed everywhere).

**App changes made:** `app/db/updates/2026-11-15b-practices-nov9-14.sql` (shares: Thea's brother + ADOT; notebook entries; Gantt: ADOT paperwork; Ragan spelling).
**Rubric rows touched:** Innovation Project ITERATE (sharing with multiple people/groups); IDENTIFY (problem definition).

---

## 2026-11-14 (Saturday) — Innovation Project + trifold boards; solar panels work (Isla + Fynn)
**Who was there:** Isla, Fynn (named) [unclear: who else came?]
**Told by:** Coach CJ (sent 2026-11-15; raw words in the 2026-11-15 entry above)

**What happened**
- Innovation Project (CREATE): **Isla and Fynn got the solar panels working.** [unclear: what "working" was tested: charging the battery, powering the camera?]
- Innovation Project / competition (COMMUNICATE): practice focused on the **Innovation Project and building the display trifold board materials** for the competition. [unclear: who worked on the trifold, and what's on it now? A photo would be great evidence.]
- Tournament: **the Regional Tournament is Saturday, Nov 21** (Coach CJ, Nov 15). The app's countdown said Nov 14 by mistake; fixed (`2026-11-15c-tournament-nov21.sql`).

**Wins / celebrate:** The solar box works! Now the camera can run in the forest without a plug.
**Next practice:** Practice both judging talks out loud with the timer and adjust.
**App changes made:** `2026-11-15b-practices-nov9-14.sql` (notebook entries; Gantt task "Solar panels" for Isla + Fynn).
**Rubric rows touched:** Innovation Project DESIGN (team involvement: Isla + Fynn), CREATE (model), COMMUNICATE (trifold).

---

## 2026-11-13 (Friday) — Fynn finished Missions 2 + 3, worked on 8 + 9
**Who was there:** Fynn [unclear: who else?]
**Told by:** Coach CJ (sent 2026-11-15, from memory)

**What happened**
- Robot Design (ITERATE): **Fynn finished fine-tuning the combined 2 + 3 attachment** (M02 Exploding Seeds + M03 Flip the Rock) and **worked on the 8 + 9 attachment** (M08 Tangled + M09 Research Platform).
- After Nov 9 and today, **every attachment should be in its final form.**
- Robot Design (CODE, added 2026-11-15 from Coach CJ): **Fynn finished fine-tuning the code for all the missions** (saved in `code/Final v2 - Nov 9/`; no separate backup). E.g. a new path for M02 + M03, smaller arm moves for M15.
- Not done yet: **a full timed run-through of the whole board.**

**Next practice:** Full timed run of all nine runs, counting tries and successes for each mission.
**App changes made:** `2026-11-15b-practices-nov9-14.sql` (attachment versions for 2 + 3, 8, 9; notebook entry).
**Rubric rows touched:** Robot Design ITERATE (improvements based on testing).

---

## 2026-11-09 (Monday) — Fynn fine-tuned the attachments; every other mission tested working
**Who was there:** Fynn [unclear: who else?]
**Told by:** Coach CJ (sent 2026-11-15, from memory)

**What happened**
- Robot Design (ITERATE): **Fynn fine-tuned the attachments for M06 Leafcutter Frenzy, M07 Humongous Fungus and M14 Seeds of Renewal**, and a little of the 2 + 3 attachment.
- Robot Game (testing): **the rest of the missions were tested and worked well.** [unclear: how many tries per mission; no counts were written down]
- In the app, every mission that still said Prototyping now says **Working** (M01, M06, M07, M09, M10, M11, M12, M15). Reliability % stays as it was until we have tries and successes.
- Same day: the Pi tagged its first photos (camera → Pi → AI worked end to end, `CAMERA-BUILD.md` 2026-11-09).
- Robot Design (CODE, added 2026-11-15 from Coach CJ): **we tested Adeline's mission menu (Final v2)**, and Fynn started updating the code to fine-tune the missions (saved in Final v2). See `ROBOT-CODE.md` 2026-11-15.

**App changes made:** `2026-11-15b-practices-nov9-14.sql` (attachment versions for M06, M07, M14, 2 + 3; mission statuses; notebook entry).
**Rubric rows touched:** Robot Design ITERATE (repeated testing, improvements); Robot Game mission inventory.

---

## 2026-11-14 (Saturday) — Nolan's wildlife-crossing research added (not a practice)
**Told by:** [who?]

**Raw update (their words):**
> Nolan did a bunch of Research for the team. Please add this Research to our App including some key points from each of these websites:
> (9 links: All That's Interesting, ResearchGate, Los Angeles Times, KJZZ, WWF, Sigma Earth, Gokce Capital, Leave No Trace, Think Wildlife Foundation)

**What happened**
- Innovation Project (RESEARCH): **Nolan found 9 sources on whether wildlife crossings work.** Key points from each are in `INNOVATION-PROJECT.md` 2026-11-14. Big idea: crossings cut crashes 70–96%, but only if animals actually use them, and someone has to check (camera traps did it in Nepal). That supports our camera on the I-17 Willard Springs bridge. [unclear: what day Nolan did the research]
- The KJZZ link was cut off ("...cross-highw"); the working link ends in "...cross-highway".
- The ResearchGate paper couldn't be opened (the site blocks robots). [unclear: key point from it, ask Nolan]

**Wins / celebrate:** 9 sources in one go, including a local one about our own bridge, and a brand-new LA Times article from Nov 10!
**Problems / open questions:** Key point from the ResearchGate paper still needed.
**App changes made:** `app/db/updates/2026-11-14b-nolan-crossing-research.sql` (9 research rows + notebook entry; new link column so each source in the Research Collection opens its website). `public/index.html`, `server.mjs`.
**Rubric rows touched:** Innovation Project IDENTIFY (research, problem definition); Core Values Discovery.

---

## 2026-11-08 (Sunday) — Every mission tested and timed (Fynn + Isla); trifold boards (Thea + Adeline)
**Who was there:** Fynn, Isla, Thea, Adeline (named in the update) [unclear: were Nolan and Weston there?]
**Told by:** [who?] (sent 2026-11-09)

**Raw update (their words):**
> Yesterday Fynn and Isla worked on testing all of the missions and timing them. Attached is their notes.
> Thea and Adeline worked on the trifold boards for the competition.

**Fynn and Isla's notes (handwritten page, copied as written; saved as `app/images/11-8-mission-timing-notes.webp`):**

| Note in the margin | What they wrote | Official missions |
|---|---|---|
| | mission 1 = 12 sec | M01 Drone Survey |
| needs help | mission 2,3 = | M02 Exploding Seeds + M03 Flip the Rock |
| | missions 4,5 = 17 sec | M04 Lucky Leaves + M05 Reaching Roots |
| needs work | mission 8,9 = | M08 Tangled + M09 Research Platform |
| needs work | mission 10,14 = | M10 Fragile Microhabitats + M14 Seeds of Renewal |
| | mission 12 = 7 sec | M12 Forest Elder |
| fix yellow arm | mission 15 = | M15 Biocentric Architecture |
| | mission 13,12 = 17 | M13 Keystone Species + M12 Forest Elder |
| | missions 6,7,11 = 17 sec (first number crossed out, 17 written above) | M06 Leafcutter Frenzy + M07 Humongous Fungus + M11 Window to the Past |

**What happened**
- Robot Game: **Fynn and Isla tested every mission and timed each run.** 5 runs got a time: **M01 12 s, M04+M05 17 s, M12 7 s, M13+M12 17 s, M06+M07+M11 17 s** = 70 s of driving for those five. 4 runs have no time yet because they still need work: M02+M03 ("needs help"), M08+M09 and M10+M14 ("needs work"), M15 ("fix yellow arm").
  - This is the **first real timing** of the season: until now every run in the app's run plan was a 30-second guess.
  - **M06, M07 and M11 run together** and got a time, so M06 + M07 have programs now (on Nov 1 they were the only two left to program). [unclear: who programmed M06 + M07?]
  - **M10 runs with M14.** First sign of M10 in testing (the Nov 1 question "where is M10?" is partly answered). [unclear: does M10 use the M14 attachment, and who built/programmed that part?]
  - **M12 is on the list twice on purpose** (answered 2026-11-09): "Mission 12 has two parts and we do one part by itself and the second as part of mission 13." So run 6 = M12 part 1, the **support tie around the post (10 pts)**, 7 s; run 8 = M13 + M12 part 2, **cane raised touching the tree (20 pts)**, 17 s (answered 2026-11-09).
  - [unclear: is the order on the page the order we'll run them in a match, or just the order they tested?]
  - No tries / successes were written down, so no reliability % changes.
- Robot Design: **M15's yellow arm needs fixing** (Fynn + Isla's note). [unclear: what's wrong with it?]
- Innovation Project / competition: **Thea and Adeline worked on the trifold boards for the competition** (the tournament is Nov 14). [unclear: which boards (Innovation Project, Robot Design, or both) and what's on them so far?]
- Core Values: two pairs worked together all practice (Fynn + Isla, Thea + Adeline): Teamwork.

**Wins / celebrate:** First real stopwatch times! Five runs timed, and three of them are super quick (7 to 17 seconds). Plus every mission got tested in one practice, and the trifold boards are underway with six days to go.
**Problems / open questions:**
- Four runs still need work before they can be timed (M02+M03, M08+M09, M10+M14, M15).
- M15's yellow arm needs a fix.
**Next practice:** Fix the M15 yellow arm; get M02+M03, M08+M09 and M10+M14 working and timed. Run each mission several times and count tries and successes (the judges' "tested over and over" evidence). Finish the trifold boards.
**App changes made:** `app/db/updates/2026-11-08-mission-times-trifold.sql` (Robot Game run plan rebuilt from the notes, with real times and the margin notes; M01 + M12 mission times; M10 → Prototyping; two notebook entries; Teamwork moment). Run plan now shows ⏱ timed vs. guessed and a Notes column (`public/index.html`, `server.mjs`).
**Rubric rows touched:** Robot Game strategy / run plan (150 s budget); Robot Design ITERATE (testing every mission, "needs work" list); Innovation Project + Robot Design COMMUNICATE (trifold boards); Core Values Teamwork.

---

## 2026-11-03 (Tuesday) — Code saved as Final v1; Adeline built the mission menu
**Who was there:** Adeline [unclear: practice or at home? who else?]
**Told by:** Coach CJ (sent 2026-11-15)

**What happened**
- Robot Design (CODE): every program saved as **Final v1** (`code/Final v1 - Nov 3/`). New since Nov 1: `mission12.py` (speed 600, back-up 150 → 160), `mission1.py` and `mission14.py` (new distances and turns).
- **Adeline did the main work on the mission menu** (Final v2): one program, `main_base.py`, that lets the driver pick each run with the hub buttons, plus `robot.py` so the ports and wheels are set up in one place. Tested Nov 9.

**App changes made:** `2026-11-15d-final-code.sql` (notebook entry).
**Rubric rows touched:** Robot Design CODE, ITERATE.

---

## 2026-11-02 (Monday) — Attachment photos sent (not a practice)
**Told by:** [who?]

**Raw update (their words):**
> these are the photos of the attachments with the missions. put these in the app

**What happened**
- Robot Design: six photos of attachments on the mat with their missions: M15, M12, M14, M08 + M09 (one attachment does both), M02 + M03 (combined attachment), M04. Which mission is in each photo was answered by the student. Details: `ROBOT-DESIGN.md` 2026-11-02.

**App changes made:** `app/db/updates/2026-11-02-attachment-photos.sql` (new: each attachment card shows its photo); photos in `app/images/11-2-mission-*.jpg`.
**Rubric rows touched:** Robot Design COMMUNICATE (showing the attachments), CREATE.

---

## 2026-11-01 (Sunday) — M04 + M05 finished (4/5), M08 + M09 almost done, first M11 program, camera soldering
**Who was there:** Adeline, Fynn, Nolan, Weston (named in the update) [unclear: were Thea and Isla there?]
**Told by:** Adeline

**Raw update (their words):**
> This is Adeline updating for today. Weston and Nolan worked on mission 6, 7, and 11. they only programed 11 today. Adeline and Fynn worked on mission 8 and 9. Mission 8 and 9 are mostly finished besides the seed. Adeline worked on mission 4 and 5 and finished it, and it is pretty consistent - 4/5. As of this point we have an attachment for all the missions, the only thing left to program is mission 6 and 7. Nolan and Weston did soldering for innovation.

**What happened**
- Robot Design / Robot Game:
  - **Weston and Nolan worked on M06 Leafcutter Frenzy, M07 Humongous Fungus and M11 Window to the Past.** They **programmed M11** (its first program). M06 and M07 have attachments (Nolan built them Oct 26) but **no programs yet**.
  - **Adeline and Fynn worked on M08 Tangled and M09 Research Platform.** Both are "mostly finished besides the seed": the **M09 seed** (knock the seed off the big tree, 10 pts) is the part still left. M08 → **Working**. M09 stays **Prototyping** until the seed works. [unclear: who programmed M08? The app has no M08 program yet, but the team says only M06 and M07 are left to program.]
  - **Adeline finished M04 Lucky Leaves and M05 Reaching Roots: 4 out of 5 runs worked (80%).** Both → **Working**.
  - **Team milestone:** "we have an attachment for all the missions." **Only M06 and M07 are left to program.** [unclear: the app has no attachment or program for M10 Fragile Microhabitats, and no M05 attachment. Done with another mission's attachment, or not tracked yet?]
- Innovation Project: **Nolan and Weston did soldering for the camera.** [unclear: which parts got soldered (motion sensor, clock, switch)? Did they test it after?]
- Core Values: two pairs working together all practice (Weston + Nolan, Adeline + Fynn): Teamwork.

**Wins / celebrate:** Every mission has an attachment! Only two programs to go. M04 + M05 hit 4/5, the first counted test since Oct 2. And the camera got real solder joints.
**Problems / open questions:**
- The M09 seed still doesn't work.
- M06 and M07 still need programs.
- Who programmed M08, and where are M10 and M05's attachments? (see unclear above)
- What went wrong in the 1 miss out of 5 on M04/M05?
**Next practice:** Program M06 and M07. Fix the M09 seed. Test M08, M09 and M11 and count tries and successes. Test the soldered camera (test order in `CAMERA-BUILD.md`).
**App changes made:** data only — `app/db/updates/2026-11-01-m04-m05-m11-solder.sql` (also adds the Oct 26 robot facts below to the mission table).
**Photos (added 2026-11-02):** two soldering photos, sent with "nov 1 we did sodering so put these pictures in innovation progect for the app" [who sent them?]. Saved as `app/images/11-1-soldering-1.jpg` and `11-1-soldering-2.jpg`; shown on the Innovation Project page (Project Photos) via `app/db/updates/2026-11-02-ip-solder-photos.sql`.
**Rubric rows touched:** Robot Design CREATE (M11 program, M04/M05 finished), ITERATE (4/5 test), Robot Game mission strategy (only M06/M07 left); Innovation Project CREATE (soldering the camera); "all team members" contribution rows.

---

## 2026-10-26 (Monday) — Typed into the app: M09 programmed, M04 + M05 programmed, attachments for M06, M07, M11
**Who was there:** Weston, Fynn, Thea, Isla, Nolan (named in the app entries) [unclear: was Adeline there?]
**Told by:** typed straight into the app's Daily Log (copied here 2026-11-01) [who typed? not recorded]

**Raw update (their words, one app entry each):**
> Weston programed Mission 9.
> Fynn helped Weston with mission 9.
> Thea worked on the app. She compared the rubric and made adjustments to the app.
> Isla programmed missions 4 and 5.
> Nolan built an attachment for 6,7, and 11.

**What happened**
- Robot Design / Robot Game:
  - **Weston programmed M09 Research Platform**, with **Fynn helping**.
  - **Isla programmed M04 Lucky Leaves and M05 Reaching Roots.**
  - **Nolan built attachments for M06 Leafcutter Frenzy, M07 Humongous Fungus and M11 Window to the Past.** First attachments for M06 and M07 (both go from "Not started" to "Prototyping"). [unclear: M11 already had Weston's Oct 12 attachment: is Nolan's a rebuild or a new one?]
- Core Values: **Fynn helped Weston** with M09 (Teamwork).
- App: **Thea compared the app to the rubric and made changes** (Oct 26: Communication section, Rubric Map counts, Gantt filled in; see `APP-CHANGES.md`).

**Wins / celebrate:** Two missions (M06, M07) got their first attachments, and two more programs got written.
**Problems / open questions:** No tries / successes counted.
**Next practice:** (done Nov 1) test M04/M05.
**App changes made:** entries already in the app (typed there). Mission table brought up to date Nov 1 in `app/db/updates/2026-11-01-m04-m05-m11-solder.sql`.
**Rubric rows touched:** Robot Design CREATE (M06/M07 attachments, M04/M05/M09 programs); Core Values Teamwork (Fynn helped Weston).

---

## 2026-10-23 (Friday) — Camera wired; M13 programmed; first M09 attachment + program
**Who was there:** Thea, Nolan, Isla, Weston (Adeline and Fynn were not there)
**Told by:** Thea

**Raw update (their words):**
> Today oct 23 Nolan did the wiring for the camera. Thea helped Nolan. Isla programed the mascot mission. Weston built and atachment and programed for the big tree mission.
> Adeline and Fynn were not there

**What happened**
- Innovation Project: **Nolan wired the camera, with Thea helping** (following the wiring plan in `CAMERA-BUILD.md`). [unclear: all of the camera box (motion sensor, clock, switch), or part of it? Breadboard or soldered? Did it turn on / take a picture yet?]
- Robot Design / Robot Game:
  - **Isla programmed M13 Keystone Species** ("the mascot mission"). First program recorded for M13.
  - **Weston built an attachment and programmed M09 Research Platform** ("the big tree mission", Thea confirmed it's M09). First attachment and first program for M09. M09 goes from "Not started" to "Prototyping."
- Core Values: **Thea helped Nolan** with the camera wiring (Teamwork, help given/received).

**Wins / celebrate:** A brand-new mission (M09) got both an attachment and a program in one practice, and the mascot mission finally has a program. The camera went from a wiring plan on paper to real wires!
**Problems / open questions:**
- How far did the wiring get, and did anything get tested?
- No test runs counted for M13 or M09 yet.
**Next practice:** Test the camera box (test order in `CAMERA-BUILD.md`). Run M13 and M09 a few times each and count tries and successes.
**App changes made:** data only — `app/db/updates/2026-10-23-camera-wiring-m13-m09.sql`.
**Rubric rows touched:** Innovation Project CREATE (building the camera); Robot Design CREATE (new M09 attachment, M13 + M09 programs); "all team members" contribution rows; Core Values Teamwork (Thea helped Nolan).

---

## 2026-10-12 (Monday) — Robot: M12 rebuilt, M13 rebuilt, first M11 attachment, M04 + M05 programs
**Who was there:** Adeline, Nolan, Weston, Thea, Fynn, Isla (all six named in the update)
**Told by:** [who?]

**Raw update (their words):**
> Oct, 12 Adeline programed and rebuilt mission 12. Nolan rebuilt an attachment for mission 13. Weston built an attachment for mission 11. Thea worked on the app. Fynn programed for mission 4 and 5. Isla helped Fynn.

**What happened**
- Robot Design / Robot Game:
  - **Adeline rebuilt the M12 Forest Elder attachment and programmed M12** (v2 of the attachment Fynn created Sep 4 and Isla finished Sep 11). [unclear: what changed in the rebuild, and why?]
  - **Nolan rebuilt the M13 Keystone Species attachment** (Thea's mascot attachment, finished Sep 19). [unclear: what changed, and why?]
  - **Weston built the first attachment for M11 Window to the Past.** M11 goes from "Not started" to "Prototyping."
  - **Fynn programmed M04 Lucky Leaves and M05 Reaching Roots**, with **Isla helping**. First program for M05 (no M05 attachment recorded yet). [unclear: did Isla help with both programs? does M05 need an attachment?]
- Core Values: **Isla helped Fynn** program (Teamwork, help given/received). All six teammates did something today (Inclusion).
- Innovation Project: the 8-step tracker was set to **step 3, Research**, in the app (typed in the app, 2026-10-12).
- App: **Thea worked on the app** (today: Lavender Frames on every card, Run Plan fixes, practice-match log moved; see `APP-CHANGES.md`).

**Wins / celebrate:** Everybody had a job again! A brand-new mission (M11) got its first attachment, and two attachments got rebuilt, which is exactly the "make it better" loop the judges look for.
**Problems / open questions:**
- Why were M12 and M13 rebuilt? What wasn't working, and did the rebuild fix it? (Judges love "we saw X, changed Y, now Z.")
- No test runs counted today. M12, M13, M11, M04 and M05 all need tries / successes.
**Next practice:** Test the rebuilt M12 and M13 attachments and the new M04/M05 programs; count tries and successes.
**App changes made:** data only — `app/db/updates/2026-10-12-robot-m11-m12-m13-m04-m05.sql`.
**Rubric rows touched:** Robot Design ITERATE (two rebuilds), CREATE (new M11 attachment, M04/M05 programs); "all team members" contribution rows; Core Values Teamwork (Isla helped Fynn).

---

## 2026-10-12 (Monday) — Innovation Project: camera parts bought, wiring plan
**Who was there:** [who?]
**Told by:** [who?]

**Raw update (their words):**
> We bought the following items to make the camera: SOLAR POWER: ZPSHYD 6V 3W Solar Panel, Mini Monocrystalline DC5521 for Battery Lamp. Waveshare Solar Power Manager Module (D), Solar Charge Controller USB, Supports 6V~24V Solar Panel and Type-C Power Adapter, 5V/3A Regulated Output, with Battery Holder (Batteries are Not Included). 2-Pack Battery - 2600mAh 3.7V Button Top Rechargeable 18650 Replacement Battery for Flashlight, Headlamp, and More. CAMERA: WWZMDiB 5Pcs AM312 Mini Pir Motion Sensor Module HC-SR312 IR Human Sensor for Arduino. 2PCS DS3231 AT24C32 IIC RTC Module Clock Timer Memory Module Beats Replace DS1307 I2C RTC Board with Male to Female Jumper Wire Cable. Seeed Studio XIAO ESP32-S3 Sense Board with Camera & Microphone.
> We want the Solar Panel box and the Camera box to be two different options. We want to power the camera with USB C so we could plug it into a typical phone charger if we have power near the camera or the USB C output on the solar panel if we don't have power.
> We're going to start by wiring the whole thing together. Please help us with the wiring plan starting with the Camera since the batteries are delayed in getting here.

**What happened**
- Innovation Project: **parts bought** for the camera box and the solar box (batteries delayed). Changes from the Oct 3 list: Waveshare Solar Power Manager (D) instead of DFRobot Sunflower; 6 V 3 W panel; 2600 mAh button-top 18650s.
- **Camera box wiring plan (v1)**, full table in `CAMERA-BUILD.md`: power through the XIAO's own USB-C port (no wiring); motion sensor OUT → D0, mode switch → D1, optional status light → D2, clock SQW → D3, SDA → D4, SCL → D5; sensors powered from 3V3 + GND; D8–D10 left alone (microSD card).
- Robot Design / Robot Game / Core Values: nothing recorded.

**Wins / celebrate:** Parts are here and the build starts! Building the camera box first while the batteries ship is smart planning: no waiting around.
**Problems / open questions:**
- Batteries delayed.
- Not bought yet: microSD card, mode switch (SPDT toggle), CR2032 coin cell (if not included), waterproof box + USB-C jack/extension, breadboard + jumper wires.
- To test when batteries arrive: does the solar box switch itself off while the camera sleeps?
**Next practice:** Breadboard the camera box and run the test order in `CAMERA-BUILD.md` (picture → clock → motion → switch → sleep/wake).
**App changes made:** data only — `app/db/updates/2026-10-12-ip-camera-parts.sql` (notebook entry).
**Rubric rows touched:** Innovation Project CREATE (building the solution; parts and wiring plan).

---

## 2026-10-05 (Monday) — Innovation Project: expert meeting with Nate Ragan (Arizona Game and Fish)
**Who was there:** whole team (Thea, Adeline, Fynn, Isla, Nolan, Weston)
**Told by:** Adeline and Thea

**Raw update (their words, from their meeting notes; the notes were pasted twice, this is the fuller second copy):**
> We met with an expert His name is Nate Ragan from Game and Fish. Here are some of our notes. 300 animal strikes in a year. The bridge on I-17 is $24 billion. The bridge is supposed to reduce collisions by 90%. They have a live stream to watch the animals. The animals go where their mom goes, so if their mom goes on the bridge, they will. They put GPS tracking collars on the animals, like the elk. They tranquilize them and put the collars on. The batteries last three years, so once it dies, it falls off the animals automatically. There might be one camera on the bridge, but he's not sure. A camera with flashing light has been done before. The officers use cameras that use satellites and they send a notification to your phone. We prevent bad stuff from happening by not using a live stream. Um, we could use an AI to end the video or blur out any human. We won't get track of any data from Game and Fish, so we can get our own. If the bridge doesn't work out, we could put the camera on the squirrel nest and track that. We need... ADOT's permission to use the bridge. If we did cameras in a wide perimeter, it would be effective. The most effective. Game and fish use thermal seeing goggles that you can see through at night to look at animals. They don't use a lot of AI. They use drones for investigations in law enforcement.


**Our questions for the expert (their words, sent as a second update the same day; also pasted twice, cleaned up):**
> How many big crashes happen every year in Flagstaff, with the animals? Another one of our ideas is to make the camera send a blinking light to warn drivers that there is an animal crossing. Do you ever use live stream cameras? How long does it usually take for animals to figure out if a new bridge is safe and how to know the bridge is there for them, with big animals? For the big new overpass being built on the I-17 at Willard Springs, how are you guys planning to count the animals? Do you just strap regular trail cameras from the store to the bridge, or do you have special expensive equipment?

**Questions → answers (matched to the meeting notes above):**
| Our question | What Nate said (from our notes) |
|---|---|
| How many big animal crashes a year in Flagstaff? | About 300 animal strikes in a year |
| Idea: the camera makes a blinking light to warn drivers of an animal crossing | A camera with a flashing light has been done before |
| Do you ever use live stream cameras? | Yes, they have a live stream to watch the animals. But for our camera, not live streaming prevents bad stuff |
| How long until big animals figure out a new bridge is safe? | Babies go where their mom goes, so if the mom uses the bridge, they will too [unclear: no time given (weeks? years?)] |
| Willard Springs overpass on I-17: how will you count animals? Store trail cameras or special equipment? | There might be one camera on the bridge, but he's not sure. Game and Fish use GPS collars, satellite cameras that notify a phone, thermal goggles, drones [unclear: no answer on store vs. special cameras] |

**What happened**
- Innovation Project: **first real expert: Nate Ragan, Arizona Game and Fish Department.** What he told the team:
  - **The problem:** about **300 animal strikes in a year on I-17** (just I-17, confirmed by Adeline and Thea). The **I-17 wildlife bridge** (an overpass for animals) is supposed to cut collisions by **90%**. Cost: **$24 million** (the notes said "billion"; corrected by Adeline and Thea, Oct 5).
  - **How animals use it:** young animals follow their mom, so if the mom uses the bridge, they will too.
  - **How Game and Fish tracks animals:** GPS collars on elk (tranquilize, put the collar on). The battery lasts **3 years**, then the collar falls off by itself. They have a **live stream** of the animals. There **might** be one camera on the bridge (he wasn't sure). Officers use **satellite cameras that send a notification to your phone**. They use **thermal goggles** to see animals at night, **drones** for law-enforcement investigations, and **not a lot of AI**.
  - **Advice for our camera:** a camera with a flashing light has been done before. **Not live streaming** keeps bad things from happening. We could use **AI to edit the video or blur out any people** ("end" in the notes = "edit", confirmed by Adeline and Thea, Oct 5). **Cameras spread out over a wide area** would be the most effective. We **won't get data from Game and Fish**, so we collect our own. We need **ADOT's permission** to put a camera on the bridge. **Backup plan:** if the bridge doesn't work out, point the camera at the **squirrel nest** and track that.
- Robot Design / Robot Game / Core Values: nothing recorded.

**Wins / celebrate:** The team came with 5 prepared questions, and that's real research. Our first real expert! We talked to someone who protects wildlife for a job, and he gave us ideas we can actually use (blur people, no live stream, wide area, ADOT permission).
**Problems / open questions:**
- His advice says **no live stream**, but our Camera 1 plan (Oct 3) was for testing and **live streaming**. Keep it, change it, or blur people?
- Where does the forest camera go: the **I-17 wildlife bridge** (needs ADOT's OK) or the **squirrel nest** (backup)?
- One camera or **several cameras over a wide area**?
- Night vision came up again (Game and Fish use thermal at night; the "flashing light" camera).
- ~~$24 billion or million?~~ $24 million (confirmed). 300 strikes = just on I-17 (confirmed).
- New solution idea: **blinking warning light for drivers** (Nate: it's been done before). Add it, skip it, or make ours different?
- Still no answer on how long animals take to trust a new bridge, or what cameras will count animals at Willard Springs.
**Next practice:** Decide what to change because of Nate's advice and write down why. Find out who at ADOT to ask. Send Nate a thank-you note (Gracious Professionalism).
**App changes made:** `app/db/updates/2026-10-05-ip-expert-nate.sql` + `2026-10-05-ip-expert-questions.sql` (our 5 questions on Nate's card) — Nate added to Experts (the old sample experts and sample research removed), research row, notebook entry; Experts card now shows the date and the full notes list. Later the same day (Adeline and Thea asked): all remaining sample data removed (`2026-10-05-remove-samples.sql`), and the empty Innovation Project spots (Problem, Solution, How We Got Here, 8-Step Progress, Project Plan) became boxes the team fills in. Fixes: `2026-10-05-ip-expert-edit-fix.sql`, `2026-10-05-ip-bridge-cost-fix.sql`, `2026-10-05-ip-strikes-i17.sql`.
**Rubric rows touched:** Innovation Project RESEARCH (first expert consulted); IDENTIFY (problem facts: animal strikes, wildlife bridge); ITERATE (expert feedback to act on).

---

## 2026-10-03 (Saturday) — Innovation Project: two cameras, mode switch, parts list
**Who was there:** [unclear: chat update] — Thea, with help from Coach CJ
**Told by:** Thea

**Raw update (their words):**
> Our coach helped us get two different options: We will have a switch that keeps the camera in "always on mode". We will build two copies. The first will plug into power behind our house which has a view of the forest. We will use this for testing and for "live streaming" via WiFi. We will build a second one that we can put in the forest in "solar mode" which will turn it off and on based on movement. When we want to collect the data, we will walk up to the camera and flip the switch into "always on mode" so the WiFi comes on and connects. Then when we are done downloading, we will switch it back to solar mode for power savings. Both of these will use a USB-C connector for providing power to the unit. Let me know if we are missing anything.

(Plus a parts list: camera box = XIAO ESP32S3 Sense, 32 GB high-endurance microSD, DS3231 clock + CR2032, AM312 motion sensor, SPDT mini toggle switch, waterproof USB-C panel-mount jack, IP65/IP67 box. Solar rig in its own box = DFRobot Sunflower Solar Power Manager 5V (DFR0559), 5 V 3–5 W panel, protected 18650 (e.g. Panasonic NCR18650B) + holder, USB-A to USB-C cable, IP65 box.)

**What happened**
- Innovation Project: **design decided:** two identical camera boxes. **Camera 1 (house)** is plugged in behind Thea's family's house, faces the forest, used for testing and live streaming over Wi-Fi. **Camera 2 (forest)** runs on solar, sleeps, and wakes on movement. A **mode switch** (always-on ↔ solar). To collect pictures: walk up, flip to always-on, the Wi-Fi connects, download, flip back. **USB-C power in on both**, so the same camera box works on wall power or on the separate solar box.
- Claude's check, things missing: night vision (NoIR camera + IR LEDs); the switch must also be able to **wake** the sleeping camera; a timeout in case someone forgets to flip it back; in the forest there's no house Wi-Fi, so the camera makes its own hotspot; the motion sensor dome must stick out of the box (it can't see through plastic), camera behind a clear window; sensor hood; silica gel + cable glands; solar panel in a sunny clearing, tilted south; battery must not charge below freezing; heat when streaming all day; sleep power is higher than 20 µA through the 5 V USB path (test it); parts list quantities ×2 for the camera box; house unit needs a 5 V USB-C wall charger.

**Wins / celebrate:** A test camera at home before risking one in the forest is real engineering (test → improve). One camera box, two power sources: a smart, swappable design.
**Problems / open questions:** Night vision: add it? [unclear: still open from earlier — is the forest camera near a road or trail?]
**Next practice:** Order the parts. Build Camera 1 first and test it at the house.
**App changes made:** data only — `app/db/updates/2026-10-03-ip-two-cameras.sql` (notebook entry).
**Rubric rows touched:** Innovation Project DESIGN (detailed plan, two versions); CREATE (parts list); ITERATE (planned home test).

---

## 2026-10-03 (Saturday) — Innovation Project: chose the XIAO camera + Pi 4 over Wi-Fi
**Who was there:** [unclear: chat update] — Thea ("we")
**Told by:** Thea

**Raw update (their words):**
> We will use the Seeed Studio XIAO ESP32-S3 Sense Board which has WiFi built into it. We're thinking about using our Raspberry Pi 4 to wirelessly connect to the ESP32 and pull the images directly over WiFi.

**What happened**
- Innovation Project: **decided: the forest camera is the Seeed Studio XIAO ESP32-S3 Sense** (built-in Wi-Fi). **Idea (not final):** the team's Raspberry Pi 4 connects to it over Wi-Fi and pulls the pictures off. Close to Option C from the earlier research.
- Claude's check: (1) **Wi-Fi range.** The XIAO's small antenna reaches roughly 30–100 m outdoors, less through trees, so the Pi has to come close or live nearby. (2) **Battery.** If the camera keeps its Wi-Fi on waiting for the Pi, the battery lasts only days. Ways to fix it: the camera wakes on a schedule (the DS3231 clock can wake it) or checks for the Pi's Wi-Fi every few minutes and **sends** its pictures when it finds it ("push" instead of "pull").
- Options offered for where the Pi lives: walk-up collect (Pi + a USB battery pack carried near the camera) / Pi stays at a building near the forest edge / Pi in the forest too (needs the big solar again).

**Wins / celebrate:** Build decision made, and the team reused hardware they already own (the Pi 4).
**Problems / open questions:** Where will the Pi be, and how far from the camera? Pull or push? [unclear: still open from earlier: is the camera near a road or trail?]
**Next practice:** Range test: put the XIAO somewhere, walk away with the Pi or a phone, and measure where the Wi-Fi drops (in the open, then through trees).
**App changes made:** data only — `app/db/updates/2026-10-03-ip-xiao-wifi.sql` (notebook entry).
**Rubric rows touched:** Innovation Project DESIGN (build decision + how the parts talk to each other).

---

## 2026-10-03 (Saturday) — Innovation Project: research on a low-power camera (XIAO ESP32S3 Sense)
**Who was there:** [unclear: chat update] — Thea, with research help from Coach CJ
**Told by:** Thea

**Raw update (their words):**
> My coach helped with some research using Google Gemini and it recommended doing the following items because they are cheaper and use less power. Help me decide:

(Pasted research, summarized: the Pi 4 uses 3–5 W all the time and needs a 50–100 W panel and a big battery, and takes 25–35 s to start up, so it can't be turned off between animals. Suggested instead: **Seeed Studio XIAO ESP32S3 Sense** (tiny camera board, sleeps at under 20 µA, about 100 mA while taking a picture), 32 GB high-endurance microSD, DS3231 clock module + CR2032 coin cell, AM312 mini motion sensor, CN3791 MPPT solar charger (6 V version), 6 V 2–3 W solar panel, protected 3.7 V 18650 battery (~3000 mAh) + holder, IP65/IP67 box, 3D-printed hood for the motion sensor, 22 AWG wire. No cellular modem.)

**What happened**
- Innovation Project: **new research source** (Coach CJ + Thea, using Google Gemini). Compared it with the Oct 3 Pi 4 plan. Claude's check: the low-power idea is sound (sleeps between animals, wakes in about 1 s instead of 30 s, ~$90 instead of ~$300, small panel). **Gaps found:** (1) no night vision, since the standard camera can't see in the dark, so it needs a night-vision (NoIR) camera lens + small infrared LEDs; (2) the tiny chip can tell "animal or not," but not reliably *which* animal, so species tagging should happen later on a bigger computer; (3) with no cellular modem and no Wi-Fi in the forest, pictures stay on the SD card until someone collects them; (4) the 18650 battery also must not charge below freezing.
- Options offered: **A** XIAO only · **B** Pi 4 only (Oct 3 list) · **C** team-up: XIAO in the forest + the Pi 4 at home as the "AI station" that tags the animals and puts them on the website.

**Wins / celebrate:** First research source logged, and a real design comparison (two builds, power vs. cost vs. features). This is the kind of tradeoff judges ask about.
**Problems / open questions:** Which option (A/B/C)? [unclear: the research mentions blocking "the road view" — is the camera going near a road or trail?]
**Next practice:** Team picks A/B/C and writes down why.
**App changes made:** data only — `app/db/updates/2026-10-03-ip-xiao-research.sql` (research row + notebook entry).
**Rubric rows touched:** Innovation Project RESEARCH (first real source); DESIGN (comparing two designs).

---

## 2026-10-03 (Saturday) — Innovation Project: picked Option B, parts list
**Who was there:** [unclear: chat update, not a practice report]
**Told by:** Thea (confirmed Oct 3)

**Raw update (their words):**
> option b we have a raspberry 4 and a m5cam module and a microSD card. what else do we need to buy? give me specific parts that are not expensive, work with the raspberry pie 4 and will keep the whole thing running 24/7

**What happened**
- Innovation Project: team **picked Option B (Raspberry Pi build)**. **Already have:** Raspberry Pi 4, an "m5cam" module, a microSD card. Goal: cheap parts that work with the Pi 4 and **run 24/7**. Claude gave a shopping list sized from a power estimate (Pi 4 ≈ 4–5 W all day ≈ 120 Wh/day → ~100 W panel + 12 V 20 Ah LiFePO4 battery for 2 cloudy days). See `INNOVATION-PROJECT.md`.
- Robot Design / Robot Game / Core Values: nothing recorded.

**Wins / celebrate:** Build option chosen; parts already on hand.
**Problems / open questions:** [unclear: "m5cam" is probably an M5Stack ESP32 camera — it can't plug into the Pi's camera port; check the label.] Running 24/7 makes the solar + battery the most expensive part — tradeoff to decide (24/7 vs. daytime only / scheduled). Cold: battery must not charge below freezing. Still open: how pictures reach the website, placement permission, expert.
**Next practice:** Check the m5cam label. Decide 24/7 vs. a cheaper schedule. Make the final shopping list with CJ.
**App changes made:** data only — `app/db/updates/2026-10-03-ip-option-b.sql` (one Innovation Project notebook entry).
**Rubric rows touched:** Innovation Project DESIGN (build plan, parts, power budget); CREATE (materials).

---

## 2026-10-02 (Friday) — Practice, second update: Adeline, Nolan, Weston
**Who was there:** [unclear: attendance not given] — Adeline, Nolan, Weston did something (plus Fynn, in the update above)
**Told by:** [who? a student — first name not given]

**Raw update (their words):**
> october 2 adeline finished programing mission 15 and 12 and nolan programed 2 and 3 he got 5/5 times in his tests. weston worked on building the attachments for the tree mission

**What happened**
- Robot Design / programming: **Adeline finished programming "mission 15" = M15 Biocentric Architecture and "mission 12" = M12 Forest Elder.** M15 now has two coders (Isla Sep 25, Adeline Oct 2); M12 has four (Isla, Fynn, Thea, Adeline). **Nolan programmed "2 and 3" = M02 Exploding Seeds + M03 Flip the Rock** — Nolan's first mission program; he also built the combined 2 + 3 attachment.
- Robot Design / attachments: **Weston worked on building the attachments for "the tree mission"** [unclear: which mission? The big tree model holds M08 Tangled (vines) and M09 Research Platform; M12 Forest Elder also has a tree. Weston said "attachments" — more than one?]
- Robot Game: **second test session of the day — Nolan's M02 + M03: 5 successes out of 5 (100%)** [unclear: one run doing both missions, or 5/5 for each mission separately? Logged as one test of the combined 2 + 3 attachment]. M02 and M03 → Working, reliability 100%. Missions with a counted test: **3** (M14, M02, M03). Missions with a program: **7** (M01, M02, M03, M04, M12, M14, M15).
- Core Values: four teammates (Fynn, Adeline, Nolan, Weston) credited on one day; Adeline finished programs Isla and others started — Teamwork.

**Wins / celebrate:** Two perfect 5-for-5 tests in one day! Nolan wrote his first mission program and it worked every time. Programs jumped from 5 missions to 7.
**Problems / open questions:** Which is "the tree mission"? Nolan's 5/5 — both missions in one run? What did Adeline change in M12 and M15 — and are they tested yet?
**Next practice:** Test M12 and M15 now that Adeline finished them. Time the M02 + M03 run. Name the tree mission and keep building it.
**App changes made:** data only — `app/db/updates/2026-10-02-adeline-nolan-weston.sql` (coders on M12, M15, M02, M03; new M02 + M03 program row; M02 + M03 test 5/5; M02, M03 → Working 100%; three notebook entries).
**Rubric rows touched:** Robot Design TEST / ITERATE (second counted test); CREATE — Code / sensors (5 → 7 mission programs, 5 different coders); DESIGN — skills in all members (Nolan, a builder, now codes); Core Values TEAMWORK.

---

## 2026-10-02 (Friday) — Practice: first test session (M14)
**Who was there:** [unclear: attendance not given] — Fynn did something
**Told by:** [who? a student — first name not given]

**Raw update (their words):**
> october 2 fynn programed mission 14 and got 5/5 in her tests

**What happened**
- Robot Design / programming: **Fynn programmed "mission 14" = M14 Seeds of Renewal** (attachment: Weston, Sep 19). Fynn also wrote the first M14 program on Sep 25 [unclear: improved the same program, or a new version?].
- Robot Game: **first test session of the season! M14 Seeds of Renewal: 5 successes out of 5 tries (100%)**, run by Fynn. M14 status → Working, reliability 100%. Missions with a counted test: **1** (M14).
- Innovation Project: see the separate 2026-10-02 entry below (forest camera idea).
- Core Values: nothing new recorded.

**Wins / celebrate:** The very first counted test runs — and a perfect 5 for 5! M14 is the first mission with real proof that it works.
**Problems / open questions:** What did Fynn change in the program since Sep 25? How many seeds landed in the replantation station / touched the mat on each try (how many of M14's 30 points)? How long does the run take (the run plan still guesses 30 s)?
**Next practice:** Run M14 more times (10+) to see if it stays at 100%. Time one M14 run. Test another mission that has a program (M01, M04, M12, or M15).
**App changes made:** data only — `app/db/updates/2026-10-02-m14-test.sql` (M14 test session 5/5, M14 status Working + reliability 100%, notebook entry).
**Rubric rows touched:** Robot Design TEST / ITERATE (first test session with counted results); Robot Design CREATE — Code / sensors.

---

## 2026-10-02 (Friday) — Innovation Project solution idea
**Who was there:** [unclear: not a practice report — a student shared the project idea in chat]
**Told by:** Thea (confirmed Oct 3)

**Raw update (their words):**
> For our innovation project which is like a science project we are going to be making a camera to put in the forest. it needs to have an AI camera to tag animals, solar panels and batteries so it can charge in the sun. we are going to send the images to website we built. i need help getting the materials. can you give me some ideas.

**What happened**
- Innovation Project: **first real solution idea logged** — a forest wildlife camera with an **AI camera that tags animals**, **solar panels + batteries** so it charges in the sun, and **sends its pictures to a website the team built**. The team is now gathering materials (Claude gave a materials list with three build options — see `INNOVATION-PROJECT.md`).
- Robot Design / Robot Game / Core Values: nothing recorded.

**Wins / celebrate:** The Innovation Project has a real solution for the first time, and the team already built a website for it.
**Problems / open questions:** What problem does the camera solve, in the team's words (who needs to know which animals are in the forest)? [unclear: which website — the team's own project site, not this app?] How will pictures get from the forest to the website (Wi-Fi/cell signal)? Where will it go, and who gives permission? Which build option will the team pick?
**Next practice:** Pick a build option and make a shopping list with prices. Write the problem statement. Find an expert (wildlife biologist, forest ranger, Arizona Game and Fish).
**App changes made:** data only — `app/db/updates/2026-10-02-ip-forest-camera.sql` (one Innovation Project notebook entry). The Innovation Project page summary is still sample data until the team writes its problem statement.
**Rubric rows touched:** Innovation Project IDENTIFY / DESIGN (first solution idea and its parts); CREATE (materials planning).

---

## 2026-09-25 (Friday) — Practice
**Who was there:** Thea, Isla, Fynn · **Not there:** Nolan, Weston, Adeline
**Told by:** [who? a student — first name not given]

**Raw update (their words):**
> sep 25 Thea programed mission 12 Isla built and programed the attachment for mission 15 fynn programed mission 14. Nolan Weston and Adeline were not there.

**What happened**
- Robot Design / programming: **Thea programmed "mission 12" = M12 Forest Elder** — Thea's first mission program. M12 now has three coders (Isla Sep 11, Fynn Sep 19, Thea Sep 25) [unclear: one program improved each time, or different versions?]. **Isla built and programmed the attachment for "mission 15" = M15 Biocentric Architecture** — Isla built an M15 attachment Sep 19 [unclear: finished/rebuilt it today, or the same build?]; the program is new. **Fynn programmed "mission 14" = M14 Seeds of Renewal** (attachment: Weston, Sep 19).
- Robot Game: missions with a program: **5 of 9 started** (M01 Adeline · M04 Adeline · M12 Isla + Fynn + Thea · M14 Fynn · M15 Isla). Still 9 of 15 missions with an attachment (280 of 440 pts). Still no runs counted. Details in `ROBOT-GAME.md`.
- Innovation Project: nothing recorded.
- Core Values: Fynn coded an attachment Weston built, and Thea worked on a program two teammates started — Teamwork across builders and coders, even with half the team away.

**Wins / celebrate:** Only three teammates, and three programs got written. Programs jumped from 3 missions to 5. Thea wrote her first mission program. Isla now has built *and* coded the 40-point mission.
**Problems / open questions:** M12 has three coders — same program or versions? Did Isla change the M15 attachment today? Still zero test runs counted. Run plan is still 8 runs ≈ 245 s, over 150 s.
**Next practice:** Run one mission that has both an attachment and a program (M01, M04, M12, M14, or M15) and count successes out of tries — the first test session. Catch Nolan, Weston, and Adeline up on the new programs.
**App changes made:** `mockups/14-rooted-warriors-app-v4.html` in place — Coded: M12 + Thea, M14 → Fynn, M15 → Isla (Coding chip now 5 of 9); Coding table: Thea on M12, new rows for M14 and M15; Sep 25 versions on the M12, M14, M15 attachment cards; three Sep 25 notebook entries; Sep 25 Teamwork moment; proudest-moment quote. See `APP-CHANGES.md`.
**Rubric rows touched:** Robot Design CREATE — Code / sensors (3 → 5 mission programs, 4 different coders); Robot Design DESIGN — Skills in all members (Thea adds coding to building); Core Values TEAMWORK.

---

## 2026-09-19 (Saturday) — Practice
**Who was there:** Fynn, Thea, Adeline, Isla, Nolan, Weston — all six did something
**Told by:** [who? a student — first name not given]

**Raw update (their words):**
> Saturday sep 19 Fynn programed the forest elder. Thea finished the Keystone Species attachment. Adeline programed mission 4. Isla built an attachment for mission 15. Nolan built the attachment for number 2 and he worked on number 8. Weston built the attachment for number 14.

**What happened**
- Robot Design / attachments: **Thea finished** the **Keystone Species (M13) attachment** (v1 built Sep 11 → finished Sep 19). **Isla built** an attachment for **"mission 15" = M15 Biocentric Architecture** (new mission, 40 pts). **Nolan built** the attachment for **"number 2" = M02 Exploding Seeds** ([unclear: is this his combined 2+3 attachment finished, or a separate M02-only one? Adeline also has an M02 attachment from Sep 4]) and **worked on "number 8" = M08 Tangled** (new mission). **Weston built** the attachment for **"number 14" = M14 Seeds of Renewal** (new mission) — Weston's first attachment; he had been on the robot base.
- Robot Design / programming: **Fynn programmed the Forest Elder (M12)** — Isla also wrote an M12 program on Sep 11 [unclear: did Fynn rewrite it, improve it, or program a second version?]. **Adeline programmed "mission 4" = M04 Lucky Leaves** (attachment: Fynn, Aug 31). Adeline now has two mission programs (M01, M04).
- Robot Game: missions with an attachment started: **9 of 15** (M01, M02, M03, M04, M08, M12, M13, M14, M15) worth **280 of 440** mission points. Missions with a program: **3** (M01 Adeline · M04 Adeline · M12 Isla + Fynn). Still no runs counted. Details in `ROBOT-GAME.md`.
- Innovation Project: nothing recorded.
- Core Values: **all six teammates contributed in one practice** (Inclusion / "all members contributed"). Fynn programming an attachment Isla finished = Teamwork across builders and coders. Details in `CORE-VALUES.md`.

**Wins / celebrate:** Biggest build day so far — three brand-new missions got attachments (M08, M14, M15), Keystone Species is finished, and a third mission has a program. Every single teammate did something. Weston built his first attachment.
**Problems / open questions:** Nolan's "number 2" attachment — the combined 2+3 or a separate one? Fynn's Forest Elder program vs Isla's from Sep 11 — same program improved, or two programs? The draft run plan is now **8 runs × ~30 s = 245 s**, way over the 150 s match — which missions will share a run? (M13, M14, M15 all sit on the interchangeable dock area — a natural group.) Still zero test runs counted for any attachment.
**Next practice:** Run one finished attachment + program (M01, M04, or M12) and count successes out of tries — the first test session. Answer the two [unclear] questions. Start sketching which missions share a run.
**App changes made:** `mockups/13-rooted-warriors-app-v3.html` in place — inventory: M13 finished (Working), M15 (Isla), M02 (Nolan built), M08 (Nolan, in progress), M14 (Weston); Coded: M04 → Adeline, M12 → Isla + Fynn; three new attachment cards + new versions on Keystone Species and Mission 2; Coding table rows for M04 and M12 (Fynn); runs 6–8 in the DRAFT plan (245 s); six Sep 19 notebook entries; Sep 19 Inclusion moment; proudest-moment quote. Later the same day (student request): Learned / Worked with most / Notebook entries blanked on the five non-Thea profile cards so each teammate fills in their own; then the Role line for everyone except Adeline. Also (student request): the Daily Log's Notebook Feed now hides behind an "Open the Notebook Feed" button with a Back button, so the page isn't overwhelming at first sight. Robot Design specs card renamed "The Main Robot" (was "The Actual Robot Thing"). Then a new **Coding** page → new file `mockups/14-rooted-warriors-app-v4.html` (programs table moved out of Robot Design, plus who-coded-what and coding notebook entries). Logo background made transparent, then given an outline (black, then changed to dark green). See `APP-CHANGES.md`.
**Rubric rows touched:** Robot Design CREATE — Attachments (6 → 9 missions) and Code / sensors (3 programs); Robot Design DESIGN — All members contributed (all six credited on one day — the strongest evidence so far); Core Values INCLUSION.

---

## 2026-09-11 — Practice
**Who was there:** [unclear: attendance not recorded] — Thea, Adeline, Isla did something
**Told by:** [who? a student — first name not given]
**Date note:** [unclear: the update said "august 11". Today is Sept 11 and the work fits September (robot base finished Sep 6; Forest Elder attachment started Sep 4). Logged as 2026-09-11 until a student or CJ confirms.] If it really was Aug 11, move this entry to the bottom of the log.

**Raw update (their words):**
> august 11 Thea Made thea mascot and attachment for the mascot mission. Adeline did the programing for the drone survey and isla finished the attachment for the forest elder and did the programing.

**What happened**
- Robot Design: **Thea** built the **team mascot** and an **attachment for "the mascot mission"** (= **M13 Keystone Species**, the mission where the robot delivers a team-built creature to the restoration platform — it is the only mission that needs a team-built piece; **[confirm with CJ]**). **Isla** finished the **Forest Elder (M12) attachment** ([unclear: the one Fynn created Sep 4, or a second build?]) **and programmed it**. **Adeline** **programmed the Drone Survey (M01) mission**. These are the first two mission programs.
- Robot Game: missions with an attachment started: **6 of 15** (M13 is new). Missions with a program written: **2** (M01 Adeline, M12 Isla). No runs counted yet. Details in `ROBOT-GAME.md`.
- Innovation Project: nothing recorded.
- Core Values: the team has a **mascot** (Thea) — team identity and Fun. Isla finishing an attachment a teammate started would be Teamwork (if it is the same attachment). Details in `CORE-VALUES.md`.

**Wins / celebrate:** First two mission programs written (Adeline, Isla). A team mascot that also scores points — it doubles as our Keystone Species piece. Attachments started for 6 missions.
**Problems / open questions:** Was the practice Aug 11 or Sept 11? Is "the mascot mission" M13 Keystone Species? Did Isla finish Fynn's Forest Elder attachment or build her own? What is the mascot — does it have a name? Have the Drone Survey and Forest Elder programs been run on the robot yet (tries / successes)?
**Next practice:** Run the two programs and count successes out of tries — the first test session for the judges' ITERATE row. Name the mascot and take its picture. Time one real run: the draft run plan now has 5 runs of 30 s guesses = 155 s, over the 150 s match.
**App changes made:** `mockups/13-rooted-warriors-app-v3.html` in place — M13 in the inventory with the "the mascot mission" alias and Thea credited; Mascot attachment card; M12 marked finished with Isla added as builder and coder; Coded column filled for M01 (Adeline) and M12 (Isla); two Coding-table rows; three Sep 11 notebook entries; run 5 (M13) in the draft plan; new **Team Mascot** card on the Core Values page; Sep 11 Fun moment; proudest-moment quote. See `APP-CHANGES.md`.
**Rubric rows touched:** Robot Design CREATE — Attachments (now 6 missions) and **Code / sensors** (first mission programs — this row was self-rated 1, it now has evidence); Robot Design DESIGN — All members contributed (Thea, Adeline, Isla credited); Core Values FUN (team mascot).

---

## 2026-09-06 — Coach update (no practice)
**Who was there:** n/a — CJ relayed news from the students
**Told by:** CJ (dictating for the students)

**Raw update (their words):**
> Summary, not a quote: the robot base design is finished and Thea, Nolan, and Weston built three identical copies. The base is low and wide (low center of gravity so it won't tip; wide wheelbase for accurate turns; tradeoff is it's harder in tight spaces). They reinforced it with bracing. They talked about color sensors and decided on no sensors because the compact base has no room for one.

**What happened**
- Robot Design: base design **finished**; **three identical copies built** (Thea, Nolan, Weston). Base decisions recorded: low + wide, reinforced, no sensors. Details in `ROBOT-DESIGN.md` and `../DECISIONS.md` (2026-09-06).
- Robot Game: CJ loaded the **official BIOGLOW mission list** (15 missions, points, bags, scoring) into `../06-missions-bioglow.md` from the Robot Game Rulebook, and set the mission-alias convention. Piece counts confirmed from the built models (3 seeds M02, 4 leaf fragments M06, 3 seeds M14). Details in `ROBOT-GAME.md`.
- Innovation Project: nothing new. App page still shows sample data.
- Core Values: three students finishing the base together — teamwork moment.

**Wins / celebrate:** A finished, repeatable robot base. Three copies means three attachments can be tested at once, plus a spare for tournaments.
**Problems / open questions:** Why three copies? (students to write the tradeoff *why*). Base specs still blank: size, motors, how attachments attach.
**Next practice:** Ask the students *why* three copies. Measure the base. Start logging test sessions (successes out of attempts) per attachment.
**App changes made:** `mockups/13-rooted-warriors-app-v3.html` (new file, v3): real 15 missions on Robot Game page; real attachments/notebook/specs; then updated in place with base status, tradeoff rows, Sep 6 notebook entries. See `APP-CHANGES.md`.
**Rubric rows touched:** Robot Design DESIGN (tradeoffs with reasons → Accomplished), Robot Design CREATE (finished repeatable base), sets up ITERATE.

---

## 2026-09-04 — Practice
**Who was there:** [unclear: attendance not recorded] — Thea, Adeline, Nolan, Fynn, Weston all did something
**Told by:** students (via CJ)

**Raw update (their words):**
> Summary, not a quote: Thea updated the profile cards for everyone in the app. Adeline worked on the Mission 2 attachment. Nolan worked on combining Missions 2 and 3 into one attachment. Fynn created an attachment for Mission 12. Weston kept building the robot base. Adeline made the starting program template for the robot base.

**What happened**
- Robot Design: **Weston** continued building the robot base. **Adeline** created the initial program template for the base (the starting point every mission program builds from).
- Robot Game: attachments — **Adeline** worked on M02 Exploding Seeds ("Mission 2"); **Nolan** worked on a combined attachment for M02 + M03 Flip the Rock ("Missions 2 + 3"); **Fynn** created the M12 Forest Elder ("Mission 12") attachment.
- Innovation Project: nothing recorded.
- Core Values: **Thea** filled in every teammate's profile card in the app v2 — first real team data entered. Card facts in `CORE-VALUES.md`.
- App design (same day): students voted **Sidebar HQ** (mockup 06) as the layout out of five. App v1 and v2 test builds were created. Details in `APP-CHANGES.md` and `../DECISIONS.md`.

**Wins / celebrate:** First real data in the app (all six profile cards). Layout chosen. Attachments started for three more missions.
**Problems / open questions:** Mission 2 now has two attachment efforts (Adeline's, and Nolan's combined 2+3). Which one will the team use, and why? That's a tradeoff-worksheet entry waiting to happen.
**Next practice:** Decide between the two Mission 2 approaches and record the why. Keep building the base.
**App changes made:** `mockups/11-rooted-warriors-app-v1.html` (new, Sidebar HQ, 7 pages); `mockups/12-rooted-warriors-app-v2.html` (new, real logo + real roster); profile cards made tap-to-edit; Thea's edits entered. See `APP-CHANGES.md`.
**Rubric rows touched:** Robot Design ITERATE (two students on the same missions, then combining → Developing toward Accomplished); Robot Design PLAN / clear mission strategy (shared base program template); Core Values INCLUSION (every teammate on a card).

---

## 2026-08-31 — Practice
**Who was there:** [unclear: attendance not recorded] — Isla, Fynn, Nolan did something
**Told by:** students (via CJ)

**Raw update (their words):**
> Summary, not a quote: built the attachments for Drone Survey and Lucky Leaves. Flip the Rock isn't finished yet.

**What happened**
- Robot Design: nothing separate recorded.
- Robot Game: **Isla** built the M01 Drone Survey attachment. **Fynn** built the M04 Lucky Leaves attachment. **Nolan** started the M03 Flip the Rock attachment (in progress).
- Innovation Project: nothing recorded.
- Core Values: nothing recorded.
- App design (same day): the **Rooted Warriors logo** was finalized and its colors became the official app palette. Five layout mockups (06–10) in the logo colors were made for the students to vote on. CJ chose the architecture (his part, not the students'). Details in `../DECISIONS.md` 2026-08-31.

**Wins / celebrate:** First two mission attachments finished. Team logo done.
**Problems / open questions:** Flip the Rock attachment unfinished.
**Next practice:** Vote on layout 06–10. Finish Flip the Rock.
**App changes made:** `mockups/06`–`10` created (five layouts, logo palette). See `APP-CHANGES.md`.
**Rubric rows touched:** Robot Design CREATE (attachments built, credited by builder).

---

## 2026-08-28 — Practice
**Who was there:** [unclear]
**Told by:** students (via CJ)

**Raw update (their words):**
> Summary, not a quote: the robot will use the 49.5 × 20 mm tires for the drive wheels.

**What happened**
- Robot Design: **drive tires chosen: 49.5 × 20 mm.** [unclear: who decided, and what other tires were considered — the *why* is not recorded]
- Robot Game / Innovation Project / Core Values: nothing recorded.

**Wins / celebrate:** A concrete robot spec decided.
**Problems / open questions:** Why those tires? (needed for the tradeoff worksheet)
**Next practice:** —
**App changes made:** none that day.
**Rubric rows touched:** Robot Design DESIGN (a design choice, reason still to capture).

---

## Week of 2026-08-24 — Practice(s)
**Who was there:** [unclear]
**Told by:** students (via CJ)

**Raw update (their words):**
> Summary, not a quote: the robot will have a wide wheel base. The team built the base robot.

**What happened**
- Robot Design: decision — **wide wheel base**. Milestone — **the base robot (core chassis) was built** (first version; the design kept evolving through Sep 6). [unclear: exact date and who built it]
- Robot Game / Innovation Project / Core Values: nothing recorded.
- App design (before Aug 31, exact date unclear): five color-theme dashboard mockups (01–05: Neon Glow, Space Mission, Clean Sport, Retro Arcade, Brick Builder) were made before the logo existed. Never voted on; superseded by the logo palette.

**Wins / celebrate:** First robot base built.
**Problems / open questions:** —
**Next practice:** —
**App changes made:** `mockups/01`–`05` created. See `APP-CHANGES.md`.
**Rubric rows touched:** Robot Design CREATE (first base built), DESIGN (wide-base choice; the *why* was captured later on Sep 6).

---

## Entry template

```
## YYYY-MM-DD — Practice
**Who was there:** 
**Told by:** (which student typed the update)

**Raw update (their words):**
> ...

**What happened**
- Robot Design: 
- Robot Game: 
- Innovation Project: 
- Core Values: 

**Wins / celebrate:** 
**Problems / open questions:** 
**Next practice:** 
**App changes made:** (file + what; details in APP-CHANGES.md)
**Rubric rows touched:** (e.g., Robot Design ITERATE, Core Values TEAMWORK)
```
