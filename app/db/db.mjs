// Database helper for the Rooted Warriors app. Uses Node's built-in SQLite (node:sqlite), so nothing to install.
//
//   node db/db.mjs apply            apply any new files in db/updates/ (the server also does this on start)
//   node db/db.mjs snapshot         write db/snapshot.json (readable copy of every table)
//   node db/db.mjs sql "SELECT …"   run one SQL statement and print the rows
//   node db/db.mjs reset --yes      back up the current database, then rebuild from schema + seed + updates
import { DatabaseSync } from 'node:sqlite';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

export const DB_DIR = path.dirname(fileURLToPath(import.meta.url));
export const DB_PATH = process.env.DB_FILE || path.join(DB_DIR, 'rooted-warriors.db'); // DB_FILE = use another file (for testing)
const SNAPSHOT_PATH = process.env.DB_FILE ? process.env.DB_FILE + '.snapshot.json' : path.join(DB_DIR, 'snapshot.json');
const UPDATES_DIR = path.join(DB_DIR, 'updates');
const read = f => fs.readFileSync(path.join(DB_DIR, f), 'utf8');

function inTransaction(db, fn) {
  db.exec('BEGIN');
  try { fn(); db.exec('COMMIT'); } catch (e) { db.exec('ROLLBACK'); throw e; }
}

// Opens the database, building it from schema + seed the first time.
export function open() {
  const fresh = !fs.existsSync(DB_PATH);
  const db = new DatabaseSync(DB_PATH);
  db.exec('PRAGMA foreign_keys = ON');
  if (fresh) {
    inTransaction(db, () => { db.exec(read('schema.sql')); db.exec(read('seed.sql')); });
    console.log('Created database from schema.sql + seed.sql');
  }
  return db;
}

// Applies db/updates/*.sql files not applied yet, in file-name order (name them YYYY-MM-DD-what.sql).
export function applyUpdates(db) {
  const done = new Set(db.prepare('SELECT file FROM applied_updates').all().map(r => r.file));
  const files = fs.existsSync(UPDATES_DIR) ? fs.readdirSync(UPDATES_DIR).filter(f => f.endsWith('.sql')).sort() : [];
  const applied = [];
  for (const file of files) {
    if (done.has(file)) continue;
    inTransaction(db, () => {
      db.exec(fs.readFileSync(path.join(UPDATES_DIR, file), 'utf8'));
      db.prepare('INSERT INTO applied_updates (file) VALUES (?)').run(file);
    });
    applied.push(file);
  }
  if (applied.length) console.log('Applied updates:', applied.join(', '));
  return applied;
}

// Writes every table to db/snapshot.json, so there is always a readable, diffable copy next to the binary .db file.
export function snapshot(db) {
  const tables = db.prepare("SELECT name FROM sqlite_master WHERE type = 'table' AND name NOT LIKE 'sqlite_%' ORDER BY name").all();
  const out = { written_at: new Date().toISOString() };
  for (const { name } of tables) out[name] = db.prepare(`SELECT * FROM ${name}`).all();
  fs.writeFileSync(SNAPSHOT_PATH, JSON.stringify(out, null, 1));
}

function reset() {
  if (fs.existsSync(DB_PATH)) {
    const dir = path.join(DB_DIR, 'backups');
    fs.mkdirSync(dir, { recursive: true });
    const dest = path.join(dir, `rooted-warriors-${new Date().toISOString().replace(/[:.]/g, '-')}.db`);
    fs.renameSync(DB_PATH, dest);
    console.log('Old database moved to', path.relative(DB_DIR, dest));
  }
  const db = open();
  applyUpdates(db);
  snapshot(db);
}

if (process.argv[1] === fileURLToPath(import.meta.url)) {
  const [cmd, arg] = process.argv.slice(2);
  if (cmd === 'apply') { const db = open(); applyUpdates(db); snapshot(db); }
  else if (cmd === 'snapshot') snapshot(open());
  else if (cmd === 'sql') {
    const db = open(), stmt = db.prepare(arg);
    if (stmt.columns().length) console.table(stmt.all()); else { console.log(stmt.run()); snapshot(db); }
  }
  else if (cmd === 'reset') {
    if (arg !== '--yes') {
      console.log('reset rebuilds from schema + seed + updates. Anything students typed into the app is NOT in those files');
      console.log('(the old database is kept in db/backups/). Run again with --yes to do it.');
      process.exit(1);
    }
    reset();
  }
  else { console.log('usage: node db/db.mjs apply | snapshot | sql "<SQL>" | reset --yes'); process.exit(1); }
}
