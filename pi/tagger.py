#!/usr/bin/env python3
"""Rooted Warriors Wildlife Camera — Pi tagger.

Looks at every new picture the collector copied and asks SpeciesNet
(Google's camera-trap AI: MegaDetector finds animal / person / vehicle,
then a classifier names the species) what's in it. Then:

  animal  -> stays in photos/<date>/, species written in tags.csv
  person  -> people are blurred, the unblurred original is deleted
  vehicle -> treated like a person (could show a license plate)
  empty   -> moved to photos/empty/ and deleted after a week
             (kept for a while so the team can check the "false alarms")

Every result goes in photos/tags.csv, with which trigger saved it
(S = motion sensor, C = picture changed, SC = both): that's the data for
the team's "picture changed vs. motion sensor" experiment.

Needs SpeciesNet in a virtual environment (see pi/README.md). Run it after
the collector, e.g. from the same cron line.

Testing without the AI:  python3 tagger.py --use-predictions predictions.json
"""

import argparse
import csv
import fcntl
import json
import re
import shutil
import subprocess
import sys
import tempfile
import time
from datetime import datetime
from pathlib import Path

HERE = Path(__file__).resolve().parent
PHOTO_NAME = re.compile(r"^(\d{4}-\d{2}-\d{2})_(\d{2})-(\d{2})-(\d{2})_(S|C|SC)\.jpg$")
TAG_FIELDS = ["file", "time", "trigger", "result", "species", "confidence", "animals", "people", "vehicles"]


def say(message):
    print(f"{datetime.now():%Y-%m-%d %H:%M:%S}  {message}", flush=True)


def load_settings():
    path = HERE / "settings.json"
    settings = json.loads(path.read_text()) if path.exists() else {}
    settings["photos_dir"] = (HERE / settings.get("photos_dir", "photos")).resolve()
    settings.setdefault("country", "USA")
    settings.setdefault("admin1_region", "AZ")
    settings.setdefault("min_confidence", 0.2)   # MegaDetector boxes below this are ignored
    settings.setdefault("keep_empty_days", 7)
    return settings


def already_tagged(tags_file):
    if not tags_file.exists():
        return set()
    with tags_file.open(newline="") as f:
        return {row["file"] for row in csv.DictReader(f)}


def new_photos(photos_dir, done):
    photos = []
    for day in sorted(photos_dir.glob("[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]")):
        for photo in sorted(day.glob("*.jpg")):
            name = f"{day.name}/{photo.name}"
            if name not in done and PHOTO_NAME.match(photo.name):
                photos.append(photo)
    return photos


def run_speciesnet(photos, settings):
    """Runs SpeciesNet on copies of the photos in a work folder.
    Returns {photo file name: prediction}."""
    with tempfile.TemporaryDirectory() as work:
        work = Path(work)
        inbox = work / "photos"
        inbox.mkdir()
        for photo in photos:
            shutil.copy2(photo, inbox / photo.name)  # names include the date, so they never clash
        out_file = work / "predictions.json"
        command = [
            sys.executable, "-m", "speciesnet.scripts.run_model",
            "--folders", str(inbox),
            "--predictions_json", str(out_file),
            "--country", settings["country"],
            "--admin1_region", settings["admin1_region"],
        ]
        subprocess.run(command, check=True)
        return read_predictions(out_file)


def read_predictions(path):
    data = json.loads(Path(path).read_text())
    return {Path(p["filepath"]).name: p for p in data.get("predictions", [])}


def name_from_label(label):
    # "...;mammalia;artiodactyla;cervidae;odocoileus;hemionus;mule deer" -> "mule deer"
    return label.split(";")[-1].strip() if label else ""


def species(prediction, animals):
    """The species and its score: from the image's overall answer if SpeciesNet gives one,
    otherwise from the most confident animal box."""
    if prediction.get("prediction"):
        return name_from_label(prediction["prediction"]), prediction.get("prediction_score", 0)
    for d in animals:  # already sorted most confident first
        found = d.get("processed_classification") or {}
        if found.get("class"):
            return name_from_label(found["class"]), found.get("score", 0)
    return "", 0


