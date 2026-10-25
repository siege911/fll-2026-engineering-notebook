#!/usr/bin/env python3
"""Rooted Warriors Wildlife Camera — pull collector (backup way).

Camera v3 sends ("pushes") its pictures to the Camera Station by itself,
so most of the time you don't need this. Use it for a camera running the
older v2 code, which waits for the Pi to come and get its pictures.

It copies each saved picture off the camera over Wi-Fi, hands it to the
Camera Station (same as if the camera had pushed it), and only then tells
the camera to delete it. Built-in Python only.

Settings come from ../pi/settings.json (camera_key, port) plus:
  "camera_url": "http://rooted-camera.local"
Run it by hand, or every few minutes from cron (see INSTALL.md).
"""

import json
import sys
import urllib.parse
import urllib.request
from datetime import datetime
from pathlib import Path

HERE = Path(__file__).resolve().parent
TIMEOUT = 20  # seconds


def say(message):
    print(f"{datetime.now():%Y-%m-%d %H:%M:%S}  {message}", flush=True)


def load_settings():
    path = HERE / "settings.json"
    if not path.exists():
        sys.exit(f"Missing {path}. Copy settings.example.json to settings.json and fill it in.")
    settings = json.loads(path.read_text())
    settings.setdefault("camera_url", "http://rooted-camera.local")
    settings["camera_url"] = settings["camera_url"].rstrip("/")
    settings["station_url"] = f"http://localhost:{settings.get('port', 8080)}"
    return settings


def get(url):
    with urllib.request.urlopen(url, timeout=TIMEOUT) as response:
        return response.read()


def post(url, data=b"", kind="application/octet-stream"):
    request = urllib.request.Request(url, data=data, method="POST", headers={"Content-Type": kind})
    with urllib.request.urlopen(request, timeout=TIMEOUT) as response:
        return response.status == 200


def collect(settings):
    camera, station, key = settings["camera_url"], settings["station_url"], settings["camera_key"]
    copied = 0
    while True:
        files = json.loads(get(f"{camera}/files"))["files"]
        if not files:
            break
        progress = False
        for item in files:
            camera_path, size = item["f"], item["size"]
            data = get(f"{camera}/download?" + urllib.parse.urlencode({"f": camera_path}))
            if len(data) != size:
                say(f"Skipped {camera_path}: got {len(data)} of {size} bytes, will try next time")
                continue
            name = camera_path.rsplit("/", 1)[-1]
            if not post(f"{station}/api/upload?" + urllib.parse.urlencode({"name": name, "key": key}), data, "image/jpeg"):
                say(f"The Camera Station didn't take {name}")
                continue
            copied += 1
            if post(f"{camera}/delete?" + urllib.parse.urlencode({"f": camera_path, "key": key})):
                progress = True
        if not progress:
            break  # nothing could be deleted, so the list won't shrink; stop for now
    return copied


def main():
    settings = load_settings()
    try:
        copied = collect(settings)
    except OSError as error:
        say(f"Camera or station not reachable ({error}). Will try next time.")
        return 1
    say(f"Copied {copied} pictures to the Camera Station.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
