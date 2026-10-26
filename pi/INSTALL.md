# Installing the Camera Station on the Pi

For a Raspberry Pi 4 (8 GB) with the 7" Raspberry Pi Touchscreen. Takes about an hour, most of it waiting for downloads.

## 1. The operating system

Use **Raspberry Pi Imager** on the Mac:
- Device: **Raspberry Pi 4**. OS: **Raspberry Pi OS (64-bit)**, the one **with desktop** (the touchscreen page needs it).
- Storage: a **USB SSD** if you have one (much longer life than a microSD card with photos coming in all day), otherwise a good microSD card.
- Settings (the gear / "Edit settings"): hostname `rooted-pi`, a user name and password, the **house Wi-Fi**, time zone **America/Phoenix**, and **Services → Enable SSH**.

Boot the Pi with the touchscreen attached. From the Mac you can now log in with `ssh <user>@rooted-pi.local`.

On the Pi (Raspberry Pi menu → Preferences → Control Centre / Raspberry Pi Configuration):
- **Display → Screen blanking: off** (so the screen stays on).
- **Display → On-screen keyboard: on**, for typing an animal name with "Other…".

## 2. Networking: do this LAST

Leave the Pi on the house Wi-Fi for now. Steps 3–4 download a lot (our code, PyTorch, the AI models), and once the camera Wi-Fi is set up the Pi only has internet in 🌐 House Wi-Fi mode. Come back here after step 5 and follow **[NETWORKING.md](NETWORKING.md)**, setup 1 (one radio with a switch: no extra parts).

## 3. Get our code

```bash
sudo apt update && sudo apt install -y git python3-venv
git clone git@github.com:siege911/<repo>.git ~/rooted-warriors   # or copy the pi/ folder over
cd ~/rooted-warriors/pi
cp settings.example.json settings.json
nano settings.json
```

In `settings.json`, set **`camera_key`** to the same `CAMERA_KEY` as in the camera's `camera/camera-v3/secrets.h`. (On the Mac, `pi/settings.json` is already filled in with the matching key. You can copy that file over instead.)

| Setting | What it does | Start with |
|---|---|---|
| `camera_key` | the camera must send this to upload photos | match `secrets.h` |
| `team` | names on the "Who checked it?" buttons | our six names |
| `country`, `admin1_region` | SpeciesNet only picks animals found here | `USA`, `AZ` |
| `min_confidence` | AI boxes weaker than this are ignored | `0.2` |
| `visit_gap_minutes` | photos of the same species closer together than this are one visit | `10` |
| `keep_empty_days` | empty photos are deleted after this many days | `7` |
| `port` | the station's web address port | `8080` |
| `wifi_switch` | show the 📡 Camera Wi-Fi / 🌐 House Wi-Fi switch (one radio) | `true` |
| `camera_connection`, `house_connection` | NetworkManager names of the two Wi-Fi connections | `camera-wifi`, `preconfigured` |
| `auto_return_minutes` | House Wi-Fi mode goes back to Camera Wi-Fi after this long (0 = never) | `15` |

## 4. SpeciesNet (the AI)

```bash
python3 -m venv ~/speciesnet-env
~/speciesnet-env/bin/pip install --upgrade pip
~/speciesnet-env/bin/pip install speciesnet pillow
~/speciesnet-env/bin/python -m speciesnet.scripts.run_model --help
```

This downloads PyTorch and friends (a few GB, be patient). Nobody on the team has tried it on a Pi yet: if `pip install` fails, copy the last 20 lines of the error for Coach CJ / Claude.

**Warm-up test** (downloads the AI models the first time, a few hundred MB):

```bash
mkdir -p ~/ai-test && cp <any wildlife photo>.jpg ~/ai-test/
~/speciesnet-env/bin/python -m speciesnet.scripts.run_model \
  --folders ~/ai-test --predictions_json ~/ai-test/out.json --country USA --admin1_region AZ
cat ~/ai-test/out.json
```

Expect several seconds or more per photo on the Pi's CPU. That's fine: the station tags in batches as photos arrive.

**Do this warm-up before the camera Wi-Fi is set up.** Tagging must work without internet in 📡 Camera Wi-Fi mode, so the models need to be downloaded already. To check: after networking is done (Camera Wi-Fi mode, no internet), run the warm-up command again. If it still works, tagging works offline. If it tries to download and fails, tell Coach CJ.

## 5. Try the station by hand

```bash
cd ~/rooted-warriors/pi/station
~/speciesnet-env/bin/python server.py --fake-ai     # practice mode: made-up AI answers
```

Open `http://localhost:8080` on the Pi (or `http://rooted-pi.local:8080` from the Mac). Stop it with Ctrl+C. Then run it for real without `--fake-ai`.

**Practice mode** is great for working on the page without a camera or the AI: photos still come from the camera (or `collector.py`), but the tags are made up. The page shows a purple "Practice mode" banner.

## 6. Start the station at boot

```bash
sed "s/PIUSER/$USER/g" ~/rooted-warriors/pi/station/camera-station.service | sudo tee /etc/systemd/system/camera-station.service
sudo systemctl daemon-reload
sudo systemctl enable --now camera-station
systemctl status camera-station        # should say "active (running)"
journalctl -u camera-station -f        # watch what it's doing (Ctrl+C to stop watching)
```

## 7. The touchscreen shows the station (kiosk mode)

Make Chromium open full screen on the station page when the desktop starts.

Find which browser command the Pi has: `which chromium chromium-browser`. Then find the desktop: newer Pi OS uses **labwc**, older Bookworm used **Wayfire** (`ps -e | grep -E "labwc|wayfire"`).

**labwc:** add this line to `~/.config/labwc/autostart` (create the file if it isn't there):
```
chromium --kiosk --noerrdialogs --disable-infobars --touch-events=enabled --app=http://localhost:8080 &
```

**Wayfire:** add to `~/.config/wayfire.ini`:
```
[autostart]
station = chromium-browser --kiosk --noerrdialogs --disable-infobars --touch-events=enabled --app=http://localhost:8080
```

(Use `chromium-browser` or `chromium`, whichever `which` found.) Reboot. To get out of kiosk mode, plug in a keyboard and press **Alt+F4**.

If the screen is upside down: Raspberry Pi menu → Preferences → Screen Configuration → right-click the screen → Orientation.

## 8. Backup way to get photos (old v2 camera code)

Camera v3 sends photos by itself. For a camera still running v2, the Pi can fetch them:

```bash
cd ~/rooted-warriors/pi && python3 collector.py
```

To run it every 5 minutes: `crontab -e` and add
```
*/5 * * * * cd $HOME/rooted-warriors/pi && python3 collector.py >> collector.log 2>&1
```

## Where things are on the Pi

| Path | What |
|---|---|
| `pi/data/photos/<date>/` | animal, person (blurred) and vehicle (blurred) photos |
| `pi/data/empty/<date>/` | empty photos (false alarms), deleted after 7 days |
| `pi/data/station.db` | everything the station knows: photos, tags, visits, reviews |
| `pi/settings.json` | settings (not on GitHub: it has the camera key) |

`pi/data/` isn't on GitHub either. Back it up once in a while: `cp ~/rooted-warriors/pi/data/station.db ~/station-backup-$(date +%F).db`
