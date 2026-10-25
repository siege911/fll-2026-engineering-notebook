# Robot Design — running notes

Dated facts about the robot: base/chassis, attachments' mechanical side, motors, sensors, wiring, size, code, and test sessions (observation → change → result). **Newest at top.** Always say who did it.

Feeds the app's Robot Design page. Decisions with a "why" also go in `../DECISIONS.md`. Attachment-per-mission progress and test-run counts live in `ROBOT-GAME.md`.

Backfilled 2026-09-06 from `../DECISIONS.md` and `../PROGRESS.md`.

---

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
None logged yet. The app's test-session card shows "log your first one." First real test data should go here with: date, attachment/mission, runs attempted, runs succeeded, what was observed, what was changed, result.
