# Camera Build — parts and wiring

The Innovation Project wildlife camera: what we bought, how it's wired, and every build/test step. **Newest at top.** Design history (why two boxes, why the XIAO) is in `INNOVATION-PROJECT.md` and `../DECISIONS.md`.

---

## 2026-10-26 — Pi: one Wi-Fi radio, switch on the touchscreen
**Asked by:** Coach CJ · **Built by:** Claude · **Code:** `../pi/station/network.py`, guide `../pi/NETWORKING.md` (setup 1)
- Home page switch **📡 Camera Wi-Fi | 🌐 House Wi-Fi** (NetworkManager `nmcli connection up …`). No USB adapter needed. **Changed later on Oct 26 (CJ):** no automatic return; it stays in the mode picked, and Publish switches to House Wi-Fi.
- Checked: on a Mac in practice mode (pretend switch): switching, the "Switching…" message, the return time, and going back by itself after 1 minute (test setting) all worked. **Not tried with real NetworkManager on the Pi yet.**

---

## 2026-10-25 (later) — Camera v3 + Pi Camera Station
**Asked by:** Coach CJ · **Built by:** Claude · **Code:** `../camera/camera-v3/`, `../pi/` (start with `../pi/README.md`)
- **Camera v3:** joins the Pi's camera Wi-Fi (`RootedWarriorsCam`), sends each saved photo to the Pi right away (up to 5 at a time, every half second), deletes it after the Pi has it; out of range, photos wait on the card. Time from the Pi every hour; saved in the clock module (D4/D5) if one is wired. No time yet → `no-time-…` names, timed by the Pi when they arrive. Live page also shows "Sending to the Pi · N waiting · N sent". Compiles (36% of flash). **Not tested on the real camera.**
- **Pi Camera Station:** tags as photos arrive, blurs people, groups visits, touchscreen review and publish. Tested on a Mac in practice mode (made-up AI answers): 34 practice photos → 7 visits; species/count/reviewer buttons, merge ("same animal as visit before"), approve, publish queue and Test page all worked; wrong key and bad file names are refused.
- `pi/tagger.py` removed (the station does its job). `pi/collector.py` now hands photos to the station (backup for v2 cameras).
- **Still to do:** USB Wi-Fi adapter + `pi/NETWORKING.md`; install SpeciesNet on the Pi (`pi/INSTALL.md`); first real test: camera v3 → Pi.

---

