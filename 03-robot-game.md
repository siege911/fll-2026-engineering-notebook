# Robot Game — Strategy & Mission Tracking

**Goal:** the *students* specify the mission strategy, we document it, and we track exactly who built and programmed what. The strategy decided here drives the robot design (see `02-robot-design.md` Phase 1 — the rubric scores "clear evidence of mission strategy").

A match is **2 minutes 30 seconds**. Every strategy question below is really a question about how to spend those 150 seconds.

---

## Strategy Decisions (students decide, we record)

Run these as team discussions with a recorded decision and reasoning — same spirit as the robot design tradeoff worksheets.

### 1. Run structure: quick back-and-forth vs. long multi-mission runs

- **Many short runs:** simpler programs, easier to recover from failure, but every return to home + relaunch costs ~10–20 seconds.
- **Few long runs:** more points per launch, less overhead, but one early failure can kill the whole run.
- Most strong teams land at 4–6 runs. Decide, then measure actual launch-to-return times to validate.

### 2. Board geography: which side/zone first?

- Sequence runs to minimize total travel and risky crossings.
- Consider: missions near home first (low travel cost)? Cluster runs by board region?
- Does any mission *change the board state* in a way that helps or blocks a later mission? Order matters.

### 3. Prioritization: easiest-first vs. most-points-first

- Score every mission on **points / difficulty / travel time / reliability**.
- A useful metric for the students: **expected points per second** = (points × current reliability %) ÷ run time.
- Easy+reliable missions build the floor; decide together how much time to gamble on the high-point hard ones.
- Revisit after every scrimmage — reliability numbers change the math.

### 4. Dividing missions among the team

- Every student owns something: an attachment, a program, a launch slot in the match.
- During the match: who are the two drive-team members at the table? Do they rotate between matches? Who handles attachment swaps?
- Ownership feeds the rubric's "all team members" rows and the Core Values spotlight.

### 5. Other strategy questions worth deciding

- **Precision missions vs. push missions:** does a mission need a fancy mechanism or just a reliable shove?
- **Attachment swap time:** budget it. Quick-swap design (from robot design decisions) buys mission time.
- **Leave-in-place equipment:** some missions allow leaving elements; does abandoning an attachment ever win us time?
- **Failure protocol:** if a run goes wrong, do we rescue the robot (penalty/restart rules) or let it finish? Decide *before* the tournament.
- **Precision tokens:** how do we protect them, and what are they worth in our plan?

---

## Mission Inventory (fill in from this season's missions)

One row per mission — this is the master table the dashboard will visualize.

| Mission # | Name | Points | Difficulty (1–5) | Board zone | Run # | Attachment | Built by | Programmed by | Reliability % | Status |
|---|---|---|---|---|---|---|---|---|---|---|
| M01 | | | | | | | | | | Not started |
| M02 | | | | | | | | | | Not started |
| … | | | | | | | | | | |

**Status values:** Not started → Prototyping → Working → Reliable (≥80% in testing) → Competition-ready

## Run Plan

One row per launch, in match order.

| Run # | Missions attempted | Est. points | Est. time | Attachment(s) | Launcher (student) | Notes |
|---|---|---|---|---|---|---|
| 1 | | | | | | |
| 2 | | | | | | |

**Sanity check:** total est. time + swap time ≤ 150 seconds, with buffer.

## Score Tracking

Log every full practice match / scrimmage:

| Date | Score | Runs completed | What failed | What we changed after |
|---|---|---|---|---|

The score-over-time chart is the flagship dashboard graph — and doubles as ITERATE evidence for the Robot Design rubric.

---

## What the daily log should capture for this component

- Strategy decisions made (and the reasoning)
- Mission status changes (e.g., M04 moved to "Working")
- Practice match scores and failure notes
- Who built / programmed what (keep the inventory table current)

## Dashboard ideas for this component

- Board map with mission status color-coding
- Score progression line chart with tournament-date markers
- Points-per-second leaderboard of missions (auto-computed)
- Run plan timeline showing the 150-second budget
- Per-student ownership view (their attachments, their programs, their launches)
