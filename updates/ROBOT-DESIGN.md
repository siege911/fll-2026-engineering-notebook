# Robot Design — running notes

Dated facts about the robot: base/chassis, attachments' mechanical side, motors, sensors, wiring, size, code, and test sessions (observation → change → result). **Newest at top.** Always say who did it.

Feeds the app's Robot Design page. Decisions with a "why" also go in `../DECISIONS.md`. Attachment-per-mission progress and test-run counts live in `ROBOT-GAME.md`.

Backfilled 2026-09-06 from `../DECISIONS.md` and `../PROGRESS.md`.

---

## 2026-11-15 — Robot code: mission menu (Adeline) + fine-tuning (Fynn) = Final v2
- **Nov 3:** all programs saved as Final v1. **Adeline** built the mission menu (`main_base.py`) and `robot.py` (ports + wheels set up once; every mission file now has a `run()`). Tested **Nov 9**.
- **Nov 9 + Nov 13:** **Fynn** fine-tuned the code for all the missions, saved in **Final v2** with the menu (the latest code on the hub, backed up Nov 15) (new M02 + M03 path, smaller M15 arm moves, M01 distances, fixed two bugs in the M06 + M07 ending).
- Programs joined to match the 9 runs: `mission4_5`, `mission8_9`, `mission6_7_11`, `mission12a`, `mission13_12b`. Details and history: `ROBOT-CODE.md` 2026-11-15. Told by Coach CJ.

---

**Code:** the history of every robot program (which practice it changed, what changed) is in `ROBOT-CODE.md`, from the `../code/` folder (added 2026-11-02).

## Robot specs (current, as of 2026-09-06)

| Spec | Value | Since | Decided by |
|---|---|---|---|
| Shape | Low and wide | Sep 6 (wide since week of Aug 24) | students |
| Structure | Reinforced with bracing for rigidity | Sep 6 | students |
| Drive tires | 49.5 × 20 mm | Aug 28 | students |
| Wheelbase | Wide | week of Aug 24 | students |
| Sensors | None (color sensors considered, no room) | Sep 6 | students |
| Accuracy vs speed | Leans accuracy (wide base → accurate turns; no sensors → navigation by wheel rotations and turns) | Sep 6 | students |
| Size (width × depth) | [not measured yet] | | |
| Motors | [not recorded yet] | | |
| Wire management | [not recorded yet] | | |
| How attachments attach | [not recorded yet] | | |

## Tradeoff decisions (what the judges' DESIGN row wants)

| Date | Question | Options weighed | Pick | Why |
|---|---|---|---|---|
| Sep 6 | Low or tall base? | low / tall | **Low** | Low center of gravity, less likely to tip |
| Sep 6 (choice made week of Aug 24) | Wide or narrow wheelbase? | wide / narrow | **Wide** | More accurate turning. Accepted cost: harder to move in tight spaces on the field |
| Sep 6 | Reinforce the base or keep it light? | reinforced / light | **Reinforced** | Bracing makes the base more rigid |
| Sep 6 | Color sensors or none? | color sensors / none | **None** | Base is so compact there was no room for a sensor. Accepted cost: no line/color detection; navigate by wheel rotations and turns |
| Sep 6 | One robot base, or three identical copies? | one / three | **Three** | [students to fill in — nudge next session] |
| Aug 28 | Which drive tires? | [unclear: alternatives] | **49.5 × 20 mm** | [not recorded — ask] |
| Sep 4 → open | Which Mission 2 attachment: Adeline's M02-only, or Nolan's combined M02+M03? | two builds | [not decided] | — |

---

## 2026-11-13 (Friday) — Fynn finished the 2 + 3 attachment, worked on 8 + 9
- **Fynn** finished fine-tuning the **combined 2 + 3 attachment** (M02 + M03) and worked on the **8 + 9 attachment** (M08 + M09). Told by Coach CJ from memory (Nov 15).
- Coach CJ: after Nov 9 and Nov 13, **every attachment should be in its final form.**
- The judging talk says the 2 + 3 attachment was rebuilt to line up with the base and lower the grabber, and the Research Platform (8 + 9) went from a motorized lifter to a passive push. [unclear: were those changes these fine-tuning days, or earlier?]

## 2026-11-09 (Monday) — Fynn fine-tuned the attachments for M06, M07, M14 (+ some 2 + 3)
- **Fynn** fine-tuned the attachments for **M06 Leafcutter Frenzy, M07 Humongous Fungus, M14 Seeds of Renewal** and a little of the **2 + 3** attachment. Every other attachment was tested and worked well. Told by Coach CJ from memory (Nov 15). [unclear: tries / successes]

## 2026-11-08 (Sunday) — Testing every mission: what needs work (Fynn + Isla)
- Observation from testing all missions: **M15 Biocentric Architecture — "fix yellow arm."** [unclear: what is the yellow arm doing wrong?] Also marked "needs work": M08+M09 and M10+M14; "needs help": M02+M03. Times and the full list: `ROBOT-GAME.md` 2026-11-08.

---

