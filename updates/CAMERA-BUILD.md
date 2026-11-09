# Camera Build — parts and wiring

The Innovation Project wildlife camera: what we bought, how it's wired, and every build/test step. **Newest at top.** Design history (why two boxes, why the XIAO) is in `INNOVATION-PROJECT.md` and `../DECISIONS.md`.

---

## 2026-11-09 — AI crashes (SIGILL): station keeps going; errors moved to a Problems page
**Asked by:** [who?] · **Code by:** Claude · **Code:** `../pi/station/server.py`, `store.py`, `ai.py`, `public/index.html`
- **What happened (Nov 8, 15:05):** SpeciesNet crashed again with `SIGILL`, about 8 minutes into a batch. Each crash started the same 50 photos over, so the first batch might never finish. And the Home page showed a big purple error.
- **Asked for:** "If this isn't really an issue, it shouldn't be there. Or maybe we create a dedicated page for viewing errors so we can see them if needed but not on the Home page."
- **Now:**
  - **⚠️ Problems page** (new, in the side menu, with a badge counting new problems): each problem in plain words ("The AI crashed (SIGILL…)"), time, and the full details folded away. Home just says *⚠️ retrying · see Problems* on the "Pi tags" card while it's failing.
  - **Batches of 5 photos** instead of 50 (`tag_batch_size`): answers show up sooner, and a crash loses less.
  - **After a crash, one photo at a time** until that batch is done. A photo that crashes twice on its own is **set aside** (not lost); **🔁 Try again** on Problems puts set-aside photos back in line.
  - The AI now runs with `-X faulthandler`, so the next crash prints **where** it crashed in `journalctl` (to find the cause).
- Side menu buttons a bit shorter so six fit on the 7" screen (800×480).
- Checked on the Mac with a pretend AI that crashes on one photo of 8: one crashed batch → one at a time → the bad photo tried twice, set aside → the other 7 tagged. Try again → tried twice more, set aside again. Page checked at 800×480. **Not on the real Pi yet.** [result: not yet]
- **On the real Pi (Nov 9, 13:56):** pulled and restarted. Tagging 5 photos; progress about every **35–42 s**, so a batch of 5 takes roughly 3–4 minutes on the Pi's CPU. One more SIGILL at 13:55:26, just before the restart (old code); the journal had the start of the crash report (`Extension modules: … torch._C …`), so the crash happens inside PyTorch. [result: waiting to see if the new code finishes a batch]
- **Found the likely cause (Nov 9, 14:14):** the Pi has **PyTorch `2.15.0+cu132`**: the NVIDIA graphics-card build, made for big ARM servers, not the Raspberry Pi's simpler processor (Cortex-A72). It loads, then hits an instruction the Pi doesn't have partway through: `SIGILL`. By then: 11 problems, 5 photos set aside, 29 waiting. Load average 3.87 (all 4 cores busy). **Fix:** replace it with the **CPU-only** PyTorch (`--index-url https://download.pytorch.org/whl/cpu`), then Try again on the set-aside photos. `pi/INSTALL.md` step 4 now installs the CPU build first. **Result: swapped, and tagging finished with no crashes ✓.**
- **Nov 9: the Pi finished tagging every waiting photo** 🎉 (first full run of camera → Pi → AI on real hardware). Review is empty, as expected: the photos were from the office, people waving hands, no animals. Hands/people come out "person" (blurred) or "empty", and only animals go to Review. **After the swap to CPU-only PyTorch**, so the SIGILL fix worked: no more crashes ✓.
- [unclear: why SIGILL: does it crash on the same photo every time (a photo problem), or randomly (a PyTorch/Pi problem)? The Problems page will show.]

---

