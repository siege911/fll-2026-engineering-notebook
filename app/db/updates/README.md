# Data updates

One `.sql` file per practice update after 2026-09-25, named `YYYY-MM-DD-short-name.sql` (e.g. `2026-10-02-practice.sql`).
Each file is applied once, in name order, by `npm run db:apply` or when the server starts. `applied_updates` records which ones have run.

- Never edit a file after it has been applied. If something was wrong, fix it in a new file.
- Start each file with a comment: date, who told us, and the matching `updates/PRACTICE-LOG.md` entry.
- Every fact here must also be in the markdown files.

Patterns: see `../../README.md`.
