# Innovation Project — running notes

Dated facts about the project: problem definition, research sources, experts contacted (name, role, date, what they said), solution ideas and iterations, feedback received and what changed because of it, plan/Gantt progress and who owns each piece. **Newest at top.**

Feeds the app's Innovation Project page. Decisions with a "why" also go in `../DECISIONS.md`.

Backfilled 2026-09-06 from `../DECISIONS.md` and `../PROGRESS.md`.

---

## 2026-11-02 — New "Innovation Project Details" section in the app (Coach CJ asked)
**Asked by:** Coach CJ. At the bottom of the Innovation Project page: **Parts We Ordered** (every part, by box, with status), the **Camera Wiring Diagram** (drawn from the wiring plan, with a wire-by-wire table), and **The Code & How to Install It**: click the camera (ESP32), the Pi, or the website (DigitalOcean) to open its install guide and each code file. The website is a placeholder (not built yet). The page reads the real code files, so it always shows the newest version. Parts list: `CAMERA-BUILD.md` 2026-11-02.

## 2026-11-01 — Camera soldering (Nolan + Weston)
**Told by:** Adeline. Nolan and Weston did soldering for the camera. Details in `CAMERA-BUILD.md`.
**Photos (sent 2026-11-02, [who sent them?]):** "nov 1 we did sodering so put these pictures in innovation progect for the app"
- `app/images/11-1-soldering-1.jpg`: soldering wires on the small breadboard, with the helping-hands magnifier. [unclear: Nolan or Weston?]
- `app/images/11-1-soldering-2.jpg`: one teammate solders while three teammates watch. [unclear: who is in it?]
Shown in the app on the Innovation Project page, **Project Photos** card.

## 2026-10-26 — New "Communication" section: who we shared our project with (Thea asked)
**Asked by:** Thea ("in innovation can you make a new section that is called communication") → picked **"Sharing our project"**: every time we show our project to someone (family, school, experts): date, who we told, who shared, what they said, what we changed.

| Date | Who we shared with | Who shared | What they said | What we changed |
|---|---|---|---|---|
| Oct 5 | Nate Reagan (Arizona Game and Fish) | Whole team | A camera with a flashing light has been done before. Don't live stream. Use AI to blur out people. Cameras spread over a wide area work best. | Oct 25: our Camera Station blurs people, and we review every photo before anything is published. |

## 2026-10-26 — Project Plan (Gantt) filled in from these notes (Thea asked)
**Asked by:** Thea ("for the gantt chart can you fill it out using all the information you have"). Built by Claude from the dated entries in this file and `CAMERA-BUILD.md`. Rows 1–7 are things that already happened (real dates). Rows 8–9 are **suggested** next steps with guessed dates: change them if they're wrong.

| # | Task | Owner | Dates | Versions / steps |
|---|---|---|---|---|
| 1 | Choose the camera design | Thea | Oct 2 – Oct 3 | Oct 2 idea: AI forest wildlife camera · Oct 3 Option B, Raspberry Pi build · Oct 3 research (Gemini): low-power XIAO camera · Oct 3 XIAO camera + Pi 4 gets the pictures over Wi-Fi · Oct 3 two cameras (house + forest) + mode switch |
| 2 | Expert interview: Nate Reagan, Game and Fish | Whole team | Oct 5 | Wrote 5 questions · met Nate, notes and answers saved |
| 3 | Buy the camera parts | Whole team [who? not recorded] | Oct 3 – Oct 12 | Oct 3 parts list · Oct 12 parts bought (batteries delayed) |
| 4 | Wire the camera box | Nolan (Thea helped) | Oct 12 – Oct 23 | Oct 12 wiring plan v1 · Oct 23 Nolan wired it, Thea helped |
| 5 | Decide what to change from Nate's advice | Whole team | Oct 5 – Oct 26 (still open) | Oct 5 open: live stream, bridge or squirrel nest, how many cameras, warning light · Oct 25 people get blurred and the team reviews photos before publishing |
| 6 | Program the camera | Thea | Oct 24 – Oct 26 (still going) | Oct 24 v1: picture every 2 s + motion sensor · Oct 25 v2: picture changed + motion sensor, saves to microSD · Oct 25 v3: sends photos to the Pi · not tested on the real camera yet |
| 7 | Pi Camera Station (with Coach CJ) | Whole team | Oct 25 – Oct 26 | Oct 25 collector · Oct 25 tagger (SpeciesNet), blurs people · Oct 25 Camera Station: visits, review, publish by hand · Oct 26 Camera Wi-Fi / House Wi-Fi switch |
| 8 | Test the camera + Pi for real (**suggested**) | Thea | Oct 27 – Nov 7 (guess) | First real test: camera v3 → Pi |
| 9 | Practice our presentation (**suggested**) | Whole team | Nov 1 – Nov 14 (guess) | Regionals Nov 14 |

