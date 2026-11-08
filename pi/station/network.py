"""Switches the Pi's one Wi-Fi radio between two jobs:

  camera   = the Pi makes the "RootedWarriorsCam" Wi-Fi; the camera can send photos
  internet = the Pi joins a Wi-Fi it already remembers (house, office, phone
             hotspot: whichever is in range); we can publish, get updates, set the clock

Only one at a time. In internet mode the camera keeps saving photos on its
card and sends them when camera mode comes back. The Pi stays in whichever
mode was picked last. (Optional: `auto_return_minutes` in settings.json makes
internet mode go back to camera mode by itself; 0 = off, the default.)

Uses NetworkManager's `nmcli` (see pi/NETWORKING.md, "One radio" setup).
On a computer without nmcli (practice on a laptop) it only pretends.
"""

import re
import shutil
import subprocess
import threading
import time
from datetime import datetime, timedelta


class Network:
    def __init__(self, settings):
        self.camera_connection = settings.get("camera_connection", "camera-wifi")
        # Optional: a remembered Wi-Fi to try first. Blank = any remembered Wi-Fi in range.
        self.house_connection = settings.get("house_connection", "")
        self.auto_return_minutes = settings.get("auto_return_minutes", 0)
        self.pretend = shutil.which("nmcli") is None
        self.pretend_mode = "camera"
        self.switching = None        # "camera" or "internet" while a switch is happening
        self.returns_at = None       # when internet mode switches back by itself
        self.message = ""
        self.wifi_name = ""          # which remembered Wi-Fi we're on in internet mode
        self._ssids = {}             # connection name -> Wi-Fi name
        self._timer = None
        self._lock = threading.Lock()

    def mode(self):
        if self.pretend:
            self.wifi_name = "Practice Wi-Fi" if self.pretend_mode == "internet" else ""
            return self.pretend_mode
        try:
            active = _rows(_nmcli("-t", "-f", "NAME,TYPE", "connection", "show", "--active", timeout=5).stdout)
        except (OSError, subprocess.TimeoutExpired):
            return "unknown"
        names = [r[0] for r in active if len(r) == 2]
        if self.camera_connection in names:
            self.wifi_name = ""
            return "camera"
        wifi = [r[0] for r in active if len(r) == 2 and r[1] == "802-11-wireless"]
        if wifi:
            self.wifi_name = self._ssid(wifi[0])
            return "internet"
        self.wifi_name = ""
        return "off"

    def _ssid(self, connection):
        """The Wi-Fi's real name (e.g. "PerryHome") for a connection name (e.g. "preconfigured")."""
        if connection not in self._ssids:
            try:
                rows = _rows(_nmcli("-t", "-f", "802-11-wireless.ssid", "connection", "show", connection, timeout=5).stdout)
                self._ssids[connection] = ":".join(rows[0][1:]) if rows and len(rows[0]) >= 2 else connection
            except (OSError, subprocess.TimeoutExpired):
                return connection
        return self._ssids[connection] or connection

    def _remembered(self):
        """Remembered Wi-Fi networks (not the camera's): [(connection name, Wi-Fi name)]."""
        out = _nmcli("-t", "-f", "NAME,TYPE", "connection", "show", timeout=10).stdout
        found = []
        for row in _rows(out):
            if len(row) != 2 or row[1] != "802-11-wireless" or row[0] == self.camera_connection:
                continue
            info = _rows(_nmcli("-t", "-f", "802-11-wireless.ssid,802-11-wireless.mode",
                                "connection", "show", row[0], timeout=10).stdout)
            fields = {r[0].split(".")[-1]: ":".join(r[1:]) for r in info if len(r) >= 2}
            if fields.get("mode") == "ap":
                continue  # a Wi-Fi the Pi makes, not one it joins
            found.append((row[0], fields.get("ssid") or row[0]))
        return found

    def _in_range(self):
        """Wi-Fi names the Pi can hear right now, strongest first: {name: signal}."""
        out = _nmcli("-t", "-f", "SSID,SIGNAL", "device", "wifi", "list", "--rescan", "yes", timeout=30).stdout
        heard = {}
        for row in _rows(out):
            if len(row) == 2 and row[0]:
                signal = int(row[1]) if row[1].isdigit() else 0
                heard[row[0]] = max(signal, heard.get(row[0], 0))
        return heard

    def _join_internet(self):
        """Joins the best remembered Wi-Fi in range. Returns (ok, message)."""
        remembered = self._remembered()
        if not remembered:
            return False, "The Pi doesn't remember any Wi-Fi. Join one in the Pi's Wi-Fi menu first."
        # The radio can't look around while it's making the camera Wi-Fi, so turn that off first.
        _nmcli("connection", "down", self.camera_connection, timeout=30)
        time.sleep(2)
        heard = self._in_range()
        nearby = [r for r in remembered if r[1] in heard]
        nearby.sort(key=lambda r: (r[0] != self.house_connection, -heard[r[1]]))
        if not nearby:
            names = ", ".join(sorted({r[1] for r in remembered}))
            return False, f"None of the Wi-Fi the Pi remembers is in range ({names})."
        last = ""
        for connection, _ in nearby:
            result = _nmcli("connection", "up", connection, timeout=60)
            if result.returncode == 0:
                return True, ""
            last = f"{connection}: " + (result.stderr.strip() or result.stdout.strip())
        return False, last

    def status(self):
        return {
            "mode": self.mode(),
            "wifi_name": self.wifi_name,   # filled in by mode()
            "switching": self.switching,
            "returns_at": self.returns_at.strftime("%Y-%m-%d %H:%M:%S") if self.returns_at else None,
            "pretend": self.pretend,
            "message": self.message,
        }

    def switch(self, mode, fallback=False):
        """Starts switching in the background (it takes 5-40 seconds)."""
        if mode not in ("camera", "internet") or self.switching:
            return False
        self.switching = mode
        threading.Thread(target=self._switch, args=(mode, fallback), daemon=True).start()
        return True

    def _switch(self, mode, fallback=False):
        with self._lock:
            if self._timer:
                self._timer.cancel()
                self._timer = None
            self.returns_at = None
            ok = True
            if self.pretend:
                time.sleep(2)
                self.pretend_mode = mode
                self.message = ""
            else:
                try:
                    if mode == "camera":
                        result = _nmcli("connection", "up", self.camera_connection, timeout=60)
                        ok = result.returncode == 0
                        error = "" if ok else (result.stderr.strip() or result.stdout.strip())
                        # After a failed 🌐 try, keep showing why it failed.
                        self.message = f"{self.message} {error}".strip() if fallback else error
                    else:
                        ok, self.message = self._join_internet()
                except (OSError, subprocess.TimeoutExpired) as error:
                    ok, self.message = False, str(error)
                self.message = self.message[:200]
            if ok and mode == "internet" and self.auto_return_minutes:
                self.returns_at = datetime.now() + timedelta(minutes=self.auto_return_minutes)
                self._timer = threading.Timer(self.auto_return_minutes * 60, self.switch, args=("camera",))
                self._timer.daemon = True
                self._timer.start()
            self.switching = None
            if not ok and mode == "internet":
                self.switch("camera", fallback=True)  # couldn't reach the house Wi-Fi: don't leave the camera stranded


def _nmcli(*args, timeout):
    return subprocess.run(["nmcli", *args], capture_output=True, text=True, timeout=timeout)


def _rows(text):
    """Splits nmcli -t output: fields are split on ':', and '\\:' is a ':' inside a field."""
    rows = []
    for line in text.splitlines():
        fields = re.split(r"(?<!\\):", line)
        rows.append([f.replace("\\:", ":").replace("\\\\", "\\") for f in fields])
    return rows
