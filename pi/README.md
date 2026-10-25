# Raspberry Pi 4 — wildlife camera station

The Pi collects pictures from the camera, tags them, and (later) sends the real animals to the website.

| Step | File | Status |
|---|---|---|
| 1. Collect pictures from the camera every 15 min | `collector.py` | ✅ written, tested against a pretend camera |
| 2. Tag: animal / person / empty, then species; blur people | — | waiting on the Pi's RAM |
| 3. Upload tagged animals to the DigitalOcean site | — | after the site exists |

## Set up the Pi (one time)

1. **Raspberry Pi Imager** (on the Mac) → Raspberry Pi 4 → **Raspberry Pi OS Lite (64-bit)**. In the settings (gear): hostname `rooted-pi`, your user, Wi-Fi (same network as the camera), turn on SSH. Best: write it to a **USB SSD** instead of a microSD card (lots of writes wear SD cards out).
2. Boot it, then from the Mac: `ssh <user>@rooted-pi.local`
3. Check the RAM: `free -h` (the "Mem: total" column: ~0.9, 1.8, 3.7 or 7.6 Gi = 1, 2, 4 or 8 GB).
4. Get the code: `git clone <repo> rooted-warriors` (or copy the `pi/` folder).
5. `cd rooted-warriors/pi && cp settings.example.json settings.json && nano settings.json`. Set `camera_key` to the same `CAMERA_KEY` as in the camera's `secrets.h`.
6. Test: `python3 collector.py` → "Copied N new pictures…". Photos land in `pi/photos/<date>/`, and the trigger log in `pi/photos/log.csv`.
7. Run it every 15 minutes: `crontab -e` and add
   ```
   */15 * * * * cd $HOME/rooted-warriors/pi && python3 collector.py >> collector.log 2>&1
   ```

## How it finds the camera
The camera calls itself `rooted-camera.local` on the Wi-Fi (camera v2). If that ever fails, give the camera a fixed address in the router (DHCP reservation) and put that address in `camera_url`.

## Safety
The collector only deletes a picture on the camera after the copy on the Pi is complete and the right size. If the camera is off or out of range, it logs "not reachable" and tries again next time.