## 2026-10-23 — Camera wired (Nolan, Thea helped)
**Told by:** Thea
- **Nolan did the wiring for the camera; Thea helped.** Plan followed: `CAMERA-BUILD.md`. [unclear: how much got wired, and was anything tested?]

## 2026-10-12 — Typed into the app: 8-step tracker set to step 3, Research
- Someone set the Innovation Project 8-step tracker to **step 3, Research** (steps 1–2 show as done) in the app, 2026-10-12 22:58 [who? not recorded by the app].

## Status (as of 2026-10-05)

**Latest: first expert, Nate Reagan (Arizona Game and Fish), Oct 5.** Before that: camera = Seeed XIAO ESP32-S3 Sense; Pi 4 collects the pictures over Wi-Fi (Oct 3).** **Solution idea logged Oct 2 (AI forest wildlife camera); Option B (Raspberry Pi build) picked Oct 3, parts list drafted.** No problem statement logged yet. Research: 2 sources (Gemini, Oct 3; Nate Reagan, Oct 5). Experts: 1.

(Sep 6 status:) **Nothing real recorded yet.** The Innovation Project page in app v3 is entirely sample data and is labelled as such. No problem statement, research, experts, or solution have been logged.

What we do know:
- **Thea** works on the Innovation Project most (from her profile card, Sep 4).
- The students' wish-list for this page (`../App Notes.md`): main page with Problem / Solution / How we got here; definition of problem; collection of research; project plan as a Gantt chart colored by member, click a bar to see pictures over time and iterations based on feedback; experts with pictures, profiles, and what feedback they gave; solution; end-of-practice success calendar.

## First things to capture (when the students bring them)
- The problem they picked, in their words, and how they picked it (the 8 steps in `../01-innovation-project.md`).
- Every research source: what, where, who found it, date.
- Every expert: name, role, date, what they said, what the team changed because of it.
- Solution ideas and each iteration with a date.

---

## 2026-10-25 (later) — The Pi becomes a Camera Station (Coach CJ)
- The Pi makes its own Wi-Fi for the camera, so the camera works far from the house. The camera sends photos to the Pi whenever it's in range.
- The Pi tags every photo with AI and groups photos into **visits**, so the same animal isn't counted over and over.
- **The team reviews every visit on the Pi's touchscreen and chooses what to publish.** Nothing goes online by itself. Details: `CAMERA-BUILD.md`, `../pi/README.md`.

---

## 2026-10-25 — Camera plan v2 (Coach CJ)
- The camera notices animals two ways, **picture changed** and **motion sensor**, and saves a picture to its microSD card only when one fires. The live view stays on its own page. The Pi 4 collects the pictures, tags them, and sends only real animals (people blurred) to the website. Experiment: picture changed vs. motion sensor. Details: `../DECISIONS.md` 2026-10-25, `CAMERA-BUILD.md`.

---

