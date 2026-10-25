# Pi networking: camera Wi-Fi + house Wi-Fi

The Pi does two network jobs at once:

```
 Camera ))) camera Wi-Fi "RootedWarriorsCam" ))) [Pi 4] ))) house Wi-Fi ))) internet → our website
           (Pi is the router: 10.42.0.1)                  (Pi is a normal client)
```

- **Camera Wi-Fi:** the Pi makes its own network. The camera joins it (that's what goes in the camera's `secrets.h`), gets an address from the Pi, and sends photos to `http://10.42.0.1:8080`. It works anywhere the Pi is, even with no house Wi-Fi nearby.
- **House Wi-Fi (or Ethernet):** the Pi joins it like a laptop, for the internet (publishing to the website, time, updates).

## What you need: a second Wi-Fi radio

The Pi 4 has one built-in Wi-Fi radio. It *can* run a hotspot and a client at the same time, but only on one channel, and it drops out when the house router changes channel. So use one of these:

| Option | Camera Wi-Fi on | House network on | Notes |
|---|---|---|---|
| **A (recommended)** | **USB Wi-Fi adapter with an antenna** (`wlan1`) | built-in Wi-Fi (`wlan0`) | Best range to the camera. The antenna can go high or in a window on a USB extension cable |
| B | built-in Wi-Fi (`wlan0`) | Ethernet cable (`eth0`) | No extra parts if the Pi sits near the router |
| C | built-in only, both jobs | | Not recommended (see above) |

For option A, the adapter must support **AP mode** with a driver built into Linux. MediaTek "mt76" adapters work out of the box, e.g. **Alfa AWUS036ACHM** (MT7610U, long range) or **AWUS036ACM** (MT7612U). Check after plugging it in:

```bash
iw list | grep -A8 "Supported interface modes"   # look for "* AP"
nmcli device                                     # should list wlan0 and wlan1
```

The commands below are for **option A**. For option B, use `wlan0` wherever it says `wlan1`, and plug in Ethernet (it connects by itself).

## 1. House Wi-Fi on the built-in radio (wlan0)

If you typed the house Wi-Fi into Raspberry Pi Imager, it's already there, called `preconfigured`. Pin it to the built-in radio so it never grabs the USB adapter:

```bash
nmcli connection show                                   # find the house Wi-Fi connection name
sudo nmcli connection modify preconfigured connection.interface-name wlan0
```

(Not set up yet? `sudo nmcli device wifi connect "HOUSE-WIFI-NAME" password "HOUSE-PASSWORD" ifname wlan0`)

## 2. Camera Wi-Fi on the USB adapter (wlan1)

Pick the camera Wi-Fi password: it's the `WIFI_PASSWORD` in `camera/camera-v3/secrets.h` (Claude generated one; or make your own and change it in both places).

```bash
sudo nmcli connection add type wifi ifname wlan1 con-name camera-wifi autoconnect yes \
  ssid RootedWarriorsCam \
  802-11-wireless.mode ap 802-11-wireless.band bg 802-11-wireless.channel 6 \
  ipv4.method shared ipv4.addresses 10.42.0.1/24 ipv6.method disabled \
  wifi-sec.key-mgmt wpa-psk wifi-sec.proto rsn wifi-sec.pairwise ccmp wifi-sec.group ccmp \
  wifi-sec.psk "THE-CAMERA-WIFI-PASSWORD"
sudo nmcli connection up camera-wifi
```

What that does:
- `mode ap`: the Pi *makes* a network instead of joining one.
- `band bg`, `channel 6`: 2.4 GHz, which is the only band the camera's XIAO can use, and it reaches farther than 5 GHz.
- `ipv4.method shared`: the Pi hands out addresses (DHCP) to the camera (10.42.0.x) and is the router for it.

It comes back by itself after every reboot (`autoconnect yes`).

## 3. Check it

```bash
nmcli device                 # wlan0 connected to the house, wlan1 connected to camera-wifi
ip -4 addr show wlan1        # inet 10.42.0.1/24
```

- On a phone: the network **RootedWarriorsCam** should appear. Join it with the password and open `http://10.42.0.1:8080` to see the Camera Station.
- Power the camera (v3 code): within a few seconds the station's home page shows **Camera: Connected**, and `http://rooted-camera.local` works from the Pi.

## Range tips

- Attach the camera's little antenna (it's much weaker without it).
- Put the Pi's USB adapter antenna up high, in a window facing the camera, on a USB extension cable.
- Trees and walls eat 2.4 GHz signal. Walk the camera out step by step and watch the station's "Camera: Connected" to find the edge of range. That's a good experiment to write down in the notebook!
- Out of range is fine: the camera keeps saving to its card and sends everything when it's back in range.

## Undo

```bash
sudo nmcli connection delete camera-wifi
```
