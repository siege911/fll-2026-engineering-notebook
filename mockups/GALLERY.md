# Mockup Gallery

One line per prototype. Verdicts: 👍 chosen / 🤔 maybe / ❌ rejected (and why).

All five below show the **same dashboard home page with the same sample data** — only the look changes — so the vote is purely about style. Double-click any file to open it.

| # | File | Theme | Verdict |
|---|---|---|---|
| 01 | `01-dashboard-neon-glow.html` | **Neon Glow** — dark background, glowing greens/teals/purples. Fits the BioGlow season. | ⬜ not voted yet |
| 02 | `02-dashboard-space-mission.html` | **Space Mission** — NASA mission-control: dark navy, monospace type, GO/HOLD/NO-GO statuses, T-minus countdown. | ⬜ not voted yet |
| 03 | `03-dashboard-clean-sport.html` | **Clean Sport** — bright white sports-app look: bold scoreboard numbers, team-color chips, "mission lineup." | ⬜ not voted yet |
| 04 | `04-dashboard-retro-arcade.html` | **Retro Arcade** — high-score screen: pixel-purple, hearts for reliability, missions as game levels. | ⬜ not voted yet |
| 05 | `05-dashboard-brick-builder.html` | **Brick Builder** — bright LEGO brick colors, studs on everything, minifig-face avatars. | ⬜ not voted yet |

Remixing is allowed and encouraged — e.g. "colors from 01 with the layout from 03."

## Round 2 — Rooted Warriors logo colors, 5 different layouts (added Aug 31)

These five all use the **official logo palette** (forest green, lavender, teal circuit-blue, grass green, cream) and the same sample data — this time the vote is about **layout**, not color.

| # | File | Layout | Verdict |
|---|---|---|---|
| 06 | `06-rooted-sidebar-hq.html` | **Sidebar HQ** — dark green side menu with the crest and circuit roots at the bottom, cards on cream to the right. Feels like a "real app." | 👍 **CHOSEN** (Sept 4) — became the v1 app shell |
| 07 | `07-rooted-badge-hero.html` | **Badge Hero** — giant crest and team name up top (like the logo itself), a stats ribbon, then one centered column of cards. | ⬜ not voted yet |
| 08 | `08-rooted-bento-board.html` | **Bento Board** — dark forest background with a faint circuit grid; tiles of different sizes snap together like a bento box. | ⬜ not voted yet |
| 09 | `09-rooted-journal-feed.html` | **Journal Feed** — the notebook timeline is the star (dotted teal "root" line down the page), with a stats rail on the right. | ⬜ not voted yet |
| 10 | `10-rooted-canopy-roots.html` | **Canopy & Roots** — page built like the logo: light leafy top for judged stuff, lavender "Rooted Warriors" trunk banner, dark circuit-root bottom for robot tech. | 🤔 not chosen for the shell — its "run plan vs 150 s" bar was borrowed into v1 |

## Round 3 — First working version (added Sept 4)

| # | File | What it is | Verdict |
|---|---|---|---|
| 11 | `11-rooted-warriors-app-v1.html` | **App v1 (test build)** — Sidebar HQ layout with all 7 pages clickable: Dashboard, Robot Game, Robot Design, Innovation Project, Core Values, Daily Log, Rubric Check. Forms really work while the page is open (log a match → confetti on a new high score; log a test session; add a Core Values moment; write a notebook entry; rate rubric rows 1–4). Nothing is saved when you close it yet — that's CJ's part. | 🤔 superseded by 12 (placeholder names) |
| 12 | `12-rooted-warriors-app-v2.html` | **App v2 (test build)** — same as 11 but with the **real logo** in the sidebar and the **real team**: Thea, Adeline, Fynn, Isla, Nolan, Weston. Roles, favorite values/colors, missions and scores are still sample data for the students to replace. | 🤔 superseded by 13 (made-up missions) — Thea's Sept 4 profile-card edits carried forward |

## Round 4 — Real missions (added Sept 6)