## 2026-11-08 (even later) — Tagger fixed to work with no internet
**Told by:** [who?] · **Code by:** Claude · **Code:** `../pi/station/ai.py`, `../pi/station/server.py`; guide `../pi/INSTALL.md` step 4
- **The error** (from `journalctl -u camera-station`, 14:27): SpeciesNet failed with `Failed to resolve 'api.kaggle.com'`. Photos from the camera reached the Pi, but tagging failed.
- **Why:** SpeciesNet is normally asked for its model by its online name, and then it checks the internet **every run**, even though the warm-up test already downloaded the model. In 📡 Camera Wi-Fi mode the Pi has no internet.
- **Fix:** the station finds the downloaded model folder (`~/.cache/kagglehub/models/google/speciesnet/…`) and gives SpeciesNet that folder (`--model`). SpeciesNet's own code then loads it straight from the Pi with no internet. New optional setting `speciesnet_model` (blank = find it by itself).
- **On the real Pi (14:41):** pulled the fix. SpeciesNet now loads from the Pi's folder (`…/speciesnet/pyTorch/v4.0.3a/1`) with no internet ✓, but stops at the next step: `PytorchStreamReader failed reading zip archive … checkpoint file is corrupted`. The **detector file** (MegaDetector, the part that finds the animal boxes) only half-downloaded, probably during the warm-up when the Wi-Fi changed or it was stopped. SpeciesNet never re-downloads a file that's already there. **Fix:** delete that one file, download it again on 🌐 House Wi-Fi.
- **14:35–14:36:** the folder's file times showed the whole model was downloaded right then (the station, while the Pi was on 🌐 for the update) and cut off when it went back to 📡: detector `md_v5a.0.1.pt` was **80.5 MB** of about 280 MB. Deleted it and ran the warm-up with `--model` on 🌐.
- **14:49:** classifier loaded in 1.07 s, **detector loaded in 1.24 s** ✓ (no more "corrupted"). The warm-up itself stopped because the `~/ai-test` folder didn't exist (no test photo); not a tagging problem. Detector file now **280,767,041 bytes (≈281 MB, complete)** ✓. Next: 📡 + wave at the camera, see if photos get tagged. [result: not yet]
- **14:56:** one tagging try crashed with `SIGILL` (the processor was handed an instruction it doesn't understand) [unclear: why; watch whether it happens again]. The station retried by itself 40 s later (14:56:58): **models loaded and it started tagging**, progress lines about every 42 s (journalctl showed them as `[blob data]`). The station tags up to 50 photos per batch and saves the answers when the whole batch is done. [result: not yet, waiting for the batch]
- Lesson: don't switch to 📡 while anything is downloading; a half-file stays and SpeciesNet never re-downloads it.
- Checked: on the Mac with a pretend SpeciesNet (model downloaded → uses the folder, newest version if two; nothing downloaded → old way; folder in settings → uses that). **Not on the real Pi yet.** [result: not yet]

---

## 2026-11-08 (later) — Camera sends to the Pi ✓ · Live page and tagger error message fixed
**Told by:** [who?] · **Code by:** Claude · **Code:** `../pi/station/server.py`, `../pi/station/public/index.html`
- **We built two cameras. One works, one doesn't** [unclear: what's wrong with the second one?]. The working one now saves to its microSD card and sends to the Pi ("I think I have it working").
- **Problem 1:** the Pi's Live page only said "Camera at <address>", no picture. **Fix:** the Pi now gets the camera's picture itself and hands it to the touchscreen (`/api/live.jpg`), asking for the next one only after the last one arrives. If the camera doesn't answer, the page says why and keeps trying.
- **Problem 2:** Home page said *"The tagging helper had a problem. Ask Coach CJ."* with no details. **Fix:** the banner now shows the last lines of the real error. [unclear: what the error is: see it after the update]
- **Also:** the Pi now counts the camera as heard from when it asks the time (every start-up) or answers for Live, not only when a photo arrives. Home says "last heard from" instead of "last photo".
- Checked: on the Mac with a pretend camera (no address yet → clear message; camera asks time → Connected; Live picture comes through; camera off → "didn't answer"). **Not on the real Pi yet.** [result: not yet]

---

## 2026-11-08 — Pi: 🌐 House Wi-Fi joins any Wi-Fi it remembers
**Asked by:** [who?] (at the office, not at the house) · **Code by:** Claude · **Code:** `../pi/station/network.py`, `../pi/station/public/index.html`; guide `../pi/NETWORKING.md`
- **What happened:** at the office the Pi was on the office Wi-Fi, but the touchscreen said *"Not on any WiFi. Tap one. Last try didn't work. Error: unknown connection 'camera-wifi'"*. Two reasons: the switch only knew the house Wi-Fi by name (`preconfigured`), and the camera Wi-Fi hadn't been made on this Pi yet (NETWORKING.md setup 1, step 2).
- **Asked for:** "Can we just have the Home Wifi automatically connect to a WiFi that it already remembers from the OS? So if we're at home, it connects to that. If we're at the office, it will connect to that. If we're at a hotspot, it will connect to that."
- **Now:** 🌐 turns off the camera Wi-Fi, looks around, and joins the remembered Wi-Fi with the strongest signal. The screen says which one (e.g. *Internet is on (CityGuest)*). None in range or it fails → back to 📡 Camera Wi-Fi, and the reason stays on screen (before, the reason got wiped when it switched back).
- **The station is installed and running on the real Pi** (its touchscreen showed the Wi-Fi switch). The camera isn't connected to it yet.
- Still one radio (built-in Pi Wi-Fi), so it's camera Wi-Fi **or** internet, never both.
- Checked: tested on the Mac with a pretend Wi-Fi (office in range; house + hotspot → strongest; preferred one first; nothing in range; join fails → back to camera). **Not tested on the real Pi yet.** [result: not yet]
- **Result on the real Pi (Nov 8, at the office):** pulled the new code; 🌐 House Wi-Fi works (joined the office Wi-Fi by itself). 📡 Camera Wi-Fi still says `unknown connection 'camera-wifi'`: the camera Wi-Fi hasn't been made yet.
- **Later Nov 8:** made the camera Wi-Fi over SSH, installed the permission rule (`Not authorized to control networking` before that). 📡 works; `RootedWarriorsCam` shows up. **14:08: the camera joined the Pi's Wi-Fi for the first time** (Pi gave it 10.42.0.100).
- Touchscreen still said *Camera sends: Not connected yet*. Why: the Pi only marks the camera "connected" when a picture arrives (in the last 2 minutes), and no picture had been saved yet. - **14:12 Serial Monitor:** `On the Pi's Wi-Fi. Live page: http://10.42.0.100` and `Time from the Pi: 2026-11-08 14:12:37` (camera ↔ Pi talking ✓). The camera's live page opened from the Pi ✓. Hand-waves: `changed: YES (17–23%)` ✓, but **nothing saved**: the camera said `No microSD card found` even with a card in. No saved pictures → nothing sent → Pi still says *Not connected yet*, and the Pi's Live page says the camera isn't connected. Clock module not found either (probably wiring, later). Some `cam_hal: FB-OVF` lines (camera making pictures faster than the code takes them; harmless for now).
- Next: get the microSD card working (format FAT32 + Master Boot Record, click in, press R). [result: not yet]
- Still to do on the Pi: make the camera Wi-Fi (NETWORKING.md step 2), pull the new code, restart the station.