## 2026-10-25 (later) — Pi tagger (step 2 of the Pi)
**Told by:** Coach CJ (the Pi 4 has **8 GB** RAM, from the original order) · **Code by:** Claude · **Code:** `../pi/tagger.py`
- Uses **SpeciesNet** (Google's camera-trap AI): MegaDetector finds animal / person / vehicle, then a classifier names the species, limited to species found in Arizona.
- **Animal** → kept, species + confidence in `pi/photos/tags.csv`. **Person / vehicle** → blurred, unblurred original deleted (Nate Reagan's advice). **Empty** → moved to `photos/empty/`, deleted after 7 days.
- `tags.csv` keeps the trigger (S / C / SC) with each result: the data for "picture changed vs. motion sensor" (real animals and false alarms for each).
- Checked: tested with made-up SpeciesNet answers (a mule deer kept and tagged 0.87, a person blurred, a weak guess counted as empty; a second run did nothing). SpeciesNet itself is **not installed or tested on the Pi yet**.

---

## 2026-10-25 (later) — Pi 4 collector (step 1 of the Pi)
**Asked by:** Coach CJ · **Code by:** Claude · **Code:** `../pi/collector.py`, setup in `../pi/README.md`
- The Pi is a **Raspberry Pi 4 Model B** (the board says © 2018; all Pi 4s do). RAM not known yet (1/2/4/8 GB): it decides the tagging model.
- Every 15 min the Pi copies new pictures off the camera's microSD card, checks each is complete, then deletes it on the camera; merges the camera's `log.csv` into `pi/photos/log.csv`. Built-in Python only.
- Camera v2 now also answers at `http://rooted-camera.local`, so the Pi can find it even if its address changes.
- Checked: tested against a pretend camera (3 photos copied over 2 pages, deleted from the "card", log merged, second run copied nothing, camera-off handled). **Not tested with the real camera/Pi yet.**

---

## 2026-10-25 — Camera code v2: picture comparing + motion sensor, saves to microSD
**Asked by:** Coach CJ · **Code by:** Claude · **Code:** `../camera/camera-v2/camera-v2.ino` (+ `secrets.h`: Wi-Fi and the Pi's delete key; not on GitHub)
- **Every second:** takes a 640×480 picture and shows it live (notebook colors) with two lights: **📷 Picture changed** (with % changed) and **🔥 Motion sensor**.
- **Picture changed:** shrinks each picture to 80×60 black and white and counts the spots that changed more than 30 (out of 255) since the picture before. 2% of the picture or more = changed. A whole-picture brightness change (a cloud) is ignored. Settings at the top of the code: `PIXEL_CHANGE`, `AREA_CHANGE`.
- **Saves only when something fired:** `/photos/2026-10-25/2026-10-25_14-03-22_SC.jpg` (S = motion sensor, C = picture changed). Every save also goes into `/photos/log.csv` (time, file, motion_sensor, picture_changed, percent_changed): the experiment's data.
- **Experiment scoreboard on the live page:** Picture changed only / Both / Motion sensor only (saved pictures since power-on).
- **Time:** from the internet (Arizona time, `MST7`). The clock module isn't used yet (needed for the forest camera without Wi-Fi).
- **For the Pi:** `/files` (list), `/download?f=…`, `POST /delete?f=…&key=…`.
- Checked: compiles for XIAO_ESP32S3 with OPI PSRAM (esp32 core 3.3.12). **Not tested on the real camera yet.** Needs a microSD card (FAT32) in the camera board's slot.
- **Test:** upload → open the address → wave a hand (both lights) → walk past at a distance → check that saved pictures appear on the card and in log.csv. Tune `AREA_CHANGE` if wind sets it off. [result: not yet]

---

## 2026-10-24 — Camera code v1 (Option C), first draft
**Asked by:** Thea · **Code by:** Claude (coach's assistant), for Thea to test · **Code:** `../camera/camera-v1/camera-v1.ino` (+ `secrets.h` for the Wi-Fi name and password)
- Takes a picture every 2 seconds (640×480). Checks the motion sensor (D0): did it feel something any time since the last picture? Shows both on a web page at the address printed in the Serial Monitor, on the same Wi-Fi. Counts how many pictures the sensor felt something in.
- Not in v1 yet: sending pictures to the online camera app, saving to the microSD card, the clock, the mode switch.
- Checked: it compiles for XIAO_ESP32S3 with OPI PSRAM (esp32 core 3.3.12). **Not tested on the real camera yet.**
- **Test (Thea):** 1) type the Wi-Fi name/password in `secrets.h`; 2) upload; 3) open the address; 4) wave a hand at the motion sensor and see "Motion sensor: YES" turn green. [result: not yet]

---

## 2026-10-23 — Wiring done at practice
**Told by:** Thea
- **Nolan wired the camera, with Thea helping.** [unclear: which parts (motion sensor, clock, switch, light)? breadboard or soldered? did any test step pass yet?]

---

## 2026-10-23 — How to program the XIAO from a Mac (Arduino IDE)
**Asked by:** Thea (she's doing the camera programming) · **Steps by:** Claude (coach's assistant)

