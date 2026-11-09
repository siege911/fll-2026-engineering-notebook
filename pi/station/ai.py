"""Tagging with SpeciesNet (Google's camera-trap AI).

SpeciesNet runs two models: MegaDetector finds boxes around animals,
people and vehicles, then a classifier names the species. We tell it the
photos are from Arizona so it only picks species that live here.

`fake_predictions` makes up answers so the station can be tried on a
laptop without installing the AI.

Offline: SpeciesNet's normal model name ("kaggle:...") makes it check the
internet every run, even when the model is already downloaded. In 📡 Camera
Wi-Fi mode there's no internet, so we hand it the downloaded folder instead
(`find_local_model`). Then it never goes online.
"""

import hashlib
import json
import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path


def find_local_model():
    """The SpeciesNet model the warm-up test downloaded (the newest one), or None.
    It lives in kagglehub's cache, e.g.
    ~/.cache/kagglehub/models/google/speciesnet/pyTorch/v4.0.3a/1/info.json"""
    cache = Path(os.environ.get("KAGGLEHUB_CACHE") or Path.home() / ".cache" / "kagglehub")
    found = [p.parent for p in (cache / "models" / "google" / "speciesnet").glob("*/*/*/info.json")]
    return str(max(found, key=lambda p: p.stat().st_mtime)) if found else None


def run_speciesnet(paths, country, admin1_region, python=None, model=None):
    """Runs SpeciesNet on copies of the photos. Returns {file name: prediction}.
    model: a downloaded model folder (works with no internet); None = find it."""
    model = model or find_local_model()
    with tempfile.TemporaryDirectory() as work:
        work = Path(work)
        inbox = work / "photos"
        inbox.mkdir()
        for path in paths:
            shutil.copy2(path, inbox / Path(path).name)  # names include the date and time, so they never clash
        out_file = work / "predictions.json"
        subprocess.run([
            python or sys.executable,
            "-X", "faulthandler",  # if it crashes, print where (shows up in journalctl)
            "-m", "speciesnet.scripts.run_model",
            "--folders", str(inbox),
            "--predictions_json", str(out_file),
            "--country", country,
            "--admin1_region", admin1_region,
            *(["--model", model] if model else []),  # no folder found: SpeciesNet downloads it (needs internet)
        ], check=True)
        data = json.loads(out_file.read_text())
        return {Path(p["filepath"]).name: p for p in data.get("predictions", [])}


def explain_error(error):
    """One plain sentence about why tagging failed, for the Problems page."""
    code = getattr(error, "returncode", None)
    if code == -4:
        return "The AI crashed (SIGILL: the Pi's processor was given an instruction it doesn't have)."
    if code is not None and code < 0:
        return f"The AI crashed (signal {-code})."
    text = str(error)
    if "api.kaggle.com" in text or "Failed to resolve" in text:
        return "The AI tried to use the internet (no internet in Camera Wi-Fi mode)."
    if "corrupted" in text:
        return "An AI model file is damaged. Delete it and download it again (pi/INSTALL.md step 4)."
    return f"The AI had a problem: {text[:160]}"


FAKE_SPECIES = ["mule deer", "elk", "abert's squirrel", "gray fox", "wild turkey", "coyote"]


def fake_predictions(paths):
    """Pretend answers for testing. The same few minutes always get the same
    species, so visits form the way they would with real animals."""
    out = {}
    for path in paths:
        name = Path(path).name
        roll = int(hashlib.md5(name.encode()).hexdigest(), 16) % 100
        minute_block = int(name[11:13]) * 60 + int(name[14:16]) if name[0].isdigit() else roll
        species = FAKE_SPECIES[(minute_block // 3) % len(FAKE_SPECIES)]
        detections = []
        if roll < 65:
            for i in range(1 + roll % 3 if roll < 20 else 1):
                detections.append({"label": "animal", "conf": 0.6 + (roll % 30) / 100,
                                   "bbox": [0.1 + 0.25 * i, 0.35, 0.22, 0.4],
                                   "processed_classification": {"class": f"x;mammalia;;;;;{species}", "score": 0.5 + (roll % 45) / 100}})
        elif roll < 75:
            detections.append({"label": "human", "conf": 0.93, "bbox": [0.55, 0.15, 0.2, 0.7]})
        out[name] = {"filepath": str(path), "detections": detections}
    return out


def name_from_label(label):
    # "...;mammalia;artiodactyla;cervidae;odocoileus;hemionus;mule deer" -> "mule deer"
    return label.split(";")[-1].strip() if label else ""


def read_tags(prediction, min_confidence):
    """Turns one SpeciesNet answer into what we store."""
    def boxes(kind):
        return [d for d in prediction.get("detections", []) if d.get("label") == kind and d.get("conf", 0) >= min_confidence]

    animals, people, vehicles = boxes("animal"), boxes("human"), boxes("vehicle")
    species, score = "", 0
    if prediction.get("prediction"):
        species, score = name_from_label(prediction["prediction"]), prediction.get("prediction_score", 0)
    else:
        for d in animals:  # most confident first
            found = d.get("processed_classification") or {}
            if found.get("class"):
                species, score = name_from_label(found["class"]), found.get("score", 0)
                break
    result = "animal" if animals else "person" if people else "vehicle" if vehicles else "empty"
    return {
        "result": result,
        "species": (species or "unknown animal") if result == "animal" else "",
        "confidence": round(score, 2) if result == "animal" else None,
        "animals": len(animals), "people": len(people), "vehicles": len(vehicles),
        "blur": people + vehicles,
    }


def blur_boxes(photo, found):
    """Blurs each box (plus a margin) so people and license plates can't be recognized.
    Overwrites the photo, so the unblurred original is gone."""
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
    temp = Path(photo).with_suffix(".part")
    image.save(temp, "JPEG", quality=90)
    temp.replace(photo)