## 2026-10-24 (later) — Camera app v1: Option C picked (Thea)
- **Option C:** the camera sends a picture every 1–2 s plus "motion sensor: yes/no"; the app spots motion, saves pictures, tags animals; the team tests which catches more animals, the app or the sensor (day vs. night, false alarms).
- Mockup 17 made. **Decided (Thea): separate camera app + a small Camera card in the notebook app** that shows highlights and links to it. Hosting: DigitalOcean (Thea; for CJ).

---

## 2026-10-24 — Camera app v1 plan (Thea)
**Told by:** Thea · **Thea is working on the camera programming.**
- Goal: an **online app** the camera streams to. v1 camera is **always on**; using the motion sensor to wake the camera comes in a later version.
- Question: sense motion in the camera (motion sensor) or in the app? Options A/B/C in `../DECISIONS.md` 2026-10-24. **Not decided yet.**

---

## 2026-10-12 — Camera parts bought; camera box wiring plan
**Told by:** [who?]
- **Bought:** solar box = ZPSHYD 6V 3W panel, Waveshare Solar Power Manager (D), 2× 2600 mAh 18650 (delayed). Camera box = XIAO ESP32-S3 Sense, AM312 motion sensors (5), DS3231 clock modules (2).
- **Design kept:** solar box and camera box are two separate options; the camera takes USB-C power from a phone charger or the solar box's USB-C output.
- **Wiring plan v1:** see `CAMERA-BUILD.md` (wiring table, test order, still-to-buy list).

---

