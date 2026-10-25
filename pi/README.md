# Raspberry Pi 4 — wildlife camera station

The Pi collects pictures from the camera, tags them, and (later) sends the real animals to the website.

| Step | File | Status |
|---|---|---|
| 1. Collect pictures from the camera every 15 min | `collector.py` | ✅ written, tested against a pretend camera |
| 2. Tag: animal / person / empty, then species; blur people | `tagger.py` | ✅ written, tested with made-up SpeciesNet answers |
| 3. Upload tagged animals to the DigitalOcean site | — | after the site exists |

## Set up the Pi (one time)

1. **Raspberry Pi Imager** (on the Mac) → Raspberry Pi 4 → **Raspberry Pi OS Lite (64-bit)**. In the settings (gear): hostname `rooted-pi`, your user, Wi-Fi (same network as the camera), turn on SSH. Best: write it to a **USB SSD** instead of a microSD card (lots of writes wear SD cards out).
2. Boot it, then from the Mac: `ssh <user>@rooted-pi.local`
3. Check the RAM: `free -h` (the "Mem: total" column: ~0.9, 1.8, 3.7 or 7.6 Gi = 1, 2, 4 or 8 GB).
4. Get the code: `git clone <repo> rooted-warriors` (or copy the `pi/` folder).
5. `cd rooted-warriors/pi && cp settings.example.json settings.json && nano settings.json`. Set `camera_key` to the same `CAMERA_KEY` as in the camera's `secrets.h`.
6. Test: `python3 collector.py` → "Copied N new pictures…". Photos land in `pi/photos/<date>/`, and the trigger log in `pi/photos/log.csv`.
7. Install the AI (the Pi has 8 GB, plenty for SpeciesNet):
   ```
   sudo apt install -y python3-venv
   python3 -m venv ~/speciesnet-env
   ~/speciesnet-env/bin/pip install speciesnet
   ~/speciesnet-env/bin/python -m speciesnet.scripts.run_model --help
   ```
   The first tagging run downloads the models (a few hundred MB). PyTorch on the Pi's CPU is slow: expect several seconds or more per picture. That's fine, it only sees pictures where something fired.
8. Test: `~/speciesnet-env/bin/python tagger.py` → "Tagged: 3 animal, 1 empty…". Results go in `pi/photos/tags.csv`.
9. Run both every 15 minutes: `crontab -e` and add
   ```
   */15 * * * * cd $HOME/rooted-warriors/pi && python3 collector.py >> collector.log 2>&1 && $HOME/speciesnet-env/bin/python tagger.py >> tagger.log 2>&1
   ```
   (The tagger won't start twice if a big batch is still running.)

## What the tagger does with each picture
| SpeciesNet says | What happens |
|---|---|
| animal | stays in `photos/<date>/`; species + confidence in `tags.csv` |
| person or vehicle | blurred in place; the unblurred original is deleted |
| empty (nothing, or only a weak guess under 0.2) | moved to `photos/empty/<date>/`, deleted after 7 days |

`tags.csv` columns: file, time, trigger (S / C / SC), result, species, confidence, animals, people, vehicles. With the trigger in each row, it's the data for the experiment: how many real animals did "picture changed" find vs. the motion sensor, and how many false alarms each had.

Settings (optional, in `settings.json`): `country` (`USA`), `admin1_region` (`AZ`: SpeciesNet only picks species found in Arizona), `min_confidence` (0.2), `keep_empty_days` (7).

## How it finds the camera
The camera calls itself `rooted-camera.local` on the Wi-Fi (camera v2). If that ever fails, give the camera a fixed address in the router (DHCP reservation) and put that address in `camera_url`.

## Safety
The collector only deletes a picture on the camera after the copy on the Pi is complete and the right size. If the camera is off or out of range, it logs "not reachable" and tries again next time.