1. Install **Arduino IDE 2** from arduino.cc (macOS, Apple Silicon or Intel). Drag it to Applications.
2. Arduino IDE → Settings → "Additional boards manager URLs": `https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json`
3. Boards Manager (left sidebar) → search **esp32** → install **esp32 by Espressif Systems**.
4. Plug the XIAO in with a **USB-C data cable** (some charge-only cables don't carry data). If the Mac asks "Allow accessory to connect?", click Allow. No driver needed.
5. Tools → Board → esp32 → **XIAO_ESP32S3**. Tools → Port → `/dev/cu.usbmodem…`. Tools → **PSRAM → OPI PSRAM** (the camera needs it).
6. **First test, Blink:** File → Examples → 01.Basics → Blink → Upload (→ arrow). The small orange LED blinks.
7. **Camera test:** File → Examples → ESP32 → Camera → CameraWebServer. In the sketch, comment out the default model and turn on `#define CAMERA_MODEL_XIAO_ESP32S3`. Type in the Wi-Fi name and password (2.4 GHz Wi-Fi only). Upload, open Serial Monitor at 115200, and open the address it prints in a browser on the same Wi-Fi.
8. Clock library for later: Library Manager → **RTClib** (by Adafruit).

**If the upload fails or the port disappears:** hold the **B** (BOOT) button, press and let go of **R** (RESET), then let go of B, and upload again. Press R after it finishes. This is normal once the camera uses deep sleep: a sleeping board drops off the USB port.
**Before plugging in:** clip the antenna on, and snap the camera board onto the XIAO.

---

## 2026-10-12 — Parts bought + camera box wiring plan (v1)
**Told by:** [who?] · **Plan by:** Claude (coach's assistant), for the team to check

### What we bought
**Solar box (separate box):**
- ZPSHYD 6V 3W mini monocrystalline solar panel (DC5521 plug)
- Waveshare Solar Power Manager Module (D): takes a 6–24 V solar panel or a Type-C adapter, gives 5 V / 3 A out, has a battery holder
- 2-pack 2600 mAh 3.7 V button-top 18650 rechargeable batteries (**delayed in shipping**)

**Camera box:**
- Seeed Studio XIAO ESP32-S3 Sense (camera + microphone + microSD slot)
- AM312 mini PIR motion sensor (5-pack, HC-SR312)
- DS3231 AT24C32 I2C real-time clock module (2-pack, with jumper wires)

**Changed from the Oct 3 plan:** Waveshare Solar Power Manager (D) instead of the DFRobot Sunflower; 6 V 3 W panel (the Waveshare board needs 6 V or more, so this fits); 2600 mAh button-top 18650s instead of a protected ~3000 mAh cell.

**Still need (not on the list yet):** 32 GB high-endurance microSD (FAT32) · SPDT mini toggle switch (the mode switch) · CR2032 coin cell for the clock (if the module didn't come with one) · waterproof box + USB-C panel jack or a short USB-C extension · breadboard + jumper wires for testing · optional: 1 LED + 220 Ω resistor (status light).

### Power: no wiring needed
The camera is powered through the **XIAO's own USB-C port**. A phone charger (Camera 1, house) or the solar box's USB-C output (Camera 2, forest) plugs straight into it. The XIAO turns 5 V into 3.3 V and shares that with the sensors on its **3V3** pin. Nothing connects to the XIAO's 5V pin or its battery pads.

### Camera box wiring (everything runs on 3.3 V)
| XIAO pin | Chip name | Goes to | Why |
|---|---|---|---|
| 3V3 | — | Clock VCC, motion sensor VCC (+), switch end #1 | Power for the sensors |
| GND | — | Clock GND, motion sensor GND (−), switch end #2 | Ground (shared by everything) |
| D0 | GPIO1 | Motion sensor OUT | Wakes the camera when an animal moves |
| D1 | GPIO2 | Switch middle pin | Mode switch: 3V3 = always-on, GND = solar mode |
| D2 | GPIO3 | (optional) LED + 220 Ω → GND | Status light |
| D3 | GPIO4 | Clock SQW | Wakes the camera on a clock alarm (e.g. a check-in every few hours) |
| D4 | GPIO5 | Clock SDA | Clock data |
| D5 | GPIO6 | Clock SCL | Clock timing signal |
| D6, D7 | GPIO43, 44 | free | Can't wake the camera from sleep |
| D8, D9, D10 | GPIO7, 8, 9 | **don't use** | The microSD card uses these |

Clock module pins not used: 32K, and the 4-pin end on the other side (it's for chaining another I2C board).

### Why these pins
- Pins go top-to-bottom in the same order as the parts (motion, switch, light, clock), so no wires cross.
- Only GPIO0–21 can wake the ESP32-S3 from deep sleep, so the motion sensor, clock alarm and switch go on D0–D5.
- The motion sensor and switch both say "wake up" with **HIGH**; the clock alarm says it with **LOW**. The program wakes on "D0 or D1 goes HIGH" (ext1) or "D3 goes LOW" (ext0).
- The switch's middle pin always touches either 3V3 or GND, so it's never "floating" and needs no extra resistor. In always-on mode it holds D1 HIGH, so the camera can't go back to sleep, which is what we want.
- The clock runs on 3.3 V, so its coin-cell "charging" circuit can't push current into a CR2032 (that's a known problem at 5 V).
- The XIAO's own orange LED is on GPIO21, which the Sense board also uses for the microSD card, so a status light needs its own pin.

### Test order (no batteries needed)
1. XIAO alone on a USB-C phone charger / computer: camera takes a picture, saves to microSD.
2. Add the clock: set the time, read it back, check pictures get a time stamp.
3. Add the motion sensor: wave a hand, the sensor's OUT goes HIGH (wait ~30 s after power-on for it to settle).
4. Add the switch: flip it, the program sees always-on vs. solar mode.
5. Deep-sleep test: sleep → wave → wakes → picture → sleep. Then the clock alarm wake.
6. When the 18650s arrive: plug the camera into the solar box and check the box **doesn't switch itself off** while the camera sleeps (some power boards turn off when almost no power is used). Measure how long the battery lasts.

### Adult jobs (Coach CJ)
- Soldering header pins on the XIAO / sensors (if they came without them).
- Later, for the forest camera: remove the clock module's red power light (it wastes battery 24/7).
- Batteries: check the 18650s go in the right way (+ to +); no charging below freezing.
