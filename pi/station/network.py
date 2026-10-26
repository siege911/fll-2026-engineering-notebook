"""Switches the Pi's one Wi-Fi radio between two jobs:

  camera   = the Pi makes the "RootedWarriorsCam" Wi-Fi; the camera can send photos
  internet = the Pi joins the house Wi-Fi; we can publish, get updates, set the clock

Only one at a time. In internet mode the camera keeps saving photos on its
card and sends them when camera mode comes back. The Pi stays in whichever
mode was picked last. (Optional: `auto_return_minutes` in settings.json makes
internet mode go back to camera mode by itself; 0 = off, the default.)

Uses NetworkManager's `nmcli` (see pi/NETWORKING.md, "One radio" setup).
On a computer without nmcli (practice on a laptop) it only pretends.
"""

import shutil
import subprocess
import threading
import time
from datetime import datetime, timedelta


class Network:
    def __init__(self, settings):
        self.camera_connection = settings.get("camera_connection", "camera-wifi")
        self.house_connection = settings.get("house_connection", "preconfigured")
        self.auto_return_minutes = settings.get("auto_return_minutes", 0)
        self.pretend = shutil.which("nmcli") is None
        self.pretend_mode = "camera"
        self.switching = None        # "camera" or "internet" while a switch is happening
        self.returns_at = None       # when internet mode switches back by itself
        self.message = ""
        self._timer = None
        self._lock = threading.Lock()

    def mode(self):
        if self.pretend:
            return self.pretend_mode
        try:
            out = subprocess.run(["nmcli", "-t", "-f", "NAME", "connection", "show", "--active"],
                                 capture_output=True, text=True, timeout=5).stdout.splitlines()
        except (OSError, subprocess.TimeoutExpired):
            return "unknown"
        if self.camera_connection in out:
            return "camera"
        if self.house_connection in out:
            return "internet"
        return "off"

    def status(self):
        return {
            "mode": self.mode(),
            "switching": self.switching,
            "returns_at": self.returns_at.strftime("%Y-%m-%d %H:%M:%S") if self.returns_at else None,
            "pretend": self.pretend,
            "message": self.message,
        }

    def switch(self, mode):
        """Starts switching in the background (it takes 5-20 seconds)."""
        if mode not in ("camera", "internet") or self.switching:
            return False
        self.switching = mode
        threading.Thread(target=self._switch, args=(mode,), daemon=True).start()
        return True

    def _switch(self, mode):
        with self._lock:
            if self._timer:
                self._timer.cancel()
                self._timer = None
            self.returns_at = None
            connection = self.camera_connection if mode == "camera" else self.house_connection
            ok = True
            if self.pretend:
                time.sleep(2)
                self.pretend_mode = mode
            else:
                try:
                    result = subprocess.run(["nmcli", "connection", "up", connection],
                                            capture_output=True, text=True, timeout=60)
                    ok = result.returncode == 0
                    self.message = "" if ok else (result.stderr.strip() or result.stdout.strip())[:200]
                except (OSError, subprocess.TimeoutExpired) as error:
                    ok, self.message = False, str(error)
            if ok and mode == "internet" and self.auto_return_minutes:
                self.returns_at = datetime.now() + timedelta(minutes=self.auto_return_minutes)
                self._timer = threading.Timer(self.auto_return_minutes * 60, self.switch, args=("camera",))
                self._timer.daemon = True
                self._timer.start()
            self.switching = None
            if not ok and mode == "internet":
                self.switch("camera")  # couldn't reach the house Wi-Fi: don't leave the camera stranded
