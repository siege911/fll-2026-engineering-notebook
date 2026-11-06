# Installing the camera code on the XIAO ESP32-S3 Sense

For **camera v3** (`camera-v3/`), from a Mac with Arduino IDE 2. Takes about 20 minutes the first time. Parts and wiring: `../updates/CAMERA-BUILD.md`.

## 1. Before you plug in

- Clip the **antenna** onto the XIAO, and snap the **camera board** on top.
- Put a **microSD card** (FAT32, 32 GB or smaller) in the camera board's slot. No card? The live view still works, but nothing is saved.
- Wiring: motion sensor OUT → **D0**, + → 3V3, − → GND. The clock module is optional (SDA → D4, SCL → D5).

## 2. Set up Arduino IDE (once per computer)

1. Install **Arduino IDE 2** from arduino.cc and drag it to Applications.
2. Arduino IDE → **Settings** → "Additional boards manager URLs", paste:
   `https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json`
3. **Boards Manager** (left sidebar) → search **esp32** → install **esp32 by Espressif Systems** (the code was checked with 3.3.12).
4. No extra libraries are needed for v3. Everything it uses comes with the esp32 package.

## 3. Pick the board

Plug the XIAO in with a **USB-C data cable** (some charge-only cables don't carry data). If the Mac asks "Allow accessory to connect?", click **Allow**.

| Tools menu | Pick |
|---|---|
| Board | esp32 → **XIAO_ESP32S3** |
| Port | `/dev/cu.usbmodem…` |
| PSRAM | **OPI PSRAM** (the camera needs it) |

**First time only:** check the board works with File → Examples → 01.Basics → **Blink** → Upload. The small orange light blinks.

## 4. Fill in secrets.h

1. Open `camera-v3/camera-v3.ino` in Arduino IDE.
2. Copy `secrets.example.h` to **`secrets.h`** in the same folder (on the Mac it's already there, filled in).
3. Check the four lines:

| Line | What goes there |
|---|---|
| `WIFI_NAME`, `WIFI_PASSWORD` | the **Pi's camera Wi-Fi** (`RootedWarriorsCam`), not the house Wi-Fi |
| `PI_URL` | `http://10.42.0.1:8080` (the Pi on its camera Wi-Fi) |
| `CAMERA_KEY` | the same key as `camera_key` in the Pi's `pi/settings.json` |

`secrets.h` never goes on GitHub, so the passwords stay private.

## 5. Upload

1. Click **Upload** (→ arrow). It takes a minute or two.
2. Open **Serial Monitor** at **115200** baud. You should see `Rooted Warriors Wildlife Camera v3 starting...`, then the microSD card and clock lines.
3. If the Pi's camera Wi-Fi is on, it prints the **live page** address (or use `http://rooted-camera.local`). Open it on a device that's on the camera Wi-Fi.

## 6. Test it

1. Wait about **30 seconds** after power-on: the motion sensor needs to settle.
2. Wave a hand in front of it: **🔥 Motion sensor** and **📷 Picture changed** both light up on the live page.
3. Walk past at a distance and check saved pictures appear (the live page counts them, and the Pi's touchscreen shows them arriving).
4. Wind or shadows setting it off? Make `AREA_CHANGE` bigger at the top of the code. Missing animals? Make it smaller.

## If something goes wrong

| What you see | Try this |
|---|---|
| Upload fails, or the port disappears | Hold **B** (BOOT), press and let go of **R** (RESET), let go of B, upload again. Press R when it's done |
| `Camera didn't start` | Tools → PSRAM → OPI PSRAM, and check the camera board is snapped on |
| `No microSD card found` | Card in all the way? Formatted FAT32? |
| `The Pi says the camera key is wrong` | `CAMERA_KEY` in secrets.h must match `camera_key` in the Pi's settings.json |
| `Out of range of the Pi` | Normal when the Pi is on 🌐 House Wi-Fi or far away. Pictures wait on the card and go when it's back |

## Older versions

`camera-v1/` (Oct 24: live view + motion sensor) and `camera-v2/` (Oct 25: saves to microSD, the Pi pulls pictures) install the same way. v2's `secrets.h` uses the **house** Wi-Fi instead.