| # | File | What it is | Verdict |
|---|---|---|---|
| 13 | `13-rooted-warriors-app-v3.html` | **App v3 (test build)** — same app, but the Robot Game page now has the **real 15 BIOGLOW missions** (official numbers, names, max points, how each one scores, 🚫 no-equipment flag, and a "we say" line for our nicknames), plus Equipment Inspection and Precision Tokens. Attachments, notebook entries, tradeoffs, and the robot specs now show what the team has **actually** built (Aug 26 – Sep 4). Made-up practice scores and test sessions are gone — those cards show a friendly "log your first one" until real data goes in. Innovation Project page is still sample data (labelled). | 🤔 superseded by 14 (Coding moved to its own page) — same data |

## Round 5 — Coding page (added Sept 19)

| # | File | What it is | Verdict |
|---|---|---|---|
| 14 | `14-rooted-warriors-app-v4.html` | **App v4 (test build)** — same app as v3 with the Sep 19 and Sep 25 practice data, plus a new **💻 Coding** page in the sidebar (student request). Robot Design keeps the main robot, attachments, test sessions, and tradeoffs; Coding holds every program and who wrote it, a who-coded-what table with "needs a program" to-dos, and the notebook entries about programming. Also from Sep 19: Daily Log feed behind an "Open the Notebook Feed" button, profile-card fields blanked for each teammate to fill in, "The Main Robot" card name. | 🟡 last single-file build — frozen Sept 28; the live app moved to `app/` (below) |

## Round 6 — Live app with a database (added Sept 28)

| # | File | What it is | Verdict |
|---|---|---|---|
| v5 | `../app/public/index.html` (run `cd app && npm run dev`, open http://localhost:8787) | **App v5**: looks exactly like v4, but it reads from and saves to the team database. Everything through Sep 25 is loaded. Entries, moments, matches, tests, profile cards, statuses, and rubric ratings typed in the app are saved. Not a mockup: no sample data gets added here. | 🟡 current build |

## Round 7 — More purple (added Oct 12)

| # | File | What it is | Verdict |
|---|---|---|---|
| 15 | `15-more-purple-options.html` | Thea: "for the whole app add a little bit more purple because that is the team color." Today's look next to 3 options: **A Purple Touches** (purple stripe on every card, purple card titles, purple countdown), **B Purple Sidebar** (sidebar deep purple instead of green), **C Lilac Background** (light lilac page behind the cards, purple card titles). | ❌ Thea: wanted options using only the lavender purple we already use (→ #16) |
| 16 | `16-more-lavender-options.html` | Thea: "give me more options but with only the lavender purple we've been using." Every option adds only our lavender (#b48fd9): **D Lavender Title Bars** (card titles on a lavender bar), **E Lavender Frames** (thick lavender border on every card), **F Lavender Sidebar Trim** (lavender stripe down the sidebar edge, lavender logo badge, team name, and countdown), **G Lavender Banner** (lavender banner across the top of every page). | 👍 Thea picked **E Lavender Frames** (Oct 12); built into the live app |

## Round 8 — Wildlife camera app (added Oct 24)

| # | File | What it is | Verdict |
|---|---|---|---|
| 17 | `17-camera-app-v1-option-c.html` | Thea picked Option C for camera v1. Camera app screen: live view (new picture every 2 s), two lights ("App saw motion" / "Motion sensor felt heat"), experiment scoreboard (App only / Both / Sensor only, day vs. night, false alarms), saved pictures tagged by AI with people blurred. Below it: a small Camera card as it could look inside the notebook app, linking to the camera app. | 👍 Thea: Option C + separate camera app with a Camera card in the notebook (Oct 24) |

## Logo files (added Nov 13)

- `rooted-warriors-logo.svg` — **true vector** logo (traced from the original 1024×1536 art in `../Robotics App/Logo.png`, background removed, dark-green outline). Scales to any size for print, banners, shirts.
- `rooted-warriors-logo-4096.png` — high-res transparent PNG (2877×4096) rendered from that SVG.
- Older small files (`rooted-warriors-logo-transparent.*`, `-outlined.*`, 256 px) are kept; their `.svg` versions only wrap the small picture.
