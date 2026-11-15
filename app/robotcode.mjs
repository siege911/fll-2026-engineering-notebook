// Robot code history for the Coding page (Nov 2). Reads the Engineering Notebook's code/ folder as it is,
// so new code shows up by itself: one folder per practice, named M-D (e.g. code/11-1/), holding
// Pybricks backup zips and/or loose .py files. Read-only, .py files only. No dependencies.
// Nov 15: folders can also be named "<label> - Mon D" (e.g. "Final v2 - Nov 9"): the date comes from the
// end, the label is shown in the app. A loose .py beats a zip copy of the same name in the same folder
// (it's the later hand-saved edit). A new file name that carries on an older program (mission4.py →
// mission4_5.py) records which program it grew from, so the app can show what changed.
import fs from 'node:fs';
import path from 'node:path';
import zlib from 'node:zlib';

const SEASON_YEAR = 2026; // folders are M-D: Jul–Dec = 2026, Jan–Jun = 2027
const MONTHS = ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'];

// Folder name → { d: 'YYYY-MM-DD', label } or null. "11-1" → label ''; "Final v2 - Nov 9" → label 'Final v2'.
function folderDate(f) {
  let m = f.match(/^(\d{1,2})-(\d{1,2})$/), mon, day, label = '';
  if (m) [mon, day] = [+m[1], +m[2]];
  else if ((m = f.match(/^(.*?)\s*-\s*([A-Za-z]{3})[a-z]*\.?\s+(\d{1,2})$/)) && MONTHS.includes(m[2].toLowerCase())) [label, mon, day] = [m[1].trim(), MONTHS.indexOf(m[2].toLowerCase()) + 1, +m[3]];
  else return null;
  return { d: `${mon >= 7 ? SEASON_YEAR : SEASON_YEAR + 1}-${String(mon).padStart(2, '0')}-${String(day).padStart(2, '0')}`, label };
}

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

// "mission2_3.py" → ['M02', 'M03']; "mission13_12b.py" → ['M13', 'M12'] (a/b = part of a mission)
const missionsOf = name => [...new Set((name.match(/^mission([\d_a-z]+)\.py$/i)?.[1] || '').split('_').map(n => n.match(/^\d+/)?.[0]).filter(Boolean).map(n => 'M' + n.padStart(2, '0')))];

// How alike two versions are (0..1), by shared lines. Used to tell apart two different copies of the same file name.
function alike(a, b) {
  const A = a.split('\n').map(l => l.trim()).filter(Boolean), B = b.split('\n').map(l => l.trim()).filter(Boolean), left = new Map();
  for (const l of B) left.set(l, (left.get(l) || 0) + 1);
  let same = 0;
  for (const l of A) if (left.get(l)) { same++; left.set(l, left.get(l) - 1); }
  return same / Math.max(A.length, B.length, 1);
}

// → { dates: ['2026-09-07', …], labels: { '2026-11-09': 'Final v2' }, programs: [{ file, copy, missions, from, versions: [{ d, src, code, base? }], seen: [{ d, v }] }] }
// versions = only the practices where the program was new or changed; seen = every practice it was saved (v = which version).
// from = 'mission4.py' when this program grew out of an older one; versions[0].base = that program's code it grew from.
export function robotCode(notebook) {
  const dir = path.join(notebook, 'code');
  if (!fs.existsSync(dir)) return { dates: [], labels: {}, programs: [] };
  const days = fs.readdirSync(dir).map(f => ({ f, ...folderDate(f) }))
    .filter(x => x.d && fs.statSync(path.join(dir, x.f)).isDirectory())
    .sort((a, b) => a.d.localeCompare(b.d) || a.f.localeCompare(b.f));
  const programs = [];
  for (const { f, d } of days) {
    const found = new Map(); // file name → [{ text, src }], identical copies counted once
    const items = fs.readdirSync(path.join(dir, f)).sort(), loose = new Set(items.filter(i => i.endsWith('.py')));
    for (const item of items) {
      const src = `code/${f}/${item}`, full = path.join(dir, f, item);
      const files = item.endsWith('.zip') ? readZip(full).filter(x => !loose.has(x.name)) : item.endsWith('.py') ? [{ name: item, text: fs.readFileSync(full, 'utf8') }] : [];
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
        let base;
        if (pass === 'new') {
          programs.push(p = { file: name, missions: missionsOf(name), versions: [], seen: [] });
          // A brand-new file name that shares a mission with an older program and much of its code grew out of it.
          const parent = open.length ? null : programs.filter(q => q.file !== name && q.seen[0].d < d && q.missions.some(id => p.missions.includes(id)))
            .map(q => ({ q, code: last(q), score: alike(last(q), x.text) })).filter(c => c.score >= 0.3).sort((a, b) => b.score - a.score)[0];
          if (parent) { p.parent = parent.q; base = parent.code; }
        }
        if (!p) continue;
        if (pass !== 'same') p.versions.push({ d, src: x.src, code: x.text, ...(base ? { base } : {}) });
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
  for (const p of programs) if (p.parent) { p.from = p.parent.file + (p.parent.copy ? ` copy ${p.parent.copy}` : ''); delete p.parent; }
  programs.sort((a, b) => (a.missions[0] || 'Z').localeCompare(b.missions[0] || 'Z') || a.file.localeCompare(b.file) || a.copy.localeCompare(b.copy));
  return { dates: days.map(x => x.d), labels: Object.fromEntries(days.filter(x => x.label).map(x => [x.d, x.label])), programs };
}