## 2026-11-02 (Monday) — Photos of the attachments with their missions
**Sent by:** [who?] · "these are the photos of the attachments with the missions. put these in the app" · mission for each photo confirmed by the student who sent them. [unclear: taken Nov 1 or Nov 2?]

| Photo (in `../app/images/`) | Mission | Attachment in the app | What it shows |
|---|---|---|---|
| `11-2-mission-15.jpg` | M15 Biocentric Architecture | Mission 15 attachment | Long gray beam reaching up the green building, robot against the wall |
| `11-2-mission-12.jpg` | M12 Forest Elder | Mission 12 attachment | Rack of red and gray pegs + long arm, aimed at the tree with the red support tie |
| `11-2-mission-14.jpg` | M14 Seeds of Renewal | Mission 14 attachment | Next to the brown replantation station: two red poles with yellow tips, long black pole |
| `11-2-mission-8-9.jpg` | M08 Tangled + M09 Research Platform | Mission 8 attachment, Mission 9 attachment | Under the big tree with the research platform; one attachment does both |
| `11-2-mission-2-3.jpg` | M02 Exploding Seeds + M03 Flip the Rock | Combined 2 + 3 attachment | Gray arms reaching the rock, launched from home by the FIRST LEGO League logo |
| `11-2-mission-4.jpg` | M04 Lucky Leaves | Lucky Leaves attachment | Three gray prongs, leaves with brown loops pulled out of the nest |

New facts: **one attachment does both M08 and M09.** The photo for M02 + M03 shows the **combined** attachment is the one in use (helps answer the open Sep 4 question "Adeline's M02-only or Nolan's combined?" [unclear: decided for good?]).

## 2026-11-01 (Sunday) — M04 + M05 finished 4/5; first M11 program; M08 + M09 almost done (told by Adeline)
- **Adeline finished M04 Lucky Leaves and M05 Reaching Roots: 4 / 5 runs worked (80%)**, "pretty consistent."
- **Weston + Nolan programmed M11 Window to the Past** (first M11 program) and worked on the M06 and M07 attachments.
- **Adeline + Fynn worked on M08 Tangled and M09 Research Platform:** "mostly finished besides the seed" (the M09 seed is the part left).
- Team says **every mission now has an attachment**. [unclear: none recorded for M05 or M10]

## 2026-10-26 (Monday) — typed into the app (copied here Nov 1)
- **Nolan built attachments for M06, M07 and M11.** First M06 and M07 attachments. [unclear: M11 rebuild or new?]
- **Weston programmed M09** (Fynn helped). **Isla programmed M04 + M05.**

## 2026-10-23 (Friday) — M13 programmed; first M09 attachment + program
- **Isla programmed M13 Keystone Species** ("the mascot mission"). First M13 program.
- **Weston built the first M09 Research Platform attachment and programmed M09** ("the big tree mission", confirmed M09 by Thea).
- Adeline and Fynn were not there. No test counts given.

## 2026-10-12 (Monday) — Two rebuilds (M12, M13), first M11 attachment, M04 + M05 programs
- **Adeline rebuilt the M12 Forest Elder attachment** (v2; Fynn created it Sep 4, Isla finished it Sep 11) **and programmed M12.** [unclear: what changed and why?]
- **Nolan rebuilt the M13 Keystone Species attachment** (Thea built and finished it Sep 11 / Sep 19). [unclear: what changed and why?]
- **Weston built the first M11 Window to the Past attachment.**
- **Fynn programmed M04 Lucky Leaves and M05 Reaching Roots; Isla helped.** Coding table: M04 → Adeline (Sep 19) + Fynn (Oct 12); new M05 program → Fynn (Isla helped).
- No test counts given.

## 2026-10-02 (Friday) — Adeline finishes M12 + M15 programs; Nolan's first program (M02 + M03) tests 5/5; Weston on "the tree mission"
- **Adeline finished programming M15 Biocentric Architecture and M12 Forest Elder.**
- **Nolan programmed M02 + M03** (his combined 2 + 3 attachment) and tested it: **5/5**. [unclear: one run doing both missions?]
- **Weston worked on building the attachments for "the tree mission"** [unclear: M08 Tangled, M09 Research Platform, or M12 Forest Elder?].

