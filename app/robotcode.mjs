// Robot code history for the Coding page (Nov 2). Reads the Engineering Notebook's code/ folder as it is,
// so new code shows up by itself: one folder per practice, named M-D (e.g. code/11-1/), holding
// Pybricks backup zips and/or loose .py files. Read-only, .py files only. No dependencies.
import fs from 'node:fs';
import path from 'node:path';
import zlib from 'node:zlib';

const SEASON_YEAR = 2026; // folders are M-D: Jul–Dec = 2026, Jan–Jun = 2027

// Every .py file inside a zip, as { name, text }. Handles stored and deflated files (what Pybricks makes).
function readZip(file) {
  const buf = fs.readFileSync(file), out = [];
  let end = buf.length - 22;
  while (end >= 0 && buf.readUInt32LE(end) !== 0x06054b50) end--; // end-of-central-directory record
  if (end < 0) return out;
  let p = buf.readUInt32LE(end + 16);
  for (let i = buf.readUInt16LE(end + 10); i > 0; i--) {
    const method = buf.readUInt16LE(p + 10), size = buf.readUInt32LE(p + 20);
    const nameLen = buf.readUInt16LE(p + 28), extraLen = buf.readUInt16LE(p + 30), commentLen = buf.readUInt16LE(p + 32);
    const local = buf.readUInt32LE(p + 42), name = buf.toString('utf8', p + 46, p + 46 + nameLen);
    p += 46 + nameLen + extraLen + commentLen;
    if (!name.endsWith('.py') || name.includes('/') || ![0, 8].includes(method)) continue;
    const start = local + 30 + buf.readUInt16LE(local + 26) + buf.readUInt16LE(local + 28);
    const data = buf.subarray(start, start + size);
    out.push({ name, text: (method === 8 ? zlib.inflateRawSync(data) : data).toString('utf8') });
  }
  return out;
}

// "mission2_3.py" → ['M02', 'M03']
const missionsOf = name => (name.match(/^mission([\d_]+)\.py$/i)?.[1] || '').split('_').filter(Boolean).map(n => 'M' + n.padStart(2, '0'));

// How alike two versions are (0..1), by shared lines. Used to tell apart two different copies of the same file name.
function alike(a, b) {
  const A = a.split('\n').map(l => l.trim()).filter(Boolean), B = b.split('\n').map(l => l.trim()).filter(Boolean), left = new Map();
  for (const l of B) left.set(l, (left.get(l) || 0) + 1);
  let same = 0;
  for (const l of A) if (left.get(l)) { same++; left.set(l, left.get(l) - 1); }
  return same / Math.max(A.length, B.length, 1);
}

// → { dates: ['2026-09-07', …], programs: [{ file, copy, missions, versions: [{ d, src, code }], seen: [{ d, v }] }] }
// versions = only the practices where the program was new or changed; seen = every practice it was saved (v = which version).
export function robotCode(notebook) {
  const dir = path.join(notebook, 'code');
  if (!fs.existsSync(dir)) return { dates: [], programs: [] };
  const days = fs.readdirSync(dir).map(f => ({ f, m: f.match(/^(\d{1,2})-(\d{1,2})$/) }))
    .filter(x => x.m && fs.statSync(path.join(dir, x.f)).isDirectory())
    .map(({ f, m }) => ({ f, d: `${+m[1] >= 7 ? SEASON_YEAR : SEASON_YEAR + 1}-${m[1].padStart(2, '0')}-${m[2].padStart(2, '0')}` }))
    .sort((a, b) => a.d.localeCompare(b.d));
  const programs = [];
  for (const { f, d } of days) {
    const found = new Map(); // file name → [{ text, src }], identical copies counted once
    for (const item of fs.readdirSync(path.join(dir, f)).sort()) {
      const src = `code/${f}/${item}`, full = path.join(dir, f, item);
      const files = item.endsWith('.zip') ? readZip(full) : item.endsWith('.py') ? [{ name: item, text: fs.readFileSync(full, 'utf8') }] : [];
      for (const { name, text } of files) {
        const list = found.get(name) || found.set(name, []).get(name);
        if (!list.some(x => x.text === text)) list.push({ text, src });
      }
    }
    for (const [name, list] of found) {
      const open = programs.filter(p => p.file === name), used = new Set();
      const last = p => p.versions[p.versions.length - 1].code;
      for (const pass of ['same', 'closest', 'new']) for (const x of list) {
        if (x.done) continue;
        let p;
        if (pass === 'same') p = open.find(p => !used.has(p) && last(p) === x.text);
        if (pass === 'closest') p = open.filter(p => !used.has(p)).sort((a, b) => alike(last(b), x.text) - alike(last(a), x.text))[0];
        if (pass === 'new') programs.push(p = { file: name, missions: missionsOf(name), versions: [], seen: [] });
        if (!p) continue;
        if (pass !== 'same') p.versions.push({ d, src: x.src, code: x.text });
        p.seen.push({ d, v: p.versions.length - 1 });
        used.add(p);
        x.done = true;
      }
    }
  }
  for (const p of programs) {
    const copies = programs.filter(q => q.file === p.file);
    p.copy = copies.length > 1 ? 'ABCDEFGH'[copies.indexOf(p)] : '';
  }
  programs.sort((a, b) => (a.missions[0] || 'Z').localeCompare(b.missions[0] || 'Z') || a.file.localeCompare(b.file) || a.copy.localeCompare(b.copy));
  return { dates: days.map(x => x.d), programs };
}
