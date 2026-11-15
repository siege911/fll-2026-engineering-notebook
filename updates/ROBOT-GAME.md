# Robot Game — running notes

Dated facts about missions and matches: which missions are being attempted, attachment per mission, who built / who programmed, test runs (successes out of attempts), practice match scores, run-plan order and timing against the 150-second match. **Newest at top.**

Use official mission numbers and names from `../06-missions-bioglow.md`; log any nickname in that file's alias log. Feeds the app's Robot Game page (inventory, run plan, score chart, reliability).

Backfilled 2026-09-06 from `../DECISIONS.md` and `../PROGRESS.md`.

---

## 2026-11-15 — The hub menu follows the run plan (Final v2 code)
- The new mission menu (Adeline, tested Nov 9) has 9 slots, the same order as our 9 runs: 1 M01 · 2 M02 + M03 · 3 M04 + M05 · 4 M08 + M09 · 5 M14 · 6 M12 part 1 (support tie) · 7 M15 · 8 M13 + M12 part 2 (cane) · 9 M06 + M07 + M11.
- After a run finishes the hub shows the next number (orange light): press RIGHT or CENTER to go. CENTER during a run stops it and stays on that number to retry.
- [unclear: run 5 in the run plan is M10 + M14, but the menu's slot 5 is `mission14.py` only. Is M10 scored by the M14 program?]
- Fynn added to "Coded by" on M01, M02, M03, M06, M07, M08, M09, M11, M12, M13, M15 (Fynn fine-tuned every mission, Nov 9 + Nov 13). Told by Coach CJ.

## 2026-11-09 → 11-13 — every mission working; no full timed run yet
- **Nov 9 (Mon):** Fynn fine-tuned M06, M07, M14 and some of M02 + M03; **the rest were tested and worked well** (Coach CJ, from memory). **Nov 13 (Fri):** Fynn finished M02 + M03 and worked on M08 + M09.
- So every mission is now **Working** in the app (was Prototyping: M01, M06, M07, M09, M10, M11, M12, M15). Reliability % not changed: no tries / successes were counted.
- **Still to do: a full timed run-through of the whole board** (all nine runs back to back). Runs 2, 4, 5 and 7 still have guessed times.

## 2026-11-08 (Sunday) — every mission tested and timed (Fynn + Isla)
- **Fynn and Isla** tested all of the missions and timed them (notes: `PRACTICE-LOG.md` 2026-11-08, photo `../app/images/11-8-mission-timing-notes.webp`).
- **Timed:** M01 = **12 s** · M04 + M05 = **17 s** · M12 = **7 s** · M13 + M12 = **17 s** · M06 + M07 + M11 = **17 s**.
- **Not timed yet:** M02 + M03 "needs help" · M08 + M09 "needs work" · M10 + M14 "needs work" · M15 "fix yellow arm".
- **Run groups (as written, top to bottom):** 1 M01 · 2 M02+M03 · 3 M04+M05 · 4 M08+M09 · 5 M10+M14 · 6 M12 · 7 M15 · 8 M13+M12 · 9 M06+M07+M11. The app's run plan now follows these 9 runs (was 8 guessed runs). Untimed runs keep the old 30 s guess (35 s for M02+M03) and are marked "guess." [unclear: match order or test order?]
- **M12 Forest Elder is split across two runs** (answered 2026-11-09): "Mission 12 has two parts and we do one part by itself and the second as part of mission 13." Run 6 = M12 part 1 alone: **support tie around the post, 10 pts** (7 s); run 8 = M13 + M12 part 2: **cane raised, touching the tree, 20 pts** (17 s).
- **M10 Fragile Microhabitats:** first time in testing, run with M14 → status **Prototyping** (was Not started).
- **M06 + M07** run with M11 and got a time, so they have programs now. [unclear: who programmed them?]
- No tries / successes written down → reliability unchanged.

---

## 2026-11-01 (Sunday) — attachments for every mission; only M06 + M07 left to program (told by Adeline)
- **Team milestone:** "we have an attachment for all the missions, the only thing left to program is mission 6 and 7." [unclear: the app has no attachment or program for **M10** and no attachment for **M05**; ask]
- **M04 Lucky Leaves + M05 Reaching Roots:** **Adeline** finished them. **Test: 4 / 5 (80%)**, "pretty consistent." Both → **Working**, reliability 80%. Programmed by now: M04 Adeline, Fynn, Isla · M05 Fynn, Isla, Adeline.
- **M08 Tangled:** **Adeline + Fynn** worked on it, "mostly finished" → **Working**. [unclear: who programmed it?]
- **M09 Research Platform:** **Adeline + Fynn** worked on it. Platform + camera trap mostly done; **the seed is still left** → stays **Prototyping**.
- **M11 Window to the Past:** first program, **Weston + Nolan**.
- **M06 Leafcutter Frenzy + M07 Humongous Fungus:** **Weston + Nolan** worked on them; not programmed yet.

---

## 2026-10-26 (Monday) — typed into the app (copied here Nov 1)
- **M06 Leafcutter Frenzy + M07 Humongous Fungus:** first attachments, built by **Nolan** → status **Prototyping** (was Not started).
- **M11 Window to the Past:** **Nolan** built an attachment [unclear: rebuild of Weston's Oct 12 one, or new?]. Built by now Weston, Nolan.
- **M09 Research Platform:** **Weston** programmed it again, **Fynn** helped.
- **M04 Lucky Leaves + M05 Reaching Roots:** programmed by **Isla**.
- No tries / successes counted.

---

## 2026-10-23 (Friday) — M09 started, M13 programmed
- **M09 Research Platform** ("the big tree mission"): first attachment **and** first program, both by **Weston** → status **Prototyping** (was Not started).
- **M13 Keystone Species** ("the mascot mission"): first program, by **Isla**. Programmed by now Isla.
- No tries / successes counted today.

---

## 2026-10-12 (Monday) — M11 started, M12/M13 rebuilt, M04 + M05 programmed
- **M11 Window to the Past:** first attachment, built by **Weston** → status **Prototyping** (was Not started).
- **M12 Forest Elder:** attachment **rebuilt (v2) by Adeline**; Adeline programmed it again. Built by now Fynn, Isla, Adeline.
- **M13 Keystone Species:** attachment **rebuilt by Nolan**. Built by now Thea, Nolan.
- **M04 Lucky Leaves:** programmed by **Fynn** (Isla helped). Programmed by now Adeline, Fynn.
- **M05 Reaching Roots:** first program, **Fynn** (Isla helped) → status **Prototyping** (was Not started). No attachment recorded.
- No tries / successes counted today.

---

## 2026-10-09 — Typed into the app (Thea)

- **M01 Drone Survey:** difficulty was briefly set to 2 of 5, then Thea cleared it the same day ("turn the Diff back to tap to fill in"). **Not rated yet.**
- **M01 Drone Survey:** reliability changed from **19% → 0%**. Thea confirmed: "keep the 0%."

---

## Mission inventory (as of 2026-10-02)

| Official mission | We say | Attachment | Built by | Programmed by | Status |
|---|---|---|---|---|---|
| M01 Drone Survey | Drone Survey | Drone Survey attachment | Isla | Adeline (Sep 11) | ✅ built (Aug 31) · program written (Sep 11), not run/counted yet |
| M02 Exploding Seeds | "Mission 2," "number 2," "2" | M02-only attachment (Adeline) · **Nolan's "number 2" attachment (built Sep 19)** [unclear: the combined 2+3 finished, or a separate one?] | Adeline (Sep 4) · **Nolan** (Sep 19) | **Nolan** (Oct 2) | ✅ built (Sep 19, Nolan) · **programmed + tested Oct 2: 5/5 (100%) — Working** |
| M02 + M03 | "Missions 2 + 3" | Combined attachment for both | Nolan | [not recorded] | 🟡 worked on (Sep 4) — [unclear: is this the Sep 19 "number 2" build?] |
| M03 Flip the Rock | Flip the Rock, "Mission 3" | Flip the Rock attachment | Nolan | **Nolan** (Oct 2) | 🟡 in progress (Aug 31) · **programmed + tested with M02 Oct 2: 5/5 (100%) — Working** |
| M04 Lucky Leaves | Lucky Leaves, "mission 4" | Lucky Leaves attachment | Fynn | **Adeline** (Sep 19) | ✅ built (Aug 31) · **program written (Sep 19)**, not run/counted yet |
| M08 Tangled | "number 8" | M08 attachment | **Nolan** | [not recorded] | 🟡 **worked on (Sep 19)** |
| M12 Forest Elder | "Mission 12," "the forest elder" | M12 attachment | Fynn (created Sep 4) · Isla (finished Sep 11) | Isla (Sep 11) · Fynn (Sep 19) · Thea (Sep 25) · **Adeline (finished Oct 2)** | ✅ finished (Sep 11) · **program finished (Oct 2)**, not run/counted yet |
| M13 Keystone Species | "the mascot mission," Keystone Species | Mascot / Keystone Species attachment — carries the team mascot | Thea | [not recorded] | ✅ v1 built (Sep 11) · **finished (Sep 19)** |
| M14 Seeds of Renewal | "number 14," "mission 14" | M14 attachment | Weston | **Fynn** (Sep 25; programmed again Oct 2) | ✅ built (Sep 19) · program written (Sep 25) · **tested Oct 2: 5/5 (100%) — Working** |
| M15 Biocentric Architecture | "mission 15" | M15 attachment | Isla (Sep 19; built again/finished Sep 25 [unclear]) | Isla (Sep 25) · **Adeline (finished Oct 2)** | ✅ built · **program finished (Oct 2)**, not run/counted yet |
| "the tree mission" [unclear: M08, M09, or M12?] | "the tree mission" | attachments (plural) | **Weston** (worked on, Oct 2) | — | 🟡 worked on (Oct 2) |
| All other missions (M05, M06, M07, M09, M10, M11) | — | — | — | — | ⬜ not started |

**Progress:** attachments started for **9 of 15** missions (M01, M02, M03, M04, M08, M12, M13, M14, M15), worth **280 of the 440** mission points on the field. **Mission programs written: 5 missions** — M01 Drone Survey (Adeline, Sep 11), M04 Lucky Leaves (Adeline, Sep 19), M12 Forest Elder (Isla Sep 11, Fynn Sep 19, Thea Sep 25), M14 Seeds of Renewal (Fynn, Sep 25), M15 Biocentric Architecture (Isla, Sep 25); none run and counted yet. Field max incl. Equipment Inspection (20) and Precision Tokens (up to 50) = **510** (per the built models; the rulebook picture-count gives 500).

**Base program:** Adeline's program template for the robot base (Sep 4) is the starting point for every mission program.

## Run plan
DRAFT only (in app v3): built from the attachments in progress, every time slot is a 30-second guess. No measured run times yet. **Sep 11:** run 5 (M13 Keystone Species) added → five guesses = **155 s, over the 150 s match**. **Sep 19:** runs 6 (M14), 7 (M15), 8 (M08) added → **8 runs ≈ 245 s**, far over 150 s. The team will need to combine missions into shared runs — M13, M14, M15 all use the interchangeable dock area, so they are a natural group. Time a real run before trusting the plan.

## Practice match scores
None logged yet. The app's score chart shows "log your first one." Log here as: date, score, what worked, what failed, what we changed.

## Test runs / reliability
Log here as: date, mission, attempts, successes, who ran it, notes.

| Date | Mission | Tries | Successes | Who | Notes |
|---|---|---|---|---|---|
| 2026-10-02 | M02 Exploding Seeds + M03 Flip the Rock | 5 | 5 (100%) | Nolan | Nolan programmed 2 and 3 the same day. [unclear: one run doing both, or 5/5 each?] |
| 2026-10-02 | M14 Seeds of Renewal | 5 | 5 (100%) | Fynn | **First test session of the season.** Fynn programmed M14 the same day. [unclear: points scored per try; run time] |

---

## 2026-09-25 (Friday) — Two more missions programmed (Thea, Isla, Fynn there; Nolan, Weston, Adeline away)
- **Thea programmed M12 Forest Elder** ("mission 12") — her first mission program. M12 coders: Isla (Sep 11), Fynn (Sep 19), Thea (Sep 25) [unclear: same program improved, or versions?].
- **Isla built and programmed the M15 Biocentric Architecture attachment** ("mission 15") — she built an M15 attachment Sep 19 [unclear: finished/rebuilt today, or the same build?]. First M15 program.
- **Fynn programmed M14 Seeds of Renewal** ("mission 14") — attachment built by Weston Sep 19.
- Totals: 9 of 15 missions have an attachment (280 of 440 pts); **5 missions have a program** (M01, M04, M12, M14, M15). Still **no test runs counted**.
- Aliases logged in `../06-missions-bioglow.md`: "mission 12," "mission 14."

## 2026-09-19 (Saturday) — Three new missions get attachments; third mission programmed
- **Thea finished** the **M13 Keystone Species attachment** (v1 built Sep 11). The team called it by its official name this time.
- **Isla built** an attachment for **M15 Biocentric Architecture** ("mission 15") — new mission, 40 pts, the biggest on the field.
- **Nolan built** the attachment for **M02 Exploding Seeds** ("number 2") — [unclear: his combined 2+3 attachment from Sep 4 finished, or a separate M02-only build? Adeline also has an M02 attachment from Sep 4 — the Mission 2 tradeoff is still open.] Nolan also **worked on M08 Tangled** ("number 8") — new mission.
- **Weston built** the attachment for **M14 Seeds of Renewal** ("number 14") — new mission; Weston's first attachment after finishing the robot base.
- **Fynn programmed M12 Forest Elder** ("the forest elder") — Isla also wrote an M12 program Sep 11 [unclear: same program improved, or a second one?].
- **Adeline programmed M04 Lucky Leaves** ("mission 4") — attachment by Fynn (Aug 31). Adeline's second mission program.
- Totals: 9 of 15 missions have an attachment started (280 of 440 pts); 3 missions have a program. Still **no test runs counted** for any mission — that is the next thing to log.
- Draft run plan grew to 8 runs ≈ 245 s. Way over. Which missions share a run?
- Aliases logged in `../06-missions-bioglow.md`: "mission 4," "mission 15," "number 2," "number 8," "number 14," "the forest elder."

## 2026-09-11 — Mascot mission attachment; first two mission programs
- **Thea** built the **team mascot** and an **attachment for "the mascot mission"** → matched to **M13 Keystone Species** (the robot places a team-built keystone species on the restoration platform; the mascot is that piece). **[confirm with CJ]** Alias logged in `../06-missions-bioglow.md`.
- **Adeline** wrote the **program for M01 Drone Survey** (attachment built by Isla, Aug 31).
- **Isla** finished the **M12 Forest Elder attachment** and wrote its **program**. Fynn created an M12 attachment Sep 4 — [unclear: same attachment finished, or a second build?]
- First mission programs of the season. Not yet run and counted — the first test session (tries / successes) is the next thing to log.
- Draft run plan now has 5 runs (M13 added as run 5); five 30 s guesses = 155 s, over the 150 s match. Time a real run.
- Date: [unclear: the update said "august 11". Today is Sept 11 and the work fits September (robot base finished Sep 6; Forest Elder attachment started Sep 4). Logged as 2026-09-11 until a student or CJ confirms.]

## 2026-09-06 — Official mission list loaded (CJ)
- Source: FLL Challenge BIOGLOW Robot Game Rulebook (`../../fll-challenge-bioglow-rgr.pdf`, pp. 5, 8–12) → `../06-missions-bioglow.md`: 15 missions with numbers, names, bag numbers, scoring conditions, bonuses, max points, 🚫 no-equipment flag, Equipment Inspection (20), Precision Tokens (up to 50). Everything on the field = 500 max by rulebook.
- **Piece counts confirmed from the built models:** 3 seeds (M02), **4** leaf fragments (M06 — rulebook picture shows 3, so M06 max 40), 3 seeds (M14). Field total 440 mission pts, 510 with inspection + precision tokens.
- **Alias convention set:** "Mission 2" → M02 Exploding Seeds · "Mission 3" → M03 Flip the Rock · "Mission 12" → M12 Forest Elder. Drone Survey / Lucky Leaves / Flip the Rock used as-is. Log new nicknames in `../06-missions-bioglow.md`.
- CJ confirmed the Sept 4 "Mission 2/3/12" references are official numbers.
- For CJ (architecture): mission list is static season data — seed table candidate.

## 2026-09-04 — Three more mission attachments started
- **Adeline** worked on the M02 Exploding Seeds attachment.
- **Nolan** worked on **combining M02 + M03 into one attachment**.
- **Fynn** created the M12 Forest Elder attachment.
- Open: two approaches to M02 (Adeline's vs Nolan's combined). Which one, and why? → tradeoff row in `ROBOT-DESIGN.md`.

## 2026-08-31 — First attachments built
- **Isla** built the M01 Drone Survey attachment. ✅
- **Fynn** built the M04 Lucky Leaves attachment. ✅
- **Nolan** started the M03 Flip the Rock attachment (in progress).
