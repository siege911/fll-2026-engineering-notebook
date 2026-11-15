// Copy this file to secrets.h (same folder) and fill it in.
// secrets.h is not saved to GitHub, so the passwords stay private.

// The Pi's camera Wi-Fi (see pi/NETWORKING.md), not the house Wi-Fi.
#define WIFI_NAME     "RootedWarriorsCam"
#define WIFI_PASSWORD "same-password-as-the-pi-camera-wifi"

// The Pi's address on its camera Wi-Fi, and the Camera Station's port.
#define PI_URL        "http://10.42.0.1:8080"

// Must match camera_key in the Pi's pi/settings.json.
#define CAMERA_KEY    "make-up-a-long-random-key"
