# Robot Code — history of our programs

The robot's Pybricks programs, practice by practice. The code itself lives in `../code/` (one folder per practice, named `M-D`, e.g. `code/11-1/`, holding the Pybricks backup zips and/or loose `.py` files). The app's **Coding → Our Robot Code** card reads that folder directly, so a new practice folder shows up in the app by itself. This file is the written record of what the folder held, so the history survives even without the app. **Newest at top.**

**How to add code after a practice:** in Pybricks, back up all programs (it makes a `pybricks-backup-….zip`), make a new folder in `code/` named with the practice date (`11-5` for Nov 5), and put the zip in it. Since Nov 15 a folder can also have a name, as long as it **ends with the date**: `Final v2 - Nov 9` (the app shows "Final v2" under the date). A loose `.py` file in a folder wins over a zip copy of the same name (it's the later edit). Don't rename the files inside: the app gets the mission number from the name (`mission4.py` → M04, `mission2_3.py` → M02 + M03).

Who coded what is kept in `ROBOT-GAME.md` / `ROBOT-DESIGN.md` and the app's mission list; the code files don't record names.

---

## 2026-11-15 — Final v1 and Final v2: the mission menu and Fynn's fine-tuning (Nov 2 → Nov 15)
**Told by:** Coach CJ (sent 2026-11-15)
> I updated our "code" folder with the latest Code iterations. Final v1 is just the capture of everything on November 3. Adeline did the main work on Nov 3 to move to the Final v2 which includes the code for selecting the missions during the competition. We tested it on Nov 9. Fynn did the updates on Nov 9 and Nov 13 to the code for Final v3 to fine-tune all of the missions.

**Follow-up, same day (Coach CJ):**
> Does this file have different data? This is the absolute latest backup from the active code so should be v3. If these are the same then just use this as v2 and remove the v3. Fynn did do some fine tuning work be we may not have created the backups at the right time.

**New folders in `code/`:**
- `11-2` (Nov 2): one Pybricks backup (6 programs). It wasn't written up before; it's in the table below.
- `Final v1 - Nov 3`: everything as of **Nov 3** (one backup zip + 9 loose `.py` files). Coach CJ named it `Final v1`; renamed to add "- Nov 3" so the app knows the date (files inside not touched). The loose `mission1.py` and `mission14.py` are newer than the copies in the zip, so the app uses the loose ones.
- `Final v2 - Nov 9`: **the latest code**: Adeline's mission menu (work done Nov 3, tested Nov 9) **with Fynn's fine-tuning already in it** (Nov 9 + Nov 13). It holds the 11 `.py` files and `pybricks-backup-2026-11-15_17-15-27.zip`, the Nov 15 backup of the code on the hub (from CJ's Transcend drive).
- **Why there is no Final v3:** the `Final v2` and `Final v3 - Nov 13` folders held exactly the same files, and the Nov 15 backup of the hub matches them byte for byte too. The backups weren't made between Adeline's menu and Fynn's fine-tuning, so Adeline's version *before* Fynn's changes isn't saved. Coach CJ decided: keep it as **Final v2** and remove v3 (folder moved to the Trash Nov 15). The fine-tuning listed below compares this code with Final v1.

**What changed in v2 (Adeline): one program with a menu, instead of one program per mission**
- **`main_base.py` (new, 132 lines): the mission menu.** Pick a mission with the hub buttons: LEFT / RIGHT change the number, CENTER starts it. While a mission runs, CENTER **stops** it and goes back to the same number. When a mission finishes, the hub jumps to the **next** number with an orange light, so RIGHT or CENTER starts the next run right away. The Bluetooth button quits. Light colors: blue = menu, green = running, orange = ready for next, red = stopped or error (with a beep).
- **`robot.py` (new, 42 lines): the robot set up once.** Ports, wheels (49.5 mm, axle track 160), and three helpers every mission uses: `reset_settings()` before each mission (default speeds, gyro on, heading zeroed), `park()` after (wheels loose, gyro off, so the robot is easy to pick up), `stop_everything()` if a mission is stopped.
- **Every mission file now has a `run()`** that the menu calls, and imports the robot from `robot.py` instead of setting up its own motors. Each file can still run by itself in Pybricks.
- **Programs joined up to match the run plan** (the app shows which old program each one grew from):

| Menu # | Program (v2/v3) | Missions | Grew from (v1) |
|:-:|---|---|---|
| 1 | `mission1.py` | M01 | same file |
| 2 | `mission2_3.py` | M02 + M03 | same file |
| 3 | `mission4_5.py` | M04 + M05 | `mission4.py` |
| 4 | `mission8_9.py` | M08 + M09 | `mission9.py` |
| 5 | `mission14.py` | M14 | same file |
| 6 | `mission12a.py` | M12 part 1 (support tie) | `mission12.py` |
| 7 | `mission15.py` | M15 | same file |
| 8 | `mission13_12b.py` | M13 + M12 part 2 (cane) | `mission13.py` copy B |
| 9 | `mission6_7_11.py` | M06 + M07 + M11 | `mission6_7.py` |

- The menu order is the same as our 9-run plan in the app. [unclear: the run plan says run 5 is **M10 + M14**, but no program has M10 in its name. Is M10 done inside `mission14.py`?]
- `curve(...)` was changed to `arc(...)` in M01, M04, M13, M14 and M06/07/11, with notes like "signs flipped so it drives the same path".
- Bugs that were in v1 `mission6_7.py` are gone in v2: `drivebase.straight(-300)` (small b, would crash) and `driveBase.angle(-600)` (not a drive command) became `straight(-300)` + `arc(275, 130)` + `straight(370)`.
- The comment at the top of `main_base.py` says "Quantum Warriors mission menu". [unclear: old team name, or a typo for Rooted Warriors?]

**Fynn's fine-tuning (Nov 9 + Nov 13, inside Final v2), compared with v1:**
- `mission1.py`: speeds set (600), straight 470 → 520, turn 64 → 65, back-up 750 → 660.
- `mission2_3.py`: **a new path** (old moves kept as comments): 190 → turn 45 → 330 → turn −55 → slow (200) 450 → back 370. Fits "Fynn finished 2 + 3" (Nov 13).
- `mission15.py`: arm moves made smaller (left −140 → −100, right −1000 → −700).
- `mission6_7_11.py`: start back-off and faster speed added, new ending (above).
- `mission4_5.py`, `mission8_9.py`, `mission12a.py`, `mission13_12b.py`, `mission14.py`: same moves as v1, just moved into `run()` (and `curve` → `arc`).

**Also changed Nov 2 → Nov 3 (before v1 was saved):** `mission6_7.py` (Nov 2: new second half, attachment arm moves), `mission12.py` (Nov 3: speed 600, back-up 150 → 160), `mission1.py` and `mission14.py` (Nov 3, the loose files: new distances and turns; M14 starts the right arm early).

**History, Nov 2 → Nov 9** (same symbols as the table below):

| Program | Missions | Nov 2 | Nov 3 (Final v1) | Nov 9 (Final v2) | Versions |
|---|---|:-:|:-:|:-:|:-:|
| `main_base.py` | menu |  |  | 🆕 132 | 1 |
| `robot.py` | robot setup |  |  | 🆕 42 | 1 |
| `mission1.py` | M01 | = 29 | ✏️ 30 | ✏️ 25 | 5 |
| `mission2_3.py` | M02 + M03 | = 25 | = | ✏️ 33 | 3 |
| `mission4.py` → `mission4_5.py` | M04 (+ M05) | = 57 | = | 🆕 57 | 5 + 1 |
| `mission6_7.py` → `mission6_7_11.py` | M06 + M07 (+ M11) | ✏️ 36 | = | 🆕 39 | 2 + 1 |
| `mission9.py` → `mission8_9.py` | (M08 +) M09 |  | = 44 | 🆕 42 | 4 + 1 |
| `mission12.py` → `mission12a.py` | M12 |  | ✏️ 38 | 🆕 29 | 6 + 1 |
| `mission13.py` copy B → `mission13_12b.py` | M13 (+ M12) |  | = 39 | 🆕 35 | 2 + 1 |
| `mission13.py` copy A | M13 | = 36 |  |  | 2 |
| `mission14.py` | M14 | = 29 | ✏️ 31 | ✏️ 31 | 4 |
| `mission15.py` | M15 |  | = 29 | ✏️ 25 | 3 |

**Who:** Final v2 = **Adeline** (menu, `robot.py`, the move to `run()`) + **Fynn** (fine-tuning every mission, Nov 9 + Nov 13). In the app, Fynn was added to "Coded by" on every mission in the menu that didn't list Fynn yet, and Adeline's menu is a new row in "Programs We've Written".
**App:** the Coding page now reads `Final …` folders and shows which old program each new one grew from (`app/robotcode.mjs`, `index.html`); data in `app/db/updates/2026-11-15d-final-code.sql` and `2026-11-15e-no-final-v3.sql`.

## 2026-11-02 — Which `mission13.py` the robot runs: copy B
**Told by:** [who?] (answering the app's question "Which mission13.py does the robot really run?")
> Copy B (Oct 5)

- **The robot runs copy B** of `mission13.py` (M13 Keystone Species): first saved **Oct 5**, changed **Oct 23** (37 → 39 lines), the same at Oct 26 and Nov 1. That's the Oct 23 change, which fits Isla programming M13 that day.
- **Copy A** (first saved Sep 25, last changed Oct 5, 36 lines) is not the one the robot runs. [unclear: an old try? Keep it or delete it from the hub?]
- App: copy B shows "✅ the robot runs this one" (`app/db/updates/2026-11-02-m13-code-copy.sql`).

---

## 2026-11-02 — Code folder added to the app (history Sep 7 → Nov 1)

**Asked by:** [who? typed in Claude Code: "we have all of our code in the code folder. Incorporate it into the app."]

**What's in `code/`:** 8 practice folders (9-7, 9-11, 9-18, 9-25, 10-5, 10-23, 10-26, 11-1), 11 Pybricks backup zips + 5 loose `.py` files = 10 different programs. Same file saved at several practices with no change counts once.

**History** (🆕 = first time saved · ✏️ = changed that practice · = = saved, same as before · blank = not saved that day; number = lines long):

| Program | Missions | Sep 7 | Sep 11 | Sep 18 | Sep 25 | Oct 5 | Oct 23 | Oct 26 | Nov 1 | Versions |
|---|---|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| `mission1.py` | M01 | 🆕 25 | ✏️ 29 | = | = | ✏️ 29 | = | = | = | 3 |
| `mission2_3.py` | M02 + M03 |  |  | 🆕 25 | = | ✏️ 25 | = | = | = | 2 |
| `mission4.py` | M04 |  |  | 🆕 19 | = | ✏️ 19 | ✏️ 31 | ✏️ 51 | ✏️ 57 | 5 |
| `mission6_7.py` | M06 + M07 |  |  |  |  |  |  |  | 🆕 30 | 1 |
| `mission9.py` | M09 |  |  |  |  | 🆕 28 | ✏️ 35 | ✏️ 41 | ✏️ 44 | 4 |
| `mission12.py` | M12 |  | 🆕 25 | ✏️ 30 | ✏️ 32 | ✏️ 30 | ✏️ 34 | = | = | 5 |
| `mission13.py` copy A | M13 |  |  |  | 🆕 36 | ✏️ 36 | = | = | = | 2 |
| `mission13.py` copy B | M13 |  |  |  |  | 🆕 37 | ✏️ 39 | = | = | 2 |
| `mission14.py` | M14 |  |  |  | 🆕 23 | ✏️ 29 | = | = | = | 2 |
| `mission15.py` | M15 |  |  |  | 🆕 30 | ✏️ 29 | = | = | = | 2 |

**18 changes** to programs across the season so far. Biggest iterators: `mission4.py` (changed at 4 practices in a row, 19 → 57 lines) and `mission12.py` (changed at 4 practices).

**Things the code shows about the robot:**
- Every program uses the same setup: left wheel port A (turned around), left attachment motor port B, right wheel port E, right attachment motor port F, 49.5 mm wheels. Most turn the gyro on (not the early `mission2_3.py` and `mission4.py`).
- The wheel spacing number in the code (axle track) changed from **147 to 160 mm** between Sep 25 and Oct 5 (every program saved through Sep 25 says 147; from Oct 5 on they all say 160). [unclear: did the robot get wider, or did someone measure it again?]
- Later programs set speeds (`driveBase.settings(...)`): e.g. `mission4.py` on Nov 1 went from straight speed 400 to 700.

**Doesn't match what the app has (please check):**
- ~~[unclear: there are **two different `mission13.py`** programs in the backups (copy A from Sep 25, copy B from Oct 5; each backup day has two zips). Is one an old try, or two hubs / laptops? Which one does the robot run?]~~ Answered same day: **copy B** (see above).
- [unclear: `mission13.py` was first saved **Sep 25**, but the app says the first M13 program was Isla's on Oct 23.]
- [unclear: `mission9.py` was first saved **Oct 5**, but the app says the first M09 program was Weston's on Oct 23.]
- [unclear: `mission6_7.py` (M06 + M07, 30 lines) was saved **Nov 1**, but the Nov 1 update says M06 and M07 are the only missions left to program. Who started it?]
- [unclear: no program file for **M05, M08, M10, M11**. M05 is probably inside `mission4.py` (M04 + M05 were finished together); M11 was programmed Nov 1 but isn't in that day's backups.]
- The `9-18` folder's zip was made on Sep 25 (date in the zip's name); the app uses the folder name (Sep 18).
