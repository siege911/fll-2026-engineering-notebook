// Rooted Warriors season app — local dev server. No dependencies: Node 22+ built-ins only.
//   npm run dev   (from app/)   →  http://localhost:8787
// Serves public/ and a small JSON API over the SQLite database in db/.
// Later this becomes a Cloudflare Worker + D1 (DECISIONS.md 2026-08-31); schema.sql is written to run on D1 as-is.
import http from 'node:http';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { open, applyUpdates, snapshot } from './db/db.mjs';

const PORT = +process.env.PORT || 8787;
const HOST = process.env.HOST || '127.0.0.1'; // HOST=0.0.0.0 to reach it from other devices on the same Wi-Fi
const PUBLIC = path.join(path.dirname(fileURLToPath(import.meta.url)), 'public');
const IMAGES = path.join(path.dirname(fileURLToPath(import.meta.url)), 'images');

const db = open();
applyUpdates(db);
snapshot(db);

// The page uses short keys (from the mockups); the database uses readable column names.
// key → column, per table. JSON = columns stored as JSON text.
const TABLES = {
  team:        { key: 'name', map: { n: 'name', c: 'color', face: 'face', role: 'role', fav: 'fav_value', color: 'fav_color', most: 'worked_on_most', learned: 'learned', with: 'worked_with_most', entries: 'notebook_entries', photo: 'photo', ring: 'ring_color' }, order: 'sort_order' },
  missions:    { key: 'id', map: { id: 'id', name: 'name', aka: 'aka', pts: 'max_points', how: 'how_it_scores', noeq: 'no_equipment', diff: 'difficulty', run: 'run_number', att: 'attachment', built: 'built_by', prog: 'programmed_by', rel: 'reliability', st: 'status', sec: 'est_seconds' }, order: 'id' },
  scoring_extras: { map: { name: 'name', pts: 'max_points', how: 'how' }, order: 'rowid' },
  runs:        { key: 'run_number', map: { n: 'run_number', m: 'missions', t: 'est_seconds', l: 'launcher' }, order: 'run_number' },
  matches:     { map: { id: 'id', d: 'date', s: 'score', r: 'runs_completed', f: 'what_failed', c: 'what_changed' }, order: 'date, id' },
  rubric:      { key: 'id', map: { id: 'id', sec: 'section', ph: 'phase', row: 'row_name', cv: 'core_values', l: 'level' }, order: 'id' },
  entries:     { map: { id: 'id', d: 'date', who: 'who', comp: 'component', ph: 'phase', t: 'text', cv: 'core_values', succ: 'success', photo: 'photo', sample: 'sample' }, order: 'date DESC, id DESC' },
  moments:     { map: { id: 'id', d: 'date', v: 'value', who: 'who', t: 'text', help: 'help', sample: 'sample' }, order: 'date DESC, id DESC' },
  tests:       { map: { id: 'id', d: 'date', att: 'attachment', tries: 'tries', succ: 'successes', obs: 'observed', chg: 'changed', res: 'result' }, order: 'date DESC, id DESC' },
  attachments: { map: { id: 'id', name: 'name', mission: 'mission', purpose: 'purpose', by: 'built_by', size: 'size' }, order: 'sort_order' },
  programs:    { key: 'id', map: { id: 'id', name: 'program', mission: 'mission', by: 'coded_by', sensors: 'sensors', bit: 'innovative_bit' }, order: 'sort_order' },
  robot_specs: { map: { label: 'label', value: 'value' }, order: 'sort_order' },
  tradeoffs:   { key: 'id', map: { id: 'id', d: 'date', q: 'question', opts: 'options', pick: 'pick', why: 'why' }, order: 'sort_order, id' },
  ip_steps:    { map: { n: 'n', name: 'name' }, order: 'n' },
  gantt:       { map: { task: 'task', who: 'owner', s: 'start_pos', e: 'end_pos', iters: 'iterations', sample: 'sample' }, order: 'id' },
  research:    { map: { src: 'source', type: 'type', by: 'found_by', note: 'note', sample: 'sample' }, order: 'id' },
  experts:     { map: { n: 'name', role: 'role', face: 'face', fb: 'feedback', imp: 'improvement', d: 'date', by: 'met_by', notes: 'notes', qs: 'questions', sample: 'sample' }, order: 'id' },
  quotes:      { map: { q: 'quote', by: 'by_line', d: 'date' }, order: 'id DESC' },
};
const JSON_COLS = new Set(['built_by', 'programmed_by', 'missions', 'who', 'core_values', 'help', 'coded_by', 'iterations', 'notes', 'questions']);
// What the page may change. Everything else is changed through db/updates/ files.
const CAN_ADD = { entries: ['d', 'who', 'comp', 'ph', 't', 'cv', 'succ'], moments: ['d', 'v', 'who', 't', 'help'], matches: ['d', 's', 'r', 'f', 'c'], tests: ['d', 'att', 'tries', 'succ', 'obs', 'chg', 'res'], quotes: ['q', 'by', 'd'], gantt: ['task', 'who', 's', 'e'] };
// Settings the page may fill in (merged into the JSON value; note records that it was typed in the app).
const CAN_SET = { ip_summary: ['problem', 'solution', 'how'], ip_progress: ['now'], mascot: ['name'] };
// "Tap to fill in" blanks (Oct 9): mission diff/run/attachment/built/coded, run launcher, program sensors, tradeoff pick/why.
const CAN_EDIT = { team: ['role', 'fav', 'color', 'most', 'learned', 'with', 'entries'], missions: ['st', 'rel', 'diff', 'run', 'att', 'built', 'prog'], rubric: ['l'], runs: ['l'], programs: ['sensors'], tradeoffs: ['pick', 'why'] };