## 2026-10-02 (Friday) — First test session: M14 5/5 (Fynn)
- **Fynn programmed M14 Seeds of Renewal** (Weston's attachment, Sep 19) and tested it: **5 successes out of 5 tries**. First counted test of the season. [unclear: what changed in the program since Sep 25?]

 — Three programs in one practice (Thea, Isla, Fynn)
- **Thea** programmed **M12 Forest Elder** ("mission 12"). Coding table: M12 program → Isla (Sep 11) + Fynn (Sep 19) + Thea (Sep 25) [unclear: one program improved, or versions?]. Thea's first mission program — she had been building (base copies, mascot, Keystone Species attachment).
- **Isla** built and programmed the **M15 Biocentric Architecture attachment** ("mission 15"). Coding table: M15 program → Isla. [unclear: did the attachment change since her Sep 19 build?] Isla has now built and coded both M12 (finished it) and M15.
- **Fynn** programmed **M14 Seeds of Renewal** ("mission 14"). Coding table: M14 program → Fynn. (Attachment: Weston, Sep 19.) Fynn: M04 attachment, M12 attachment + program, M14 program.
- Not there: Nolan, Weston, Adeline.
- Coders so far: Adeline (template, M01, M04), Isla (M12, M15), Fynn (M12, M14), Thea (M12). Four of six teammates have written a mission program — evidence for "skills in all members."
- **Still no test sessions.** Five missions now have both an attachment and a program.

## 2026-09-19 (Saturday) — Biggest build day yet: 3 new attachments, Keystone Species finished, 2 more programs
- **Thea** finished the **M13 Keystone Species attachment** (the one that carries the team mascot; v1 built Sep 11).
- **Isla** built an attachment for **M15 Biocentric Architecture** ("mission 15").
- **Nolan** built the attachment for **M02 Exploding Seeds** ("number 2") [unclear: the combined 2+3 build finished, or a separate M02-only one?] and **worked on** an attachment for **M08 Tangled** ("number 8").
- **Weston** built the attachment for **M14 Seeds of Renewal** ("number 14") — his first attachment; he had been on the robot base through Sep 6.
- **Fynn** programmed **M12 Forest Elder** ("the forest elder"). Coding table: M12 program → Isla (Sep 11) + Fynn (Sep 19) [unclear: same program improved, or a second version?]. Fynn created the M12 attachment Sep 4, so he has now both built and coded for that mission.
- **Adeline** programmed **M04 Lucky Leaves** ("mission 4"). Coding table: M04 program → Adeline. (Attachment: Fynn, Aug 31.) Adeline: base template + M01 + M04.
- Robot Design DESIGN row, "all team members contributed": all six students credited with a build or a program on the same day — strongest evidence of this so far.
- **Still no test sessions.** Three missions now have both an attachment and a program (M01, M04, M12) — any one of them can be run and counted next practice.
- Tradeoff still open: Mission 2 — Adeline's attachment vs Nolan's. Nolan's Sep 19 build may have decided it; ask.

## 2026-09-11 — Mascot + M13 attachment; Forest Elder finished; first mission programs
- **Thea** built the **team mascot** and an **attachment for "the mascot mission"** (M13 Keystone Species — [confirm with CJ]). The mascot is the team-built keystone species the robot delivers, so it is both team identity and a 30-point mission piece.
- **Isla** finished the **M12 Forest Elder attachment** ([unclear: Fynn's Sep 4 build finished, or a second build?]) and **wrote its program**. Coding table: M12 program → Isla.
- **Adeline** **wrote the M01 Drone Survey program**. Coding table: M01 program → Adeline. (Attachment: Isla, Aug 31.)
- First mission programs of the season, both built on Adeline's Sep 4 base template. Not run and counted yet — log the first test session (tries / successes / what we saw / what we changed) next.
- Date: [unclear: the update said "august 11". Today is Sept 11 and the work fits September (robot base finished Sep 6; Forest Elder attachment started Sep 4). Logged as 2026-09-11 until a student or CJ confirms.]

## 2026-09-06 — Base design finished; three identical copies built
- **Who:** Thea, Nolan, Weston.
- The robot base (drive chassis every attachment mounts to) went from "Weston is building it" (Sep 4) to a finished, repeatable design. **Three identical copies** built.
- Why it matters: three attachments can be tested at the same time, and there's a spare if one breaks at a tournament. Robot Design **CREATE** evidence; sets up **ITERATE** (test sessions).
- Base decisions dictated the same day (students via CJ): low + wide, reinforced, no sensors. See tradeoff table above.
- **Open:** why three copies (their words); measure size; record motors and how attachments attach.

## 2026-09-04 — Base building continues; program template
- **Weston** continued building the robot base.
- **Adeline** created the **initial program template for the robot base** — the starting point every mission program will be built from. (Coding table: who coded it = Adeline.)
- Attachment builds that day (Adeline M02, Nolan M02+M03 combined, Fynn M12) are in `ROBOT-GAME.md`.

## 2026-08-28 — Drive tires chosen
- **49.5 × 20 mm tires** for the drive wheels. [unclear: who chose, alternatives, reason]

## Week of 2026-08-24 — Wide wheelbase; first base built
- Decision: **wide wheel base**. (Reason recorded Sep 6: more accurate turning; tradeoff = tight spaces.)
- Milestone: the team **built the base robot** (first version of the chassis).

## Test sessions (observation → change → result)
Each test: date, attachment/mission, runs attempted, runs succeeded, what was observed, what was changed, result. Newest at top.

| Date | Attachment / mission | Result | What we saw | What we changed | Who |
|---|---|---|---|---|---|
| Nov 1 | M04 Lucky Leaves + M05 Reaching Roots | **4 / 5 (80%)** | "pretty consistent" [unclear: what went wrong on the miss?] | — | Adeline |
| Oct 2 | Combined 2 + 3 (M02 + M03) | 5 / 5 (100%) | Nolan programmed and tested | — | Nolan |
| Oct 2 | Mission 14 attachment (M14) | 5 / 5 (100%) | First test session of the season | — | Fynn |
