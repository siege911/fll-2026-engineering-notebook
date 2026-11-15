# Season App: match the talks + finish the documentation

Written 2026-11-15 (Claude, for Coach CJ), from the team's hand-edited judging talks (`PRESENTATION.md`, `../presentation/Rooted-Warriors-Judging-Talks.docx`) and the app's data as of today (`../app/db/snapshot.json`). **Nothing here is built yet.** Both lists are suggestions: the students pick (CLAUDE.md rule 4). Check items off and date them as they get done.

---

## Part 1 — Put the app in the same order as the talks

Isla now hands the judges the app and says "follow along." So the screen should move in the same order the speakers talk. Each line says who talks about it.

### Sidebar
1. **Reorder the nav to follow the talks:** Dashboard → Innovation Project → Robot Design → Robot Game → Coding → Core Values → Daily Log → Rubric Check. (Today Robot Game and Robot Design come before Innovation Project, and Coding sits between Robot Design and the IP.)

### Dashboard (Isla opens on this)
2. **Add a "Follow along" card at the top:** two short lists (🌲 Innovation · 🤖 Robot Design), one line per speaker in talk order, each a link that jumps straight to the card they show. The judges can tap along, and it's a map for questions afterward.
3. Move **Who's Been Doing What** and **Proudest Moment** up next to it (Thea + Nolan both close on "everyone had a part").

### Innovation Project page
Today: Problem/Solution/How → Research → Gantt → 8-Step → Experts → Communication → Photos → Details (Parts, Wiring, Code).
Suggested (talk order = rubric order):

