#!/usr/bin/env python3
"""Rooted Warriors Wildlife Camera — Pi collector.

Copies the saved pictures off the camera's microSD card over Wi-Fi,
checks each one arrived whole, then tells the camera to delete it.
Also keeps a merged copy of the camera's log.csv (which trigger fired).

Run it every 15 minutes (see pi/README.md). Only uses Python's built-in
modules, so there's nothing to install.

Settings come from settings.json next to this file (copy
settings.example.json). The camera key must match CAMERA_KEY in the
camera's secrets.h.
"""

import csv
import io
import json
import sys
import urllib.parse
import urllib.request
from datetime import datetime
from pathlib import Path

HERE = Path(__file__).resolve().parent
TIMEOUT = 20  # seconds


def load_settings():
    path = HERE / "settings.json"
    if not path.exists():
        sys.exit(f"Missing {path}. Copy settings.example.json to settings.json and fill it in.")
    settings = json.loads(path.read_text())
    settings["camera_url"] = settings["camera_url"].rstrip("/")
    settings["photos_dir"] = (HERE / settings.get("photos_dir", "photos")).resolve()
    return settings


def say(message):
    print(f"{datetime.now():%Y-%m-%d %H:%M:%S}  {message}", flush=True)


def get(url):
    with urllib.request.urlopen(url, timeout=TIMEOUT) as response:
        return response.read()


def list_camera_files(camera):
    return json.loads(get(f"{camera}/files"))["files"]


def download(camera, camera_path):
    return get(f"{camera}/download?" + urllib.parse.urlencode({"f": camera_path}))


def delete_on_camera(camera, camera_path, key):
    query = urllib.parse.urlencode({"f": camera_path, "key": key})
    request = urllib.request.Request(f"{camera}/delete?{query}", data=b"", method="POST")
    with urllib.request.urlopen(request, timeout=TIMEOUT) as response:
        return response.status == 200


def local_path_for(photos_dir, camera_path):
    # /photos/2026-10-25/2026-10-25_14-03-22_SC.jpg -> photos/2026-10-25/2026-10-25_14-03-22_SC.jpg
    parts = Path(camera_path).parts
    if len(parts) != 4 or parts[1] != "photos" or ".." in parts:
        raise ValueError(f"Unexpected path from camera: {camera_path}")
    return photos_dir / parts[2] / parts[3]


def collect_photos(settings):
    camera, key, photos_dir = settings["camera_url"], settings["camera_key"], settings["photos_dir"]
    copied = 0
    while True:
        files = list_camera_files(camera)
        if not files:
            break
        progress = False
        for item in files:
            camera_path, size = item["f"], item["size"]
            target = local_path_for(photos_dir, camera_path)
            if not (target.exists() and target.stat().st_size == size):
                data = download(camera, camera_path)
                if len(data) != size:
                    say(f"Skipped {camera_path}: got {len(data)} of {size} bytes, will try next time")
                    continue
                target.parent.mkdir(parents=True, exist_ok=True)
                temp = target.with_suffix(".part")
                temp.write_bytes(data)
                temp.replace(target)
                copied += 1
            if delete_on_camera(camera, camera_path, key):
                progress = True
            else:
                say(f"Camera wouldn't delete {camera_path} (check camera_key)")
        if not progress:
            break  # nothing could be deleted, so the list won't shrink; stop for now
    return copied


def merge_log(settings):
    """Adds new rows from the camera's log.csv to photos/log.csv (no repeats)."""
    try:
        text = download(settings["camera_url"], "/photos/log.csv").decode("utf-8", "replace")
    except Exception as error:
        say(f"Couldn't read the camera's log.csv: {error}")
        return 0
    local_log = settings["photos_dir"] / "log.csv"
    seen = set()
    if local_log.exists():
        with local_log.open(newline="") as f:
            seen = {row["file"] for row in csv.DictReader(f)}
    new_rows = [row for row in csv.DictReader(io.StringIO(text)) if row.get("file") and row["file"] not in seen]
    if new_rows:
        local_log.parent.mkdir(parents=True, exist_ok=True)
        write_header = not local_log.exists()
        with local_log.open("a", newline="") as f:
            writer = csv.DictWriter(f, fieldnames=list(new_rows[0].keys()))
            if write_header:
                writer.writeheader()
            writer.writerows(new_rows)
    return len(new_rows)


def main():
    settings = load_settings()
    try:
        copied = collect_photos(settings)
        logged = merge_log(settings)
    except OSError as error:
        say(f"Camera not reachable at {settings['camera_url']} ({error}). Will try next time.")
        return 1
    say(f"Copied {copied} new pictures, {logged} new log rows.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
