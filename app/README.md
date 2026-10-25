# Rooted Warriors Season App (v5, the live app)

The real app: the Sidebar HQ design from `../mockups/14-rooted-warriors-app-v4.html`, now saving to a database.
Nothing to install; it only needs Node 22.13 or newer (built-in SQLite).

```
cd app
npm run dev          # → http://localhost:8787
```

From Claude Code: start the `rooted-warriors` server in `../.claude/launch.json`.
To open it from a tablet on the same Wi-Fi: `HOST=0.0.0.0 npm run dev`, then go to `http://<this-computer's-IP>:8787`. There is no PIN yet, so only do this on the team's own network.

## What's where

| Path | What it is |
|---|---|
| `server.mjs` | Dev server: serves `public/`, JSON API at `/api/…`, applies new update files on start |
| `public/index.html` | The app page (all 8 pages). Reads everything from `GET /api/data` |
| `public/logo.png` | Sidebar logo (= `../mockups/rooted-warriors-logo-outlined.png`) |
| `images/` | The team's photos, served at `/images/<file>`. `profile <name>.jpg` = profile pictures (`team.photo`). `<M-D>-mission-<N>.jpg` = attachment photos (not shown yet) |
| `db/schema.sql` | Baseline tables (Sept 28). SQLite that also runs on Cloudflare D1. **Don't edit.** Add columns/tables with `ALTER TABLE` / `CREATE TABLE` in an update file, so a rebuild replays them in order |
| `db/seed.sql` | Baseline data: everything through the 2026-09-25 practice, taken from app v4. **Don't edit.** |
| `db/updates/*.sql` | One dated file per practice update after Sep 25. Applied once each, in name order |
| `db/rooted-warriors.db` | The live database (binary). Also holds what students type into the app |
| `db/snapshot.json` | Readable copy of every table, rewritten after every change |
| `db/backups/` | Old databases kept by `db:reset` |

## Recording a practice update (Claude's job, see `../CLAUDE.md`)

1. Write the markdown first (`../updates/PRACTICE-LOG.md` etc.), as always.
2. Add `db/updates/YYYY-MM-DD-short-name.sql` with the INSERTs/UPDATEs for the same facts. Set `source = 'update'` on new rows.
3. Apply it: `npm run db:apply` (starting the server applies it too).
4. Start or reload the dev server and look at the page that changed.

Handy patterns (lists are JSON text):

```sql
-- new notebook entry
INSERT INTO entries (date, who, component, phase, text, core_values, success, source)
VALUES ('2026-10-02', '["Nolan","Weston"]', 'Robot Design', 'ITERATE', 'Ran M14 ten times, 7 worked.', '["Teamwork"]', 1, 'update');
-- add a coder to a mission
UPDATE missions SET programmed_by = json_insert(programmed_by, '$[#]', 'Nolan') WHERE id = 'M02';
-- new attachment version
INSERT INTO attachment_versions (attachment_id, date, note)
SELECT id, '2026-10-02', 'v2 — wider pusher (Nolan)' FROM attachments WHERE name = 'Mission 8 attachment';
-- test session
INSERT INTO tests (date, attachment, tries, successes, observed, changed, result, source)
VALUES ('2026-10-02', 'Mission 14 attachment', 10, 7, 'Seeds bounced out', 'Drove slower', '70% today', 'update');
-- change a one-off value (settings are JSON)
UPDATE settings SET value = json_set(value, '$.name', 'Sprout') WHERE key = 'mascot';
```

Other commands:

```
npm run db:sql -- "SELECT date, who, text FROM entries WHERE source = 'app' ORDER BY created_at DESC"
npm run db:snapshot
npm run db:reset -- --yes   # rebuild from schema + seed + updates (old .db goes to db/backups/)
```

`db:reset` loses anything students typed into the app since those rows live only in the database (and `snapshot.json`). Copy those rows into markdown before a reset, or restore them from the backup.

## What the page can change

The API only accepts these (everything else goes through `db/updates/`):
- **Add:** notebook entries, Core Values moments, practice matches, test sessions, proudest-moment quotes.
- **Edit:** mission status and reliability, rubric self-ratings, profile-card fields (role, favorites, learned, worked with most, notebook entries).
- **Add (since Oct 5):** Project Plan (gantt) bars.
- **Fill in (since Oct 5):** Innovation Project Problem / Solution / How we got here (`settings.ip_summary`) and the current step (`settings.ip_progress`), via `PATCH /api/settings/<key>`. Their `note` becomes "typed in the app <time>"; check `SELECT * FROM settings WHERE note LIKE 'typed in the app%'` at session start and copy them into markdown.

Rows added from the page get `source = 'app'`.

## Sample data

All sample placeholders were deleted on 2026-10-05 (`db/updates/2026-10-05-remove-samples.sql`, asked by the students). They are still readable in `seed.sql` for history. Everything the app shows is now real.

## Later: Cloudflare (CJ)

Target is Workers + D1 + R2 (`../DECISIONS.md` 2026-08-31). `schema.sql`, `seed.sql`, and the update files load into D1 unchanged (`wrangler d1 execute … --file`); the routes in `server.mjs` port to a Worker `fetch` handler. Still open: PIN, photo upload (R2), deploy.

One caution: the database file sits in OneDrive. Run the server on one computer at a time.
