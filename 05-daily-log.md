# Daily Log → Engineering Notebook → Dashboard

**Concept:** every meeting produces one daily log entry. The collected entries *are* the Engineering Notebook — but instead of a paper notebook, the app renders them as a visual dashboard. The notebook isn't a chore done after the work; the log *is* the work being captured as it happens.

**Design status:** high-level concept only. The specific entry schema, storage format, and app design are deliberately deferred — we'll iterate on this once the concepts in the other files settle.

---

## What a daily entry needs to capture (concept level)

**Meeting basics**
- Date, meeting length, attendance
- Meeting goal(s) set at the start / met or not at the end

**Per-component progress** — a short section for whichever components were touched today:
- **Innovation Project** — see "What the daily log should capture" in `01-innovation-project.md`
- **Robot Design** — see `02-robot-design.md`
- **Robot Game** — see `03-robot-game.md`
- **Core Values** — the 60-second section defined in `04-core-values.md`

**Cross-cutting**
- Photos/videos (build progress, prototypes, action shots)
- Decisions made today (any component) — one line each, with reasoning
- Who did what today (per-student contribution tags — feeds the "all team members" rubric rows and the team spotlight)
- Problems hit / open questions
- Next meeting's plan

## Guiding principles

1. **Every field should trace to a rubric row.** If a field never produces judging evidence or dashboard value, cut it. (`00-judging-rubric.md` is the master reference.)
2. **Capture in ≤10 minutes at the end of each meeting** — ideally distributed (each student logs their own contribution). If logging is painful, it won't happen.
3. **Structured over freeform** where possible (tags, statuses, checkboxes) so the dashboard can aggregate; one freeform "story of the day" field so the season has a narrative.
4. **Students write it, coaches prompt it.** Judges can tell a student-written notebook from a coach-written one.

## The Dashboard (vision)

Instead of flipping through a notebook, the team (and judges, via a screen or printout) sees:

- **Season overview:** countdown to tournament, meetings held, current robot game high score, rubric self-assessment heat map (all 20 rows, rated 1–4, updated monthly)
- **Component pages:** the dashboard ideas listed at the bottom of each component file
- **Team spotlight:** per `04-core-values.md`
- **Timeline/feed:** the daily entries themselves, browsable, with photos — this *is* the engineering notebook view for judges

## Open design questions (deliberately deferred)

- Entry format & storage: markdown files vs. structured data (JSON/SQLite) vs. both (markdown with front-matter)
- One entry per meeting vs. per student per meeting
- How photos are stored and referenced
- Tech stack for the dashboard app
- Whether a printable/exportable "notebook" view is needed for judging tables that expect paper