## 2026-10-05 — Expert: Nate Reagan, Arizona Game and Fish Department
**Met by:** whole team · **Told by:** Adeline and Thea
- **Who he is:** Nate Reagan, Arizona Game and Fish Department. **First real expert.**
- **Problem facts he gave:** ~300 animal strikes in a year **on I-17** (just I-17, confirmed by Adeline and Thea). The I-17 wildlife bridge is supposed to reduce collisions by 90%. Cost: **$24 million** (the notes said "billion"; corrected by Adeline and Thea).
- **How animals use the bridge:** the babies go where their mom goes, so if the mom crosses the bridge, they will too.
- **How Game and Fish watches animals:** GPS collars on elk (tranquilized to put them on; battery lasts 3 years, then the collar falls off on its own) · a live stream to watch the animals · maybe one camera on the bridge (he's not sure) · officers' satellite cameras that send a notification to a phone · thermal goggles for seeing animals at night · drones for law-enforcement investigations · not a lot of AI.
- **Our questions (prepared by the team):**
  1. How many big crashes happen every year in Flagstaff with the animals? → ~300 animal strikes a year, on I-17.
  2. Idea: the camera sends a blinking light to warn drivers there's an animal crossing. → A camera with a flashing light has been done before.
  3. Do you ever use live stream cameras? → Yes, Game and Fish has a live stream. (But not live streaming our camera prevents bad stuff.)
  4. How long does it take big animals to figure out a new bridge is safe, and to know it's there for them? → They go where their mom goes. [unclear: no time given]
  5. The new I-17 overpass at **Willard Springs**: how will you count the animals: store trail cameras strapped to the bridge, or special expensive equipment? → Might be one camera on the bridge, not sure. [unclear: store vs. special not answered]
- **New solution idea (team):** camera triggers a **blinking light to warn drivers** of an animal crossing. Not decided.
- **His advice for our camera:**
  - A camera with a flashing light has been done before.
  - Not using a live stream prevents bad stuff from happening.
  - Use AI to edit the video or blur out any humans ("end" in the notes meant "edit," confirmed by Adeline and Thea).
  - Cameras over a wide perimeter would be the most effective.
  - We won't get data from Game and Fish, so we get our own.
  - We need ADOT's permission to use the bridge.
  - Backup: if the bridge doesn't work out, put the camera on the squirrel nest and track that.
- **What we change because of it:** not decided yet. Open: live stream on Camera 1 (yes / no / blur people); bridge vs. squirrel nest; one camera or several; night vision. See `../DECISIONS.md` 2026-10-05.
- **Follow-up:** ask ADOT; thank-you note to Nate.

---

## 2026-10-03 — Design: two cameras (house + forest), mode switch, USB-C power
**Told by:** Thea · **Helped by:** Coach CJ
- **Camera 1, house:** plugged into power behind Thea's family's house, faces the forest. For **testing** and **live streaming** over Wi-Fi.
- **Camera 2, forest:** "solar mode," sleeps and wakes on movement. **Collecting pictures:** walk up, flip the switch to "always on mode," the Wi-Fi connects, download, flip back to solar mode.
- **Both** take power through a **USB-C** jack, so the camera box is the same; the solar rig is a separate box.
- **Camera box parts (×2):** Seeed Studio XIAO ESP32S3 Sense (with camera/microSD board + antenna) · 32 GB high-endurance microSD (FAT32) · DS3231 I2C RTC + CR2032 (powered from 3V3 only) · AM312 mini PIR (output → wake-up pin) · SPDT mini toggle switch · waterproof USB-C female panel-mount jack · IP65/IP67 junction box.
- **Solar rig parts (×1):** DFRobot Sunflower Solar Power Manager 5V (DFR0559) · 5 V 3–5 W mono panel (not 12 V) · protected 3.7 V 18650 ~3000 mAh (e.g. Panasonic NCR18650B) + single holder · heavy-duty USB-A to USB-C cable · IP65 box.
- **Claude's check, missing or to plan:** night vision (NoIR camera module + 850 nm IR LEDs); the switch wired as a wake-up too; auto-sleep timeout + status light; forest camera makes its own Wi-Fi hotspot; PIR dome through a hole, lens behind a clear window, sensor hood, silica gel, cable glands; panel in sun, tilted south ~45–50°, snow slides off; no charging below freezing; heat while streaming; measure the real sleep current through the 5 V path; 5 V USB-C wall charger for Camera 1; spare 18650.

---

## 2026-10-03 — Decided: XIAO ESP32-S3 Sense camera; Pi 4 gets the pictures over Wi-Fi
**Told by:** Thea
- **Decision (their words):** "We will use the Seeed Studio XIAO ESP32-S3 Sense Board which has WiFi built into it. We're thinking about using our Raspberry Pi 4 to wirelessly connect to the ESP32 and pull the images directly over WiFi."
- Replaces the Pi-4-in-the-forest plan (Option B). The Pi 4 is reused as the computer that collects the pictures (and could tag the animals).
- **Things to figure out (Claude's check):** Wi-Fi range, roughly 30–100 m outdoors and less through trees; battery life if the camera's Wi-Fi stays on (days, not months), so the fix is to wake on a schedule (DS3231 alarm) or look for the Pi's Wi-Fi every few minutes and send ("push") the pictures. Where the Pi lives: walk-up collect / building near the forest edge / in the forest (big solar again).
- **Test to run:** Wi-Fi range test, in the open and through trees.

---

## 2026-10-03 — Research: low-power camera instead of the Pi 4
**Told by:** Thea · **Research by:** Coach CJ + Thea, using Google Gemini
- **What it said:** the Pi 4 uses 3–5 W nonstop (needs a 50–100 W panel + big battery) and takes 25–35 s to boot, so it can't sleep between animals. Use a **Seeed Studio XIAO ESP32S3 Sense** instead: camera + microSD built in, sleeps at under 20 µA, ~100 mA while capturing.
- **Its parts list:** XIAO ESP32S3 Sense · 32 GB high-endurance microSD · DS3231 clock module + CR2032 coin cell · AM312 mini motion sensor · CN3791 MPPT solar charger (6 V) · 6 V 2–3 W solar panel · protected 3.7 V 18650 battery (~3000 mAh) + single holder · IP65/IP67 box · 3D-printed hood for the motion sensor · 22 AWG wire. Roughly $70–90 (Claude's estimate).
- **Claude's check, gaps to fix:** night vision (NoIR lens + small IR LEDs, ~$10–15); species tagging is too big for the tiny chip (it can do "animal / no animal"), so tag species later on the Pi 4 or the website; no signal in the forest means collect the SD card; the 18650 battery must not charge below freezing either.
- **Options for the team:** A) XIAO only · B) Pi 4 only · C) XIAO in the forest + Pi 4 at home as the AI station. **Not decided yet.**

