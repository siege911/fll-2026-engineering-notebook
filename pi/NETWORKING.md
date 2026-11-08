# Pi networking: camera Wi-Fi + house Wi-Fi

The Pi has two network jobs:

```
 Camera ))) camera Wi-Fi "RootedWarriorsCam" ))) [Pi 4] ))) house Wi-Fi ))) internet → our website
           (Pi is the router: 10.42.0.1)                  (Pi is a normal client)
```

- **Camera Wi-Fi:** the Pi makes its own network. The camera joins it (that's what goes in the camera's `secrets.h`), gets an address from the Pi, and sends photos to `http://10.42.0.1:8080`. It works anywhere the Pi is, even with no house Wi-Fi nearby.
- **House Wi-Fi (🌐):** the Pi joins a Wi-Fi it already remembers, like a laptop, for the internet (publishing to the website, the correct time, updates). It can be the house, the office, or a phone hotspot: 🌐 picks whichever remembered Wi-Fi is in range, strongest signal first.

## Pick a setup

| Setup | Parts | Camera can send | Internet | Notes |
|---|---|---|---|---|
| **1. One radio with a switch** (start here) | none | in **Camera Wi-Fi** mode | in **House Wi-Fi** mode | A button on the touchscreen flips between the two. It stays in the mode you picked. Publishing switches to House Wi-Fi by itself |
| 2. Two radios | USB Wi-Fi adapter with an antenna (~$30) | always | always | Upgrade later if the switching gets annoying. Better camera range too |
| 3. Ethernet | a network cable to the router | always | always | Only if the Pi sits near the router |

The Pi 4's one built-in radio *can* run a hotspot and join a network at the same time, but only on one channel, and it drops out when the house router changes channel. That's why setup 1 switches instead of doing both.

**Why switching is OK:** camera v3 keeps saving photos on its card when it can't reach the Pi, and sends them all when Camera Wi-Fi is back. Nothing is lost; photos just arrive later.

---

## Setup 1: one radio with a switch

### 1. Teach the Pi your Wi-Fi networks

Join each Wi-Fi you'll use (house, office, phone hotspot) **once**, with the Pi's own Wi-Fi menu (top-right of the desktop) or Raspberry Pi Imager (it calls that one `preconfigured`). The Pi remembers them. Later, 🌐 House Wi-Fi joins whichever remembered one is in range. Nothing else to set up, and no names to type in settings.

New Wi-Fi networks start at priority 0, lower than the camera Wi-Fi (10, next step), so the Pi still starts up in 📡 Camera Wi-Fi mode.

(No desktop? `sudo nmcli device wifi connect "WIFI-NAME" password "WIFI-PASSWORD" ifname wlan0`.)

### 2. Camera Wi-Fi on the same radio

The camera Wi-Fi password is the `WIFI_PASSWORD` in `camera/camera-v3/secrets.h` (Claude generated one; or make your own and change it in both places).

```bash
sudo nmcli connection add type wifi ifname wlan0 con-name camera-wifi autoconnect yes \
  connection.autoconnect-priority 10 \
  ssid RootedWarriorsCam \
  802-11-wireless.mode ap 802-11-wireless.band bg 802-11-wireless.channel 6 \
  ipv4.method shared ipv4.addresses 10.42.0.1/24 ipv6.method disabled \
  wifi-sec.key-mgmt wpa-psk wifi-sec.proto rsn wifi-sec.pairwise ccmp wifi-sec.group ccmp \
  wifi-sec.psk "THE-CAMERA-WIFI-PASSWORD"
```

What that does:
- `mode ap`: the Pi *makes* a network instead of joining one.
- `band bg`, `channel 6`: 2.4 GHz, the only band the camera's XIAO can use, and it reaches farther than 5 GHz.
- `ipv4.method shared`: the Pi hands out addresses (DHCP) to the camera (10.42.0.x) and is its router.
- `autoconnect-priority 10`: higher than the house Wi-Fi, so the Pi starts in Camera Wi-Fi mode.

⚠️ **If you're connected over SSH through the house Wi-Fi,** the next step will cut you off. Do it on the Pi's own screen with a keyboard, or be ready to reconnect through the camera Wi-Fi (below).

```bash
sudo nmcli connection up camera-wifi
```

### 3. Let the station flip the switch

The station runs as your user, and NetworkManager needs permission for that user to switch networks. First test whether you already have it:

```bash
nmcli connection show                 # the names of your remembered Wi-Fi networks
nmcli connection up "ONE-OF-THOSE"    # no sudo. "Not authorized"? Then install the rule below.
nmcli connection up camera-wifi
```