---

## 2026-11-08 — How to format the camera's microSD card on a Mac
**Asked by:** [who?] · **Written by:** Claude · **Guide:** `../camera/INSTALL.md` step 1
- The camera needs the card in **FAT32**, 32 GB or smaller. On a Mac: Disk Utility → View → Show All Devices → pick the whole card → Erase → Format **MS-DOS (FAT)**, Scheme **Master Boot Record**, Name `CAMERA`.
- Not tried on our card yet. [result: not yet]

---

## 2026-11-02 — Parts list for the whole project (for the app's Innovation Project Details)
**Asked by:** Coach CJ · **Put together by:** Claude, from the Oct 3 and Oct 12 entries and the Pi plan · **In the app:** Innovation Project → Innovation Project Details (`app/db/updates/2026-11-02-ip-details.sql`)

| Box | Part | How many | Status | Note |
|---|---|---|---|---|
| Camera box | Seeed Studio XIAO ESP32-S3 Sense | — | Bought Oct 12 | |
| Camera box | AM312 mini PIR motion sensor (HC-SR312) | 5-pack | Bought Oct 12 | |
| Camera box | DS3231 AT24C32 I2C clock module (with jumper wires) | 2-pack | Bought Oct 12 | The second one can go on the Pi |
| Camera box | 32 GB high-endurance microSD (FAT32) | — | Need | Oct 12 "still need" list |
| Camera box | SPDT mini toggle switch | — | Need | Mode switch |
| Camera box | CR2032 coin cell | — | Need | Only if the clock didn't come with one |
| Camera box | Waterproof box + USB-C panel jack (or short USB-C extension) | — | Need | |
| Camera box | Breadboard + jumper wires | — | Need | For testing |
| Camera box | LED + 220 Ω resistor | 1 each | Optional | Status light |
| Solar box | ZPSHYD 6V 3W solar panel (DC5521) | — | Bought Oct 12 | |
| Solar box | Waveshare Solar Power Manager (D) | — | Bought Oct 12 | |
| Solar box | 2600 mAh 3.7 V button-top 18650 | 2-pack | Shipping | Delayed (Oct 12) |
| Pi Camera Station | Raspberry Pi 4 Model B, 8 GB | 1 | Have (Oct 3) | |
| Pi Camera Station | microSD card for the Pi | 1 | Have (Oct 3) | A USB SSD lasts longer |
| Pi Camera Station | 7" Raspberry Pi Touchscreen | — | Not sure | [unclear: do we have it yet?] |
| Pi Camera Station | USB Wi-Fi adapter with antenna (~$30) | — | Later | Only for two radios at once (NETWORKING.md setup 2) |
| Pi Camera Station | "m5cam" camera module | — | Have (Oct 3) | Not in the current plan |

[unclear: the "Need" rows are the Oct 12 still-need list. Some may have been bought for the Oct 23 wiring / Nov 1 soldering. Tell Claude what came in and it gets updated.]

**Wiring:** the app's diagram is drawn from the Oct 12 wiring table below (one row per wire). It also marks which wires the camera v3 code uses today (motion sensor D0, clock SDA/SCL D4/D5); the mode switch (D1), status light (D2) and clock alarm (D3) are wired in the plan but not in the code yet.
**Install guides:** camera → `../camera/INSTALL.md` (new, gathers the Oct 23 Arduino steps + v3 setup); Pi → `../pi/INSTALL.md` + `../pi/NETWORKING.md`; website → `../droplet/INSTALL.md` (placeholder plan, nothing built).

---

## 2026-11-01 — Soldering (Nolan + Weston)
**Told by:** Adeline · "Nolan and Weston did soldering for innovation."
- First soldering on the camera build. [unclear: which parts were soldered (motion sensor, clock, switch, headers)? Tested after?]
- Photos (sent 2026-11-02): `../app/images/11-1-soldering-1.jpg`, `../app/images/11-1-soldering-2.jpg` (soldering iron, helping-hands magnifier, small breadboard with jumper wires).

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