---

## 2026-10-03 — Picked Option B (Raspberry Pi build) + shopping list
**Told by:** Thea (for the team)
- **Decision:** Option B, Raspberry Pi build. **Have already:** Raspberry Pi 4, "m5cam" module, microSD card. **Goal (their words):** "not expensive, work with the raspberry pie 4 and will keep the whole thing running 24/7."
- **Power math:** Pi 4 + camera + motion sensor + night light ≈ 4–5 W average → about 120 Wh per day. Flagstaff winter ≈ 4–5 hours of strong sun → ~50 W panel minimum, **100 W** to recharge after cloudy/snowy days. Battery for 2 cloudy days ≈ 240 Wh → **12 V 20 Ah LiFePO4**.
- **m5cam note:** probably M5Stack's ESP32 camera — has its own chip and Wi-Fi, can't plug into the Pi 4's camera port. Suggested **Raspberry Pi Camera Module 3 NoIR** for the Pi; the m5cam could be a second, Wi-Fi camera later. [unclear: confirm what the module is]
- **Shopping list Claude suggested (approx. prices, check before buying):** Camera Module 3 NoIR (~$25) · HC-SR501 PIR motion sensors (~$8 for a few) · 850 nm infrared light, 12 V (~$12) + MOSFET switch module (~$5) · 100 W 12 V solar panel (~$70–90; 50 W ~$50 is the cheaper risk) · 10 A PWM solar charge controller with lithium setting, e.g. Renogy Wanderer 10A (~$20–25) · 12 V 20 Ah LiFePO4 battery **with low-temperature charge protection** (~$60–90) · 12 V → 5 V 5 A USB-C step-down converter (~$10–15) · inline fuse holder + 10 A fuse (~$8) · IP65 waterproof box ~12×10×6 in (~$25–35) + cable glands (~$8) · clear acrylic window/silicone · silica gel packs · Pi 4 heatsink case (~$10) · tree strap · 12 V wire. Total ≈ $250–330.
- **Cheaper tradeoff offered:** don't run 24/7 (daytime only or a timer board) → smaller panel and battery.

---

## 2026-10-02 — Solution idea: AI forest wildlife camera
**Told by:** Thea (for the team)
- **Idea (their words):** "making a camera to put in the forest. it needs to have an AI camera to tag animals, solar panels and batteries so it can charge in the sun. we are going to send the images to website we built."
- **Parts they named:** AI camera that tags animals · solar panels · batteries · sends images to the team's website.
- **Materials ideas Claude offered (team to choose):**
  - **Option A — Buy & add:** a ready-made solar cellular trail camera; the team's work is the AI tagging + website. Easiest, least building.
  - **Option B — Raspberry Pi build:** Raspberry Pi + Raspberry Pi AI Camera (tags animals on the camera itself) or Camera Module 3 NoIR + infrared light for night; PIR motion sensor; small solar panel + charge controller + battery pack; waterproof box. Most "we built it."
  - **Option C — Tiny & cheap:** ESP32-CAM board + small solar panel + battery; the website does the animal tagging (e.g., a free wildlife AI model). Cheapest, harder to make work.
  - Every option also needs: waterproof box with clear window, desiccant packs, tree strap (no nails), SD card, and a way to get pictures out of the forest (Wi-Fi, cell signal, or collect the SD card).
- **Questions still open:** the problem statement; how pictures reach the website from the forest; where it will be placed and who gives permission; battery safety with an adult; experts to ask (wildlife biologist, forest ranger, Arizona Game and Fish).

---

(Older entries: none.)