If it said "Not authorized":
```bash
sed "s/PIUSER/$USER/" ~/rooted-warriors/pi/station/50-camera-station.rules | sudo tee /etc/polkit-1/rules.d/50-camera-station.rules
sudo systemctl restart polkit
```

### 4. Turn on the switch in settings

In `pi/settings.json`:
```json
"wifi_switch": true,
"camera_connection": "camera-wifi",
"house_connection": "",
"auto_return_minutes": 0
```
`house_connection` blank = any remembered Wi-Fi in range. (Put one connection's name there only if you want it tried first when several are in range.)

Restart the station (`sudo systemctl restart camera-station`). The Home page now shows **📡 Camera Wi-Fi | 🌐 House Wi-Fi**.

### Using it

| Mode | What works | What doesn't |
|---|---|---|
| 📡 **Camera Wi-Fi** (normal) | camera sends photos, Live view, tagging, reviewing | internet, publishing, SSH from the Mac over the house Wi-Fi |
| 🌐 **House Wi-Fi** | internet, publishing, updates, SSH from the Mac | the camera can't send (photos wait on its card), no Live view |

- Switching takes 5–20 seconds.
- **It stays in the mode you picked.** After publishing or updates, remember to tap **📡 Camera Wi-Fi** so the camera can send again (its photos wait on its card until then). (Want it to go back by itself? Set `auto_return_minutes` to e.g. `15`. It's `0`, off, to start.)
- **Publish** on the Publish page switches to 🌐 House Wi-Fi by itself, so the photos can go to the website.
- 🌐 shows which Wi-Fi it joined, e.g. *Internet is on (CityGuest)*.
- If no remembered Wi-Fi is in range, or joining fails (wrong password), it goes straight back to Camera Wi-Fi and shows why. At a new place, join its Wi-Fi once in the Pi's Wi-Fi menu (step 1).
- **`unknown connection 'camera-wifi'`?** Step 2 (making the camera Wi-Fi) hasn't been done on this Pi yet.
- **Getting to the Pi from the Mac in Camera Wi-Fi mode:** join the Mac to **RootedWarriorsCam**, then `ssh <user>@10.42.0.1`, and the station is at `http://10.42.0.1:8080`.

### ⏰ The Pi's clock

The Pi 4 has no clock battery. It normally gets the time from the internet, but in Camera Wi-Fi mode it has no internet, and it gives its time to the camera. After a reboot its clock can be off until it gets internet again. Two fixes:
- **Easy:** after the Pi starts up, tap 🌐 House Wi-Fi for a minute, then switch back.
- **Better:** wire the team's **second DS3231 clock module** (it came as a 2-pack) to the Pi: VCC → pin 1 (3.3V), SDA → pin 3, SCL → pin 5, GND → pin 6. Add `dtoverlay=i2c-rtc,ds3231` to `/boot/firmware/config.txt` and reboot. Check with `sudo hwclock -r`. The Pi then keeps time through reboots, like the camera does.

---

## Setup 2: two radios (USB Wi-Fi adapter)

The adapter must support **AP mode** with a driver built into Linux. MediaTek "mt76" adapters work out of the box, e.g. **Alfa AWUS036ACHM** (MT7610U, long range) or **AWUS036ACM** (MT7612U). Check after plugging it in:

```bash
iw list | grep -A8 "Supported interface modes"   # look for "* AP"
nmcli device                                     # should list wlan0 and wlan1
```

Then follow setup 1, steps 1–2, but put the camera Wi-Fi on the adapter: use `ifname wlan1` in the `nmcli connection add` command. Both connections stay up all the time. In `settings.json`, set `"wifi_switch": false` (no switch needed).

If you set up the switch first and add the adapter later: `sudo nmcli connection modify camera-wifi connection.interface-name wlan1`, then `"wifi_switch": false`.

## Setup 3: Ethernet

Plug in the network cable (it connects by itself), and do setup 1, step 2 (camera Wi-Fi on `wlan0`). `"wifi_switch": false`.

---

## Check it

```bash
nmcli device                 # which connection each radio is using
ip -4 addr show wlan0        # in Camera Wi-Fi mode: inet 10.42.0.1/24
```

- On a phone: the network **RootedWarriorsCam** should appear. Join it and open `http://10.42.0.1:8080` to see the Camera Station.
- Power the camera (v3 code): within a few seconds the station's Home page shows **Camera: Connected**.

## Range tips

- Attach the camera's little antenna (it's much weaker without it).
- Trees and walls eat 2.4 GHz signal. Walk the camera out step by step and watch "Camera: Connected" to find the edge of range. That's a good experiment to write down in the notebook!
- Out of range is fine: the camera keeps saving and sends everything when it's back.

## Undo

```bash
sudo nmcli connection delete camera-wifi
sudo rm -f /etc/polkit-1/rules.d/50-camera-station.rules
```