function rows(table) {
  const { map, order } = TABLES[table];
  const cols = Object.entries(map).map(([k, c]) => `${c} AS "${k}"`).join(', ');
  return db.prepare(`SELECT ${cols} FROM ${table} ORDER BY ${order}`).all().map(r => {
    const o = { ...r };
    for (const [k, c] of Object.entries(map)) if (JSON_COLS.has(c) && o[k] != null) o[k] = JSON.parse(o[k]);
    return o;
  });
}

function allData() {
  const data = {};
  for (const t of Object.keys(TABLES)) data[t] = rows(t);
  const versions = db.prepare('SELECT attachment_id, date AS d, note AS n, photo FROM attachment_versions ORDER BY date, id').all();
  for (const a of data.attachments) a.vers = versions.filter(v => v.attachment_id === a.id);
  data.settings = Object.fromEntries(db.prepare('SELECT key, value FROM settings').all().map(s => [s.key, JSON.parse(s.value)]));
  return data;
}

const toDb = (table, body, allowed) => {
  const map = TABLES[table].map, cols = [], vals = [];
  for (const k of allowed) if (k in body) {
    const c = map[k], v = body[k];
    cols.push(c);
    vals.push(v == null ? null : JSON_COLS.has(c) ? JSON.stringify(v) : typeof v === 'boolean' ? +v : v);
  }
  return { cols, vals };
};

function add(table, body) {
  const { cols, vals } = toDb(table, body, CAN_ADD[table]);
  if (!cols.length) throw new Error('nothing to save');
  if (table === 'gantt') { cols.push('created_at'); vals.push(new Date().toISOString().slice(0, 19).replace('T', ' ')); }
  const r = db.prepare(`INSERT INTO ${table} (${cols.join(', ')}, source) VALUES (${cols.map(() => '?').join(', ')}, 'app')`).run(...vals);
  return { id: Number(r.lastInsertRowid) };
}

function edit(table, id, body) {
  const { cols, vals } = toDb(table, body, CAN_EDIT[table]);
  if (!cols.length) throw new Error('nothing to change');
  const r = db.prepare(`UPDATE ${table} SET ${cols.map(c => c + ' = ?').join(', ')} WHERE ${TABLES[table].key} = ?`).run(...vals, id);
  if (!r.changes) throw new Error(`no ${table} row ${id}`);
  return { changed: r.changes };
}

function setSetting(key, body) {
  const old = db.prepare('SELECT value FROM settings WHERE key = ?').get(key);
  const value = old ? JSON.parse(old.value) : {};
  for (const k of CAN_SET[key]) if (k in body) value[k] = body[k];
  const note = `typed in the app ${new Date().toISOString().slice(0, 19).replace('T', ' ')}`;
  db.prepare('INSERT INTO settings (key, value, note) VALUES (?, ?, ?) ON CONFLICT(key) DO UPDATE SET value = excluded.value, note = excluded.note').run(key, JSON.stringify(value), note);
  return { saved: key };
}

const TYPES = { '.html': 'text/html; charset=utf-8', '.png': 'image/png', '.js': 'text/javascript', '.css': 'text/css', '.json': 'application/json', '.svg': 'image/svg+xml', '.jpg': 'image/jpeg', '.jpeg': 'image/jpeg', '.webp': 'image/webp' };
const send = (res, code, body, type = 'application/json') => { res.writeHead(code, { 'Content-Type': type, 'Cache-Control': 'no-store' }); res.end(typeof body === 'string' || Buffer.isBuffer(body) ? body : JSON.stringify(body)); };
const readBody = req => new Promise((ok, fail) => { let s = ''; req.on('data', c => s += c); req.on('end', () => { try { ok(s ? JSON.parse(s) : {}); } catch (e) { fail(e); } }); });

http.createServer(async (req, res) => {
  const url = new URL(req.url, 'http://x');
  const parts = url.pathname.split('/').filter(Boolean).map(decodeURIComponent);
  try {
    if (parts[0] === 'api') {
      const [, table, id] = parts;
      if (req.method === 'GET' && table === 'data') return send(res, 200, allData());
      if (req.method === 'POST' && CAN_ADD[table] && !id) { const out = add(table, await readBody(req)); snapshot(db); return send(res, 201, out); }
      if (req.method === 'PATCH' && table === 'settings' && CAN_SET[id]) { const out = setSetting(id, await readBody(req)); snapshot(db); return send(res, 200, out); }
      if (req.method === 'PATCH' && CAN_EDIT[table] && id) { const out = edit(table, id, await readBody(req)); snapshot(db); return send(res, 200, out); }
      return send(res, 404, { error: 'unknown API route' });
    }
    // /images/… = the team's photos in app/images/; everything else comes from public/
    const root = parts[0] === 'images' ? IMAGES : PUBLIC;
    const file = path.join(root, path.normalize(url.pathname === '/' ? 'index.html' : root === IMAGES ? parts.slice(1).join('/') : decodeURIComponent(url.pathname)));
    if (!file.startsWith(root + path.sep) || !fs.existsSync(file) || fs.statSync(file).isDirectory()) return send(res, 404, 'Not found', 'text/plain');
    send(res, 200, fs.readFileSync(file), TYPES[path.extname(file)] || 'application/octet-stream');
  } catch (e) {
    console.error(req.method, req.url, e.message);
    send(res, 400, { error: e.message });
  }
}).listen(PORT, HOST, () => console.log(`Rooted Warriors app → http://localhost:${PORT}`));
