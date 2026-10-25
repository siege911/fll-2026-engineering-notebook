# Robot Design — Methodical Build Process

**Goal:** walk the students through robot design decisions *methodically*, so that every choice is a documented tradeoff — because the rubric (see `00-judging-rubric.md`) scores the *explanation of the process*, not just the robot. A team that can say "we chose medium wheels because we tested big ones and lost accuracy on mission 7" is living in the Accomplished/Exceeds column.

Like the Innovation Project, Robot Design is judged in five phases: **IDENTIFY → DESIGN → CREATE → ITERATE → COMMUNICATE**.

---

## Phase 1: IDENTIFY — Mission strategy first, robot second

Before building the chassis, the team studies the game board and decides *which missions we will attempt* (this is the Robot Game strategy — see `03-robot-game.md`). The robot is then designed to serve that strategy. The rubric's first row is literally "clear evidence of mission strategy."

Also scored here: **use of building and coding resources** — tutorials, FIRST materials, mentor guidance, other teams' published designs. Log every resource consulted and how it influenced the design.

## Phase 2: DESIGN — The Tradeoff Questionnaire

Each design area below is run as a mini *questionnaire + test* session: the students predict the tradeoff, test both options where possible, record data, then decide. Every completed worksheet is rubric evidence.

### Worksheet format (repeat for each decision)

1. **Question** — what are we deciding?
2. **Options & predicted tradeoffs** — students write predictions first
3. **Test** — how will we measure it? (same program, same table, 3+ trials each)
4. **Data** — results table
5. **Decision & reasoning** — one paragraph, signed by the team
6. **Revisit trigger** — what result would make us reopen this decision?

### Decision 1: Wheel type (size / shape)

- Bigger wheels = faster but less accurate (each motor-degree of error is magnified by circumference); smaller wheels = slower but more precise.
- Thicker/softer wheels = more traction; thin/hard wheels = less scrub when turning.
- **Suggested test:** drive a fixed 1000 mm path 5× per wheel type; record time and end-position error.

### Decision 2: Wheel placement (front vs. rear, weight distribution)

- More weight directly over the drive wheels = more traction and stability.
- Drive wheels at the front put weight over them, but large front wheels can crowd the attachment zone.
- Consider where the brick (heaviest part) sits relative to the drive axle.
- **Suggested test:** measure wheel-slip on launch (mark start, full-power start, look for scrub) with the brick mounted forward vs. rearward.

### Decision 3: Wheel track width (distance between wheels)

- Wider track = more turning accuracy and stability, but a wider robot has less room to maneuver between mission models.
- **This decision should be driven by the board:** measure the tightest gaps between mission models the strategy requires us to pass through, and set max width from that.

### Decision 4: Height & overall geometry

- Taller robot = more compact footprint and room to stack mechanisms, but harder to reach *low* missions — it's easier to build up than down.
- Keep the attachment mounting points low and build upward.
- Also consider center of gravity: tall + fast + sudden stop = tipping.

### Decision 5: Sensors

Evaluate each sensor against *our* mission strategy:

| Sensor | Candidate uses | Questions to answer |
|---|---|---|
| Color/light | Line following; line squaring (alignment); **mission/program selection from a color card** | Is line following actually faster/more reliable than wheel-odometry for our paths? Which board lines are usable? |
| Gyro (in hub) | Accurate turns; drive-straight correction | Do gyro turns beat timed/rotation turns in our tests? Drift handling? |
| Distance/ultrasonic | Wall/model approach detection | Any mission where distance-stop beats dead reckoning? |
| Touch | Bump-stop alignment; manual program advance | Simpler than color-based program selection? |
| Motor rotation (built-in) | Odometry — the free default | What's our baseline accuracy with rotations alone? |

- **Line following (color sensor):** test it. It shines for long runs along a printed line; it costs speed and tuning time. Decide per-mission-path, not globally.
- **Mission selection (color sensor or hub buttons):** a fast, mistake-proof way to launch the right program matters in a 2:30 match. Compare: color-card selection vs. scrolling hub menu vs. one master program. Measure *time between launches* and *wrong-program errors*.
- Wall-squaring and line-squaring (using walls, touch, or color sensors to re-align mid-run) is often the single biggest accuracy win — worth a dedicated test day.

### Suggested additional decisions (same worksheet treatment)

- **Gear ratio:** speed vs. torque vs. accuracy on the drive train.
- **Attachment system:** how do attachments mount? Quick-swap (pins, magnets, drop-on) vs. bolted. Measure swap time — it's match time.
- **Chassis modularity:** can we service/replace a motor without a rebuild?
- **Code architecture:** My Blocks / functions for common moves (drive straight with gyro, square to line), one shared launch framework, naming conventions, and a plan for version history.

## Phase 3: CREATE — Build & document

Build the chassis and attachments per the decisions above. For every attachment, record: name, purpose, missions served, **who designed/built it**, photos, and what's innovative about it. Same for each program: missions served, sensors used, **who programmed it**. (This feeds both the rubric's "all team members" rows and the Core Values team spotlight.)

## Phase 4: ITERATE — Test relentlessly, log everything

- Standard test protocol: same launch position, 5+ consecutive runs, record success/failure and failure mode.
- Log every change as **observation → change → retest result**. "Clear evidence of *repeated* testing" and "improvements based on testing" are both scored rows.
- Track per-mission reliability % over time — this becomes a killer dashboard chart *and* killer judging evidence.

## Phase 5: COMMUNICATE — The Robot Design explanation

Prepare the team to walk judges through: mission strategy, the tradeoff decisions (with data!), attachments and their purpose, code and sensor use, what testing revealed, and lessons learned. Every student explains something they personally built or coded. Rehearse it like the Innovation Project presentation — pride and enthusiasm are scored here too.

---

## What the daily log should capture for this component

- Tradeoff worksheets completed (with data)
- Build progress + photos, tagged by builder
- Programs written/changed, tagged by programmer
- Test sessions: runs, results, failure modes
- Improvements: observation → change → result
- Resources consulted (tutorials, mentors, guides)

## Dashboard ideas for this component

- Robot spec sheet (current wheels, dimensions, sensors, gear ratio) with decision links
- Per-mission reliability trend chart
- Attachment gallery: photo, purpose, builder, missions
- Test-run counter (total runs logged — a fun team stat)
- Decision log: every tradeoff worksheet, searchable
