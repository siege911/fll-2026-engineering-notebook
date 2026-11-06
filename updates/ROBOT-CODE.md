# Robot Code — history of our programs

The robot's Pybricks programs, practice by practice. The code itself lives in `../code/` (one folder per practice, named `M-D`, e.g. `code/11-1/`, holding the Pybricks backup zips and/or loose `.py` files). The app's **Coding → Our Robot Code** card reads that folder directly, so a new practice folder shows up in the app by itself. This file is the written record of what the folder held, so the history survives even without the app. **Newest at top.**

**How to add code after a practice:** in Pybricks, back up all programs (it makes a `pybricks-backup-….zip`), make a new folder in `code/` named with the practice date (`11-5` for Nov 5), and put the zip in it. Don't rename the files inside: the app gets the mission number from the name (`mission4.py` → M04, `mission2_3.py` → M02 + M03).

Who coded what is kept in `ROBOT-GAME.md` / `ROBOT-DESIGN.md` and the app's mission list; the code files don't record names.

---

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
