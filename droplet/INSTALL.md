# DigitalOcean droplet — our website (placeholder)

> 🚧 **Not built yet.** This is the plan, so the Innovation Project Details page has something to show. Nothing below has been tried. The choices marked **(CJ)** are waiting on Coach CJ (`../DECISIONS.md` 2026-10-24).

## What will live here

One small DigitalOcean server (a "droplet") runs two websites:

| Site | What it does | Code | Status |
|---|---|---|---|
| **Camera website** | Shows the animal visits we picked on the Pi's Publish page (people already blurred on the Pi) | `droplet/camera-site/` | ⬜ not written |
| **Engineering Notebook app** | This app, so we can open it anywhere, not only on the laptop | `app/` | ✅ runs on the laptop · ⬜ not on the droplet |

```
Pi (🌐 House Wi-Fi)  →  https://camera.<our-domain>/upload  →  droplet  →  anyone with the team password
                        (Pi's own upload key)
```

The Pi only sends what we picked. Nothing goes online by itself.

## Files we'll need (none written yet)

| File | Job |
|---|---|
| `droplet/camera-site/server.mjs` | Takes uploads from the Pi (checks its key), saves the photos and visit info, serves the website |
| `droplet/camera-site/public/index.html` | The website page: our animal visits, in the notebook colors |
| `droplet/camera-site.service` | Starts the camera website when the droplet boots |
| `droplet/Caddyfile` | HTTPS for both sites + one team password per site |
| `pi/station/uploader.py` | On the Pi: sends the picked visits from the Publish line to the website |

## Install plan (draft)

### 1. Make the droplet (CJ)
- DigitalOcean → Create → Droplet: **Ubuntu 24.04 LTS**, the **$6/month** size (1 GB), a US West region, **SSH key** login (no password), turn on **weekly backups**.
- Domain and DNS **(CJ)**: suggested Cloudflare Registrar + DNS, two A records (`camera.` and `notebook.`) pointing at the droplet, "DNS only".

### 2. First login and safety
```bash
ssh root@<droplet-ip>
adduser rooted && usermod -aG sudo rooted
rsync --archive --chown=rooted:rooted ~/.ssh /home/rooted
ufw allow OpenSSH && ufw allow 80 && ufw allow 443 && ufw enable
```

### 3. Node and Caddy
```bash
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -
sudo apt install -y nodejs git caddy
node --version        # 22.13 or newer
```

### 4. Get our code
```bash
git clone git@github.com:siege911/<repo>.git ~/rooted-warriors
```

### 5. Start the sites at boot
Each site runs on the droplet only (`127.0.0.1`), and Caddy puts HTTPS in front:
- Notebook app: `HOST=127.0.0.1 PORT=8787 node app/server.mjs` as a systemd service.
- Camera website: `droplet/camera-site.service` (to be written).

### 6. HTTPS + team password
`/etc/caddy/Caddyfile` (to be written, `droplet/Caddyfile`): one block per site with `reverse_proxy 127.0.0.1:<port>` and `basic_auth` (one team password each). The Pi's `/upload` uses its own upload key instead of the team password.

### 7. Connect the Pi
- Add the website address and upload key to the Pi's `settings.json` (new settings, to be added with `uploader.py`).
- Tap **Publish** on the touchscreen: the Pi switches to 🌐 House Wi-Fi and sends the picked visits.

## Still to decide (CJ)
- Domain name.
- Where the notebook app's database lives on the droplet, and how the laptop copy and the droplet copy stay in step.
- Backups beyond DigitalOcean's weekly ones (the photos).
