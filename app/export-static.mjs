// Builds the view-only website in ../site/ (Nov 19, CJ): the app page with every bit of database data baked in.
//   npm run export   (from app/)   then commit + push site/ and the host (Render static site) redeploys it.
// It starts its own copy of the server on a spare port, asks it for /api/data and every shared code file / install
// guide, then writes them into site/index.html as window.VIEW_ONLY. The database is only read, never changed.
// Re-run it after every practice update; the online copy only changes when you export + push.
import { spawn } from 'node:child_process';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const APP = path.dirname(fileURLToPath(import.meta.url));
const OUT = path.join(APP, '..', 'site');
const PORT = 8799;
const BASE = `http://127.0.0.1:${PORT}`;

const server = spawn(process.execPath, ['--disable-warning=ExperimentalWarning', 'server.mjs'], {
  cwd: APP, env: { ...process.env, PORT: String(PORT), HOST: '127.0.0.1' }, stdio: ['ignore', 'pipe', 'inherit'],
});
await new Promise((ok, fail) => {
  server.stdout.on('data', d => { if (String(d).includes('→')) ok(); });
  server.on('exit', code => fail(new Error(`server stopped (code ${code})`)));
});

try {
  const data = await (await fetch(`${BASE}/api/data`)).json();
  const files = {};
  for (const f of (data.ip_platforms || []).flatMap(p => [...p.docs, ...p.files])) {
    const r = await fetch(`${BASE}/api/file?path=${encodeURIComponent(f.path)}`);
    if (r.ok) files[f.path] = await r.text(); // 404 = placeholder, the page shows 🚧
  }
  const saved = new Date().toLocaleString('en-US', { month: 'short', day: 'numeric', year: 'numeric', hour: 'numeric', minute: '2-digit' });
  const baked = JSON.stringify({ data, files, saved }).replace(/</g, '\\u003c');

  fs.rmSync(OUT, { recursive: true, force: true });
  fs.mkdirSync(OUT, { recursive: true });
  let html = fs.readFileSync(path.join(APP, 'public', 'index.html'), 'utf8');
  html = html.replace('<head>', '<head>\n<meta name="robots" content="noindex, nofollow">');
  const at = html.indexOf('<script>');
  html = html.slice(0, at) + `<script>window.VIEW_ONLY=${baked};</script>\n` + html.slice(at);
  fs.writeFileSync(path.join(OUT, 'index.html'), html);
  for (const f of fs.readdirSync(path.join(APP, 'public'))) if (f !== 'index.html') fs.cpSync(path.join(APP, 'public', f), path.join(OUT, f), { recursive: true });
  fs.cpSync(path.join(APP, 'images'), path.join(OUT, 'images'), { recursive: true, filter: s => !path.basename(s).startsWith('.') });
  fs.writeFileSync(path.join(OUT, 'robots.txt'), 'User-agent: *\nDisallow: /\n');
  console.log(`site/ written: ${(html.length / 1024).toFixed(0)} KB page, ${Object.keys(files).length} code files / guides, ${fs.readdirSync(path.join(OUT, 'images')).length} images`);
} finally {
  server.kill();
}
