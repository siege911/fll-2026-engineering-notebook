# Raspberry Pi 4 — Camera Station

The Pi is the base station for our wildlife camera. It runs its own Wi-Fi for the camera, tags every photo with AI, and lets us review the animals on its touchscreen before we choose what to put on our website.

```
1. Camera sends   →   2. Pi tags   →   3. We review   →   4. We publish
   (camera v3)         (SpeciesNet)      (touchscreen)       (only what we pick)
```

1. **Camera sends.** The camera saves a photo when the motion sensor fires or the picture changes. As soon as it's in range of the Pi's camera Wi-Fi it sends each photo to the Pi, then deletes it from its card. Out of range, photos wait on the card.
2. **Pi tags.** SpeciesNet (Google's camera-trap AI) finds animals, people and vehicles, and names the species (only species found in Arizona). People and vehicles get **blurred** and the original is deleted. Empty photos (false alarms) are set aside and deleted after a week.
3. **We review.** Photos of the same species close together in time are grouped into one **visit**, so one deer standing there for 40 photos counts as one deer, not 40. On the touchscreen we check each visit: right animal? how many? same animal as the visit before? Then **✓ Looks right** or **✗ Hide it**, and tap who checked it.
4. **We publish.** Nothing goes online by itself. On the Publish page we pick which approved visits go on the website. (The website part isn't connected yet; picked visits wait in line.)

The Pi has one Wi-Fi radio, so the Home page has a switch: **📡 Camera Wi-Fi** (the camera can send photos) or **🌐 House Wi-Fi** (internet, for publishing: joins whichever Wi-Fi the Pi remembers is in range, e.g. house, office or phone hotspot). It stays in the mode you pick. **Publish** switches to House Wi-Fi by itself. While on House Wi-Fi the camera keeps its photos on its card, so tap 📡 Camera Wi-Fi when you're done. Tagging keeps going in both modes.

There's also a **Test** page for our experiment: did "picture changed" or the motion sensor catch more animals, and which one had more false alarms?

## Folder map

| File | What it is |
|---|---|
| [INSTALL.md](INSTALL.md) | Setting up the Pi: OS, SpeciesNet, starting at boot, touchscreen kiosk |
| [NETWORKING.md](NETWORKING.md) | The camera Wi-Fi + house Wi-Fi setup |
| `station/server.py` | The Camera Station: receives photos, runs the tagging helper, answers the page |
| `station/ai.py` | Talking to SpeciesNet, blurring people, and the made-up answers for practice mode |
| `station/network.py` | The **📡 Camera Wi-Fi / 🌐 House Wi-Fi** switch (one Wi-Fi radio, two jobs) |
| `station/50-camera-station.rules` | Lets the station flip the Wi-Fi switch |
| `station/store.py` | The station's memory (photos, visits) and **how visits are grouped and counted** |
| `station/public/index.html` | **The touchscreen page.** Change colors, words, buttons, pages here |
| `station/camera-station.service` | Starts the station when the Pi boots |
| `collector.py` | Backup: fetches photos from a camera running the older v2 code |
| `settings.example.json` | Copy to `settings.json` (not on GitHub) |

The camera's code is in `../camera/camera-v3/`.

## Things the team can change (good places to start)

- **The look of the touchscreen page:** `station/public/index.html`. The colors are at the top (`--forest`, `--lavender`, …), the same as our Engineering Notebook.
- **Quick animal buttons:** `QUICK_SPECIES` near the top of the script in `index.html`.
- **When is it "the same animal"?** `visit_gap_minutes` in `settings.json` (10 minutes to start). Scientists often use 30 minutes. Try both and see which matches what you see in the photos!
- **How many animals in a visit:** the station uses the most animals the AI found in any one photo of the visit (scientists call it "MaxN"). You can always fix it with − / + on the Review page.

## Try it without the Pi (on a laptop)

```bash
cd pi/station
python3 server.py --fake-ai --data /tmp/station-practice
```

Open `http://localhost:8080`. Practice mode makes up the AI answers, so you can work on the page without the camera or SpeciesNet. To send it pretend photos, use the camera (with `PI_URL` pointing at the laptop) or ask Claude for a test script.

## Status (Oct 25, 2026)

| Part | Status |
|---|---|
| Camera v3 (push to Pi, time from Pi + clock module) | ✅ compiles · not tested on the real camera |
| Station: receive, tag, blur, visits, review, publish queue, experiment | ✅ tested on a Mac in practice mode (made-up AI answers) |
| SpeciesNet on the Pi | ⬜ not installed or tested yet (INSTALL.md step 4) |
| Networking: one radio + 📡/🌐 switch | ✅ switch tested on a Mac (pretend mode) · ⬜ NETWORKING.md on the real Pi |
| Publishing to the website | ⬜ waits for the DigitalOcean site |