def boxes(prediction, kind, min_confidence):
    return [d for d in prediction.get("detections", [])
            if d.get("label") == kind and d.get("conf", 0) >= min_confidence]


def blur_boxes(photo, found):
    """Blurs each box (plus a margin) so people can't be recognized."""
    from PIL import Image, ImageFilter
    image = Image.open(photo).convert("RGB")
    w, h = image.size
    for d in found:
        x, y, bw, bh = d["bbox"]  # fractions of the picture: left, top, width, height
        mx, my = bw * 0.15, bh * 0.15
        box = (max(0, int((x - mx) * w)), max(0, int((y - my) * h)),
               min(w, int((x + bw + mx) * w)), min(h, int((y + bh + my) * h)))
        if box[2] > box[0] and box[3] > box[1]:
            region = image.crop(box).filter(ImageFilter.GaussianBlur(radius=max(12, (box[2] - box[0]) // 6)))
            image.paste(region, box)
    temp = photo.with_suffix(".part")
    image.save(temp, "JPEG", quality=90)
    temp.replace(photo)  # the unblurred original is gone


def tag_photo(photo, prediction, settings, photos_dir):
    match = PHOTO_NAME.match(photo.name)
    day, hh, mm, ss, trigger = match.groups()
    animals = boxes(prediction, "animal", settings["min_confidence"])
    people = boxes(prediction, "human", settings["min_confidence"])
    vehicles = boxes(prediction, "vehicle", settings["min_confidence"])
    name, score = species(prediction, animals)

    if people or vehicles:
        blur_boxes(photo, people + vehicles)
    if animals:
        result = "animal"
    elif people:
        result = "person"
    elif vehicles:
        result = "vehicle"
    else:
        result = "empty"
        empty_dir = photos_dir / "empty" / day
        empty_dir.mkdir(parents=True, exist_ok=True)
        shutil.move(str(photo), empty_dir / photo.name)

    return {
        "file": f"{day}/{photo.name}",
        "time": f"{day} {hh}:{mm}:{ss}",
        "trigger": trigger,
        "result": result,
        "species": name if result == "animal" else "",
        "confidence": f"{score:.2f}" if result == "animal" else "",
        "animals": len(animals),
        "people": len(people),
        "vehicles": len(vehicles),
    }


def clean_old_empties(photos_dir, days):
    cutoff = time.time() - days * 86400
    for photo in (photos_dir / "empty").glob("*/*.jpg"):
        if photo.stat().st_mtime < cutoff:
            photo.unlink()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--use-predictions", help="use a SpeciesNet predictions.json instead of running the AI (for testing)")
    args = parser.parse_args()

    settings = load_settings()
    photos_dir = settings["photos_dir"]
    photos_dir.mkdir(parents=True, exist_ok=True)

    # Tagging can take a while; never run two at once.
    lock = open(photos_dir / ".tagger.lock", "w")
    try:
        fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
    except BlockingIOError:
        say("Tagger is already running.")
        return 0

    tags_file = photos_dir / "tags.csv"
    photos = new_photos(photos_dir, already_tagged(tags_file))
    if photos:
        say(f"Tagging {len(photos)} new pictures...")
        predictions = read_predictions(args.use_predictions) if args.use_predictions else run_speciesnet(photos, settings)
        rows = []
        for photo in photos:
            prediction = predictions.get(photo.name)
            if prediction is None or prediction.get("failures"):
                say(f"No answer for {photo.name}, will try next time")
                continue
            rows.append(tag_photo(photo, prediction, settings, photos_dir))
        if rows:
            write_header = not tags_file.exists()
            with tags_file.open("a", newline="") as f:
                writer = csv.DictWriter(f, fieldnames=TAG_FIELDS)
                if write_header:
                    writer.writeheader()
                writer.writerows(rows)
        counts = {}
        for row in rows:
            counts[row["result"]] = counts.get(row["result"], 0) + 1
        say("Tagged: " + (", ".join(f"{n} {k}" for k, n in sorted(counts.items())) or "nothing"))
    clean_old_empties(photos_dir, settings["keep_empty_days"])
    return 0


if __name__ == "__main__":
    sys.exit(main())