| # | Card | Speaker | Change |
|---|---|---|---|
| 4 | **The Problem** (alone, full width) | Isla | Split out of the Problem/Solution/How strip. Add the bridge cost and the source. |
| 5 | **Ideas We Considered** *(new, small)* | Adeline | The 3 ideas (warning light, in-car camera, bridge-counting camera) and why we picked one multi-purpose camera. |
| 6 | **Experts & Their Feedback** | Adeline | Move up above Research (Adeline says Nate first). |
| 7 | **Research Collection** | Adeline | No change; it already has 11 sources. |
| 8 | **Project Plan (Gantt)** | Adeline | No change. |
| 9 | **Who Did What on the Camera** *(new, small)* | Thea | One line per student: design + code, wiring, soldering, notes + trifold, solar panels. Today the page has no team-involvement card at all. |
| 10 | **Our Solution: how the camera works** | Thea | Move the "Our Solution" box here: two motion methods, Pi as collector, SpeciesNet tags and blurs people. |
| 11 | **Project Photos** | Thea | Move up from near the bottom (soldering, solar panels, breadboard). |
| 12 | **Camera Wiring Diagram** | Nolan | Pull up from Innovation Project Details into the main flow (it's the "model/drawing" row). |
| 13 | **Communication** | Nolan | No change in place. |
| 14 | **Feedback → What We Changed** *(new, or fold into Experts)* | Weston | The improvement trail as before → after rows: "blur people (Nate)", "Pi in the forest → tiny camera (energy, smaller solar panel)". Today these are scattered across Experts, Communication and the Gantt. |
| 15 | **Next Steps** *(new, small)* | Fynn | Proper case / 3D-printed box, ADOT paperwork for the bridge, first bridge data. Plus the Nov 9 "first full run" milestone. |
| 16 | **8-Step Progress** | — | Not in either talk: move it to the bottom, or make it a thin strip under the page title. |
| 17 | **Innovation Project Details** (parts, code + install) | — | Stay at the bottom as reference (minus the wiring diagram, now in #12). |

### Robot Design page (Isla, Adeline, Weston, Thea)
Today: The Main Robot → Attachments Over Time → Test Sessions → Tradeoff Decisions.
18. **The Main Robot** (Isla) → **Tradeoff Decisions** (Isla: wheels, low + wide, three copies; Adeline: the no-gears robot). Move Tradeoffs up from the bottom to second.
19. **Our Strengths** *(new, small)* (Adeline): master builders, first programmers, final code run-through, documenter. The words are already in her paragraph.
20. **Attachments Over Time** (Weston, then Thea's Research Platform rebuild) → **Test Sessions** (Fynn). Same as today.

### Robot Game page (Isla, Fynn)
21. Put **Run Plan & Time Check** first (Isla: "all 15 missions in nine runs"; Fynn: timed every mission). Mission Inventory second. Points-per-Second, Score History and Log a Match after.

### Coding page (Adeline, Fynn, Thea)
22. **Programs We've Written** first, with the template, gyro turns, two motors at once, wall squaring + gyro reset, auto-next-mission at the top (Adeline + Fynn).
23. **Mission Programs: Who Coded What** second (Weston: "every one of us builds AND codes").
24. **Our Robot Code** history third (Thea: "18 changes", Mission 4: 19 → 57 lines). Coding notebook entries last.

### Rubric Check page
25. Make each rubric row a link to the card that proves it (the same links as the Dashboard "Follow along" card).

---

## Part 2 — What's missing before the app is "complete" as documentation

The rule from CLAUDE.md: every fact the talks say should be in the markdown **and** in the app, with a date and who. ⭐ = said out loud in the talks, so a judge may look for it.

### Innovation Project
- [ ] ⭐ **The Problem / Our Solution / How We Got Here boxes are empty.** Nothing has ever been typed into them. Fill all three, using the words from Isla's, Thea's and Weston's paragraphs.
- [x] ⭐ Bridge cost: **$21 million**, ADOT's current projection (may rise to $24M). Done 2026-11-15.
- [ ] ⭐ The 3 early ideas (warning light, in-car camera, bridge camera) and why we picked the multi-purpose camera: a dated notebook entry.
- [x] ⭐ Isla + Fynn got the solar panels working (Nov 14): entry + Gantt task done 2026-11-15. Still wanted: a photo.
- [ ] ⭐ Two motion methods (motion sensor + picture changed): which one uses less energy? A test result, even a simple one.
- [x] ⭐ Sensor facts fixed in the talk (about 15 ft; a picture every second). Done 2026-11-15.
- [x] ⭐ Sharing: Thea's older brother and the ADOT district contact added to Communication (4 people/groups). Done 2026-11-15. Still wanted: their dates.
- [x] ⭐ ADOT: Northcentral District Administrator, paperwork in hand; entry + Gantt task done 2026-11-15. Still wanted: the date.
- [ ] ⭐ Pi → tiny camera switch: write it as a decision with the reason (energy, smaller solar panel) in `DECISIONS.md` and the improvement trail.
- [ ] ⭐ Next steps on the Gantt: proper case / 3D-printed box, put the camera on the bridge.
- [ ] Gantt: the 2 "(suggested)" tasks (test camera + Pi, practice presentation) still have guessed dates. Make them real or delete them.
- [ ] 8-Step Progress still says step 3 (Research), set Oct 12. Move it to where the team really is (about step 7–8).
- [ ] Project Photos has only 2 photos (soldering). Add solar panels, breadboard, the Nov 9 first full run, the Pi touchscreen, the trifold.
- [ ] Research row 9 (ResearchGate paper) is blank: what did Nolan learn? And what day did Nolan do the research?
- [ ] Trifold boards (Nov 8): which boards, what's on them, a photo.
- [ ] Thank-you note to Nate (planned Oct 5): sent? (Core Values evidence.)

### Robot Design
- [ ] ⭐ Tradeoff "Which drive tires?": still "(students: which tires did you compare?)". Add the 8 wheels and why.
- [ ] ⭐ Tradeoff "Three copies": "why" is still blank. Add "test three attachments at once + a spare" and the no-gears build-and-test robot (could be its own tradeoff).
- [ ] Tradeoff "One attachment for Missions 2 + 3 or two?": still "Not decided yet". The combined one won: say why.
- [ ] Main Robot specs still say "— fill in" / "— measure it!" for Size, Motors, Wire management, How attachments attach.
- [ ] ⭐ (Fynn's Nov 9 + Nov 13 fine-tuning is logged ✓.) Attachment rebuilds said in the talks aren't in Attachments Over Time: the 2+3 rebuild (lines up with the base, lower grabber) and the Research Platform (8 + 9) motorized lifter → passive push. Date, who, why, before/after photo.
- [x] ⭐ Weston's lift-it-back-to-base attachment is **Mission 14** (typo in the talk, fixed 2026-11-15). Still: retake the M14 photo if Fynn's Nov 9 fine-tuning changed it.
- [ ] Attachment photos missing: M01, M02, M03, M06, M07, M11, M13 (mascot). Since every attachment is now in its final form (Nov 13), a fresh photo of each would be ideal.
- [ ] ⭐ Test Sessions has only 3 rows. Add the Nov 8 tests (every mission) and every try since. Fynn says "tested over and over": the app should show it.

### Robot Game
- [x] ⭐ Mission statuses: all 15 now **Working** (Fynn's Nov 9 testing). Done 2026-11-15.
- [ ] Reliability is still 0% for 9 missions: count tries and successes.
- [ ] Run Plan: runs 2, 4, 5 and 7 still have guessed times, and **no full timed run of the whole board yet**. Do one.
- [ ] **Score History is empty**: 0 practice matches logged all season. At least log full practice runs and the Nov 14 tournament scores.
- [x] Countdown now points to Regionals, **Nov 21** (fixed 2026-11-15). After the tournament: log the result.

### Coding
- [ ] ⭐ The clever parts Fynn describes (gyro, wall squaring + gyro reset, auto-next-mission, two motors at once) aren't in "Programs We've Written". Every program still says "Sensors: —" and several say "fill in what's clever". The gyro is a sensor: list it.
- [ ] ⭐ Fynn's final run-through of all the code: entry + who-coded-what.
- [ ] Programs missing for M06, M07, M08, M10 in "Programs We've Written" (check the `code/` folder and add them).
- [ ] Mission Inventory: "coded by" is empty for all 15 missions (the names are only in the Programs table). Fill it in so the Dashboard balance is right.

### Core Values
- [ ] Only 7 moments all season, the last on Nov 8. Add the tournament, the Nov 9 first full run, and "we found our strengths" (Nolan).
- [ ] Proudest Moment quotes stop at Sep 25. Add Nov milestones (camera system works, every mission has an attachment).
- [ ] Team mascot has no name.

### Notebook-wide
- [ ] Clean up open tags in the markdown: about **120 `[unclear: …]`** and **50 `[who?]`**. Biggest piles: `PRACTICE-LOG.md` (50 unclear), `ROBOT-DESIGN.md` (19), `ROBOT-GAME.md` (17), `CAMERA-BUILD.md` (11 + 9 who?).
- [ ] Core Values notebook entries: only 2 of 58 entries are tagged Core Values.
- [ ] Rubric Check self-ratings were last set before the talks. Re-rate after the tournament (e.g. Code/sensors is still 1; Project plan, Model/drawing and Improvements are still 2).
- [ ] Log the tournament itself: date, who went, scores, judges' feedback.

### Not documentation, but still open (PROGRESS.md)
- Photo upload from the app isn't built yet (photos are added by hand).
- The app runs only on the laptop (no internet, no PIN yet): Phase 4–5 for CJ.
