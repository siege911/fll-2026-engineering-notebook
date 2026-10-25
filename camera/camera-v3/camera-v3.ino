// Rooted Warriors Wildlife Camera — version 3
//
// What it does:
//   - Takes a picture every second and shows it live on a web page.
//   - Two ways to notice an animal (or person):
//       1. Motion sensor: felt something warm move since the last picture.
//       2. Picture changed: a big enough part of the picture is different
//          from the picture before it.
//   - When either one fires, saves the picture to the microSD card.
//   - NEW in v3: joins the Pi's camera Wi-Fi and sends ("pushes") every saved
//     picture to the Pi's Camera Station as soon as it can, then deletes it
//     from the card. Out of range? Pictures wait on the card and go when the
//     camera is back in range.
//   - NEW in v3: gets the time from the Pi, and keeps it in the clock module
//     (DS3231) if one is wired, so pictures have the right time even after
//     a power cut in the forest.
//
// Board settings (Tools menu):
//   Board: XIAO_ESP32S3    PSRAM: OPI PSRAM
//
// Wiring (see updates/CAMERA-BUILD.md):
//   Motion sensor OUT -> D0    + -> 3V3    - -> GND
//   Clock (optional)  SDA -> D4    SCL -> D5    VCC -> 3V3    GND -> GND
//   microSD card goes in the slot on the camera board (FAT32).
//
// secrets.h: the Pi's camera Wi-Fi name and password, the Pi's address,
// and the camera key (the same key as in the Pi's settings.json).
//
// The Pi can also pull pictures (old v2 way, still works):
//   GET  /files                       list of saved pictures (up to 200 at a time)
//   GET  /download?f=/photos/...jpg   one picture
//   POST /delete?f=/photos/...jpg&key=CAMERA_KEY   delete it after it's copied

#include "esp_camera.h"
#include "jpeg_decoder.h"
#include <WiFi.h>
#include <WebServer.h>
#include <HTTPClient.h>
#include <Wire.h>
#include <sys/time.h>
#include <ESPmDNS.h>
#include "FS.h"
#include "SD.h"
#include "SPI.h"
#include "time.h"
#include "secrets.h"

// ---------- Settings you can change ----------
const unsigned long PICTURE_EVERY_MS = 1000;  // 1000 ms = 1 second
const int MOTION_SENSOR_PIN = D0;

// "Picture changed" settings. Make them bigger if wind and shadows
// trigger it too much, smaller if it misses animals.
const int   PIXEL_CHANGE  = 30;   // how different one spot must be (0-255)
const float AREA_CHANGE   = 2.0;  // how much of the picture must change (percent)

const char *TIME_ZONE = "MST7";   // Arizona: Mountain Standard Time, no daylight saving
const unsigned long PUSH_EVERY_MS = 500;            // how often to try sending a waiting picture
const unsigned long TIME_CHECK_EVERY_MS = 3600000;  // ask the Pi for the time every hour

// ---------- Camera pins for the XIAO ESP32-S3 Sense (don't change) ----------
#define PWDN_GPIO_NUM  -1
#define RESET_GPIO_NUM -1
#define XCLK_GPIO_NUM  10
#define SIOD_GPIO_NUM  40
#define SIOC_GPIO_NUM  39
#define Y9_GPIO_NUM    48
#define Y8_GPIO_NUM    11
#define Y7_GPIO_NUM    12
#define Y6_GPIO_NUM    14
#define Y5_GPIO_NUM    16
#define Y4_GPIO_NUM    18
#define Y3_GPIO_NUM    17
#define Y2_GPIO_NUM    15
#define VSYNC_GPIO_NUM 38
#define HREF_GPIO_NUM  47
#define PCLK_GPIO_NUM  13
#define SD_CS_PIN      21

WebServer server(80);
bool sdReady = false;

// The newest picture, kept so the web page can show it.
uint8_t *latestPicture = nullptr;
size_t latestPictureSize = 0;
size_t latestPictureSpace = 0;

// Tiny 80 x 60 black-and-white copies of the last two pictures, for comparing.
const int SMALL_W = 80, SMALL_H = 60;
uint8_t *smallRgb = nullptr;                // 80 x 60 x 3 colors
uint8_t smallNow[SMALL_W * SMALL_H];
uint8_t smallBefore[SMALL_W * SMALL_H];
bool haveBefore = false;

// What happened in the newest picture.
unsigned long pictureNumber = 0;
bool latestSensor = false;
bool latestChanged = false;
float latestChangedPercent = 0;
String latestSavedAs = "";

// The experiment: how many saved pictures each way caught.
unsigned long countChangedOnly = 0, countBoth = 0, countSensorOnly = 0;

// Sending to the Pi.
int waitingToSend = 0;        // pictures on the card the Pi doesn't have yet
unsigned long sentCount = 0;
bool piReachable = false;
bool clockOk = false;         // do we know the real time?
bool rtcFound = false;        // is a DS3231 clock module wired?

// The motion sensor only says "yes" for about 2 seconds, so we remember
// if it went off at any moment between pictures.
volatile bool sensorWentOff = false;
void IRAM_ATTR onMotion() {
  sensorWentOff = true;
}

bool startCamera() {
  camera_config_t config = {};
  config.ledc_channel = LEDC_CHANNEL_0;
  config.ledc_timer = LEDC_TIMER_0;
  config.pin_d0 = Y2_GPIO_NUM;
  config.pin_d1 = Y3_GPIO_NUM;
  config.pin_d2 = Y4_GPIO_NUM;
  config.pin_d3 = Y5_GPIO_NUM;
  config.pin_d4 = Y6_GPIO_NUM;
  config.pin_d5 = Y7_GPIO_NUM;
  config.pin_d6 = Y8_GPIO_NUM;
  config.pin_d7 = Y9_GPIO_NUM;
  config.pin_xclk = XCLK_GPIO_NUM;
  config.pin_pclk = PCLK_GPIO_NUM;
  config.pin_vsync = VSYNC_GPIO_NUM;
  config.pin_href = HREF_GPIO_NUM;
  config.pin_sccb_sda = SIOD_GPIO_NUM;
  config.pin_sccb_scl = SIOC_GPIO_NUM;
  config.pin_pwdn = PWDN_GPIO_NUM;
  config.pin_reset = RESET_GPIO_NUM;
  config.xclk_freq_hz = 20000000;
  config.pixel_format = PIXFORMAT_JPEG;
  config.frame_size = FRAMESIZE_VGA;     // 640 x 480
  config.jpeg_quality = 12;              // lower number = better picture, bigger file
  config.fb_count = 2;
  config.fb_location = CAMERA_FB_IN_PSRAM;
  config.grab_mode = CAMERA_GRAB_LATEST; // always give us the newest picture

  esp_err_t result = esp_camera_init(&config);
  if (result != ESP_OK) {
    Serial.printf("Camera didn't start (error 0x%x). Is PSRAM set to OPI PSRAM? Is the camera board snapped on?\n", result);
    return false;
  }
  return true;
}

// Shrinks the picture to 80 x 60 black and white, then compares it with the
// one before. Returns the percent of the picture that changed.
float comparePictures(const uint8_t *jpg, size_t len) {
  esp_jpeg_image_cfg_t cfg = {};
  cfg.indata = (uint8_t *)jpg;
  cfg.indata_size = len;
  cfg.outbuf = smallRgb;
  cfg.outbuf_size = SMALL_W * SMALL_H * 3;
  cfg.out_format = JPEG_IMAGE_FORMAT_RGB888;
  cfg.out_scale = JPEG_IMAGE_SCALE_1_8;   // 640 x 480 -> 80 x 60
  esp_jpeg_image_output_t out;
  if (esp_jpeg_decode(&cfg, &out) != ESP_OK || out.width != SMALL_W || out.height != SMALL_H) {
    return 0;
  }

  // Black and white, and remember the average brightness.
  long total = 0;
  for (int i = 0; i < SMALL_W * SMALL_H; i++) {
    const uint8_t *p = &smallRgb[i * 3];
    smallNow[i] = (p[0] + 2 * p[1] + p[2]) / 4;
    total += smallNow[i];
  }
  static int brightnessBefore = 0;
  int brightnessNow = total / (SMALL_W * SMALL_H);

  float percent = 0;
  if (haveBefore) {
    // Ignore the whole picture getting lighter or darker (a cloud), only
    // count spots that changed more than the rest of the picture did.
    int shift = brightnessNow - brightnessBefore;
    int changedSpots = 0;
    for (int i = 0; i < SMALL_W * SMALL_H; i++) {
      if (abs((int)smallNow[i] - (int)smallBefore[i] - shift) > PIXEL_CHANGE) changedSpots++;
    }
    percent = 100.0 * changedSpots / (SMALL_W * SMALL_H);
  }

  memcpy(smallBefore, smallNow, sizeof(smallNow));
  brightnessBefore = brightnessNow;
  haveBefore = true;
  return percent;
}

String timeStamp(const char *format) {
  struct tm now;
  char text[40];
  if (clockOk && getLocalTime(&now, 10)) {
    strftime(text, sizeof(text), format, &now);
    return String(text);
  }
  return "";
}

// ---------- Time: from the Pi, kept in the DS3231 clock module ----------
uint8_t fromBcd(uint8_t b) { return (b >> 4) * 10 + (b & 0x0F); }
uint8_t toBcd(uint8_t d) { return ((d / 10) << 4) | (d % 10); }

// Reads the clock module and sets the camera's time from it.
void readClockModule() {
  Wire.beginTransmission(0x68);
  Wire.write(0);
  rtcFound = Wire.endTransmission() == 0;
  if (!rtcFound || Wire.requestFrom(0x68, 7) != 7) return;
  struct tm t = {};
  t.tm_sec = fromBcd(Wire.read() & 0x7F);
  t.tm_min = fromBcd(Wire.read());
  t.tm_hour = fromBcd(Wire.read() & 0x3F);
  Wire.read();  // day of the week
  t.tm_mday = fromBcd(Wire.read());
  t.tm_mon = fromBcd(Wire.read() & 0x1F) - 1;
  t.tm_year = 2000 + fromBcd(Wire.read()) - 1900;
  if (t.tm_year + 1900 < 2025) return;  // never set yet
  struct timeval tv = {mktime(&t), 0};
  settimeofday(&tv, nullptr);
  clockOk = true;
}

// Saves the camera's time into the clock module.
void writeClockModule() {
  struct tm t;
  if (!rtcFound || !getLocalTime(&t, 10)) return;
  Wire.beginTransmission(0x68);
  Wire.write(0);
  Wire.write(toBcd(t.tm_sec));
  Wire.write(toBcd(t.tm_min));
  Wire.write(toBcd(t.tm_hour));  // 24-hour mode
  Wire.write(toBcd(t.tm_wday + 1));
  Wire.write(toBcd(t.tm_mday));
  Wire.write(toBcd(t.tm_mon + 1));
  Wire.write(toBcd(t.tm_year + 1900 - 2000));
  Wire.endTransmission();
}

// Asks the Pi what time it is.
void getTimeFromPi() {
  HTTPClient http;
  http.setTimeout(3000);
  http.begin(String(PI_URL) + "/api/time");
  if (http.GET() == 200) {
    String body = http.getString();  // {"epoch": 1793000000}
    long epoch = body.substring(body.indexOf(':') + 1).toInt();
    if (epoch > 1700000000) {
      struct timeval tv = {epoch, 0};
      settimeofday(&tv, nullptr);
      clockOk = true;
      writeClockModule();
      Serial.println("Time from the Pi: " + timeStamp("%Y-%m-%d %H:%M:%S"));
    }
  }
  http.end();
}

// Saves the picture as /photos/2026-10-25/2026-10-25_14-03-22_S.jpg
// (S = motion sensor, C = picture changed, SC = both) and adds a log line.
// If the camera doesn't know the time yet: /photos/no-time/no-time-123456-789_S.jpg
String savePicture(const uint8_t *jpg, size_t len, bool sensor, bool changed, float percent) {
  if (!sdReady) return "";

  String trigger = String(sensor ? "S" : "") + String(changed ? "C" : "");
  String folder, path;
  if (clockOk) {
    folder = "/photos/" + timeStamp("%Y-%m-%d");
    path = folder + "/" + timeStamp("%Y-%m-%d_%H-%M-%S") + "_" + trigger + ".jpg";
  } else {
    folder = "/photos/no-time";
    path = folder + "/no-time-" + String(millis()) + "-" + String(esp_random() % 1000) + "_" + trigger + ".jpg";
  }
  if (!SD.exists(folder)) SD.mkdir(folder);

  File photo = SD.open(path, FILE_WRITE);
  if (!photo) {
    Serial.println("Couldn't save to the microSD card.");
    return "";
  }
  photo.write(jpg, len);
  photo.close();
  waitingToSend++;

  bool newLog = !SD.exists("/photos/log.csv");
  File log = SD.open("/photos/log.csv", FILE_APPEND);
  if (log) {
    if (newLog) log.println("time,file,motion_sensor,picture_changed,percent_changed");
    log.printf("%s,%s,%s,%s,%.1f\n", timeStamp("%Y-%m-%d %H:%M:%S").c_str(), path.c_str(),
               sensor ? "yes" : "no", changed ? "yes" : "no", percent);
    log.close();
  }
  return path;
}

void takePicture() {
  camera_fb_t *fb = esp_camera_fb_get();
  if (!fb) {
    Serial.println("Picture failed, will try again.");
    return;
  }

  // Make room for the picture if it's bigger than the last one.
  if (fb->len > latestPictureSpace) {
    free(latestPicture);
    latestPictureSpace = fb->len + 10000;
    latestPicture = (uint8_t *)ps_malloc(latestPictureSpace);
  }
  if (latestPicture) {
    memcpy(latestPicture, fb->buf, fb->len);
    latestPictureSize = fb->len;
  }

  // Did the motion sensor feel something since the last picture?
  latestSensor = sensorWentOff || digitalRead(MOTION_SENSOR_PIN) == HIGH;
  sensorWentOff = false;

  // Did the picture change?
  latestChangedPercent = comparePictures(fb->buf, fb->len);
  latestChanged = latestChangedPercent >= AREA_CHANGE;

  latestSavedAs = "";
  if (latestSensor || latestChanged) {
    latestSavedAs = savePicture(fb->buf, fb->len, latestSensor, latestChanged, latestChangedPercent);
    if (latestSensor && latestChanged) countBoth++;
    else if (latestSensor) countSensorOnly++;
    else countChangedOnly++;
  }
  esp_camera_fb_return(fb);

  pictureNumber++;
  Serial.printf("Picture %lu  sensor: %s  changed: %s (%.1f%%)  %s\n", pictureNumber,
                latestSensor ? "YES" : "no", latestChanged ? "YES" : "no", latestChangedPercent,
                latestSavedAs.length() ? ("saved " + latestSavedAs).c_str() : "");
}

// ---------- Sending pictures to the Pi ----------
// Sends one picture. Returns true if the Pi has it.
bool sendToPi(File &photo) {
  HTTPClient http;
  http.setTimeout(10000);
  http.begin(String(PI_URL) + "/api/upload?name=" + String(photo.name()) + "&key=" + CAMERA_KEY);
  http.addHeader("Content-Type", "image/jpeg");
  int code = http.sendRequest("POST", &photo, photo.size());
  http.end();
  piReachable = code > 0;
  if (code == 403) Serial.println("The Pi says the camera key is wrong. Check secrets.h and the Pi's settings.json.");
  return code == 200;
}

// Sends up to 5 waiting pictures from one day folder, then lets the live page run again.
void pushWaitingPictures() {
  if (!sdReady || waitingToSend <= 0) return;
  File photos = SD.open("/photos");
  if (!photos) return;
  File day = photos.openNextFile();
  while (day && !day.isDirectory()) day = photos.openNextFile();
  if (!day) {
    waitingToSend = 0;  // nothing left
    return;
  }
  String dayPath = day.path();
  int sent = 0, seen = 0;
  File photo = day.openNextFile();
  while (photo && sent < 5) {
    String path = photo.path();
    seen++;
    bool ok = !photo.isDirectory() && sendToPi(photo);
    photo.close();
    if (!ok) break;  // Pi not answering: try again later
    SD.remove(path);
    waitingToSend--;
    sentCount++;
    sent++;
    photo = day.openNextFile();
  }
  day.close();
  photos.close();
  if (seen == 0) SD.rmdir(dayPath);  // empty day folder
}

// Counts pictures already on the card (from before a restart).
int countWaiting() {
  int count = 0;
  File photos = SD.open("/photos");
  File day = photos ? photos.openNextFile() : File();
  while (day) {
    if (day.isDirectory()) {
      File f = day.openNextFile();
      while (f) {
        if (!f.isDirectory()) count++;
        f = day.openNextFile();
      }
    }
    day = photos.openNextFile();
  }
  return count;
}

// ---------- The web page (Engineering Notebook colors) ----------
const char PAGE[] PROGMEM = R"rawliteral(
<!DOCTYPE html><html><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Rooted Warriors Camera</title>
<style>
 :root{--forest:#1c3b2a;--pine:#2a5c3f;--grass:#3f9b4c;--lavender:#b48fd9;--lilac:#d9c6ee;--teal:#20b5c9;--cream:#f4efe1;--ink:#22301f;--dim:#7d8a76;--line:#e5decb;--soft:#efe9d8}
 *{margin:0;padding:0;box-sizing:border-box;font-family:'Avenir Next','Trebuchet MS',sans-serif}
 body{background:var(--cream);color:var(--ink);padding:16px}
 .app{max-width:1000px;margin:0 auto;background:#fff;border:4px solid var(--lavender);border-radius:18px;overflow:hidden}
 .top{background:var(--forest);color:#fff;display:flex;align-items:center;gap:12px;padding:12px 18px;flex-wrap:wrap}
 .top h1{font-size:20px}
 .pill{margin-left:auto;background:var(--lavender);color:var(--forest);border-radius:20px;padding:4px 12px;font-weight:800;font-size:12px}
 .grid{display:grid;grid-template-columns:1.5fr 1fr;gap:16px;padding:16px}
 @media (max-width:760px){.grid{grid-template-columns:1fr}}
 .card{border:2px solid var(--line);border-radius:14px;padding:14px;background:#fffdf6}
 .card h2{font-size:15px;color:var(--pine);margin-bottom:10px}
 img{width:100%;border-radius:10px;display:block;background:var(--soft);aspect-ratio:4/3}
 .lights{display:flex;gap:10px;margin-top:12px;flex-wrap:wrap}
 .light{flex:1;min-width:150px;border-radius:12px;padding:10px;border:2px solid var(--line);background:var(--soft);font-size:13px}
 .light b{display:block;font-size:15px;margin-top:2px}
 .light.on{background:#e4f5e6;border-color:var(--grass)}
 .saved{margin-top:10px;font-size:13px;color:var(--dim);min-height:18px}
 .score{display:grid;grid-template-columns:repeat(3,1fr);gap:8px;text-align:center}
 .score div{border-radius:12px;padding:10px 4px;background:var(--soft)}
 .score .chg{background:#e3f6f8}.score .sen{background:var(--lilac)}
 .n{font-size:26px;font-weight:800;color:var(--forest)}
 .t{font-size:12px;color:var(--dim)}
 .small{font-size:12px;color:var(--dim);margin-top:10px;line-height:1.5}
</style></head><body>
<div class="app">
 <div class="top"><h1>&#127794; Rooted Warriors Wildlife Camera</h1><span style="opacity:.8;font-size:13px">Camera 1</span><span class="pill">&#9679; Live &middot; new picture every second</span></div>
 <div class="grid">
  <div class="card">
   <h2>Live view</h2>
   <img id="pic" src="/picture.jpg">
   <div class="lights">
    <div id="chg" class="light">&#128247; Picture changed<b>...</b></div>
    <div id="sen" class="light">&#128293; Motion sensor<b>...</b></div>
   </div>
   <div class="saved" id="saved"></div>
  </div>
  <div class="card">
   <h2>Our experiment: who catches more?</h2>
   <div class="score">
    <div class="chg"><div class="n" id="c1">0</div><div class="t">Picture changed only</div></div>
    <div><div class="n" id="c2">0</div><div class="t">Both</div></div>
    <div class="sen"><div class="n" id="c3">0</div><div class="t">Motion sensor only</div></div>
   </div>
   <p class="small">Counts saved pictures since the camera was turned on. Every saved picture is also written in log.csv on the microSD card.</p>
   <p class="small" id="pi"></p>
   <p class="small" id="info"></p>
  </div>
 </div>
</div>
<script>
function light(id, on, text){
  const el = document.getElementById(id);
  el.className = 'light' + (on ? ' on' : '');
  el.querySelector('b').textContent = text;
}
async function update(){
  try{
    const s = await (await fetch('/status')).json();
    document.getElementById('pic').src = '/picture.jpg?n=' + s.picture;
    light('chg', s.changed, (s.changed ? 'YES' : 'no') + ' · ' + s.percent.toFixed(1) + '% changed');
    light('sen', s.sensor, s.sensor ? 'YES, felt something!' : 'nothing');
    document.getElementById('saved').textContent = s.savedAs ? 'Saved: ' + s.savedAs : '';
    document.getElementById('c1').textContent = s.changedOnly;
    document.getElementById('c2').textContent = s.both;
    document.getElementById('c3').textContent = s.sensorOnly;
    document.getElementById('pi').textContent = (s.pi ? '\u2713 Sending to the Pi' : '\u2717 Pi out of range') +
      ' \u00b7 ' + s.waiting + ' waiting \u00b7 ' + s.sent + ' sent' + (s.clock ? '' : ' \u00b7 no time yet');
    document.getElementById('info').textContent = 'Picture #' + s.picture + ' \u00b7 ' + s.time +
      ' · microSD card: ' + (s.sd ? 'OK' : 'MISSING (pictures are not being saved)');
  }catch(e){}
}
update(); setInterval(update, 1000);
</script></body></html>
)rawliteral";

void showPage() {
  server.send_P(200, "text/html", PAGE);
}

void showPicture() {
  if (!latestPicture || latestPictureSize == 0) {
    server.send(503, "text/plain", "No picture yet");
    return;
  }
  server.sendHeader("Cache-Control", "no-store");
  server.send_P(200, "image/jpeg", (const char *)latestPicture, latestPictureSize);
}

void showStatus() {
  String json = "{\"picture\":" + String(pictureNumber) +
                ",\"sensor\":" + String(latestSensor ? "true" : "false") +
                ",\"changed\":" + String(latestChanged ? "true" : "false") +
                ",\"percent\":" + String(latestChangedPercent, 1) +
                ",\"savedAs\":\"" + latestSavedAs + "\"" +
                ",\"changedOnly\":" + String(countChangedOnly) +
                ",\"both\":" + String(countBoth) +
                ",\"sensorOnly\":" + String(countSensorOnly) +
                ",\"sd\":" + String(sdReady ? "true" : "false") +
                ",\"pi\":" + String(piReachable ? "true" : "false") +
                ",\"waiting\":" + String(waitingToSend) +
                ",\"sent\":" + String(sentCount) +
                ",\"clock\":" + String(clockOk ? "true" : "false") +
                ",\"time\":\"" + timeStamp("%Y-%m-%d %H:%M:%S") + "\"}";
  server.send(200, "application/json", json);
}

// ---------- For the Pi ----------
bool goodPath(const String &path) {
  return path.startsWith("/photos/") && path.indexOf("..") < 0;
}

void listFiles() {
  if (!sdReady) {
    server.send(503, "application/json", "{\"error\":\"no microSD card\"}");
    return;
  }
  String json = "{\"files\":[";
  int count = 0;
  File photos = SD.open("/photos");
  File day = photos ? photos.openNextFile() : File();
  while (day && count < 200) {
    if (day.isDirectory()) {
      File f = day.openNextFile();
      while (f && count < 200) {
        if (!f.isDirectory()) {
          if (count++) json += ",";
          json += "{\"f\":\"" + String(day.path()) + "/" + f.name() + "\",\"size\":" + String(f.size()) + "}";
        }
        f = day.openNextFile();
      }
    }
    day = photos.openNextFile();
  }
  json += "]}";
  server.send(200, "application/json", json);
}

void downloadFile() {
  String path = server.arg("f");
  if (!sdReady || !goodPath(path) || !SD.exists(path)) {
    server.send(404, "text/plain", "Not found");
    return;
  }
  File f = SD.open(path);
  server.streamFile(f, path.endsWith(".csv") ? "text/csv" : "image/jpeg");
  f.close();
}

void deleteFile() {
  if (server.method() != HTTP_POST || server.arg("key") != CAMERA_KEY) {
    server.send(403, "text/plain", "Not allowed");
    return;
  }
  String path = server.arg("f");
  if (!sdReady || !goodPath(path) || !SD.remove(path)) {
    server.send(404, "text/plain", "Not found");
    return;
  }
  waitingToSend--;
  server.send(200, "text/plain", "Deleted");
}

void setup() {
  Serial.begin(115200);
  delay(1500);
  Serial.println("\nRooted Warriors Wildlife Camera v3 starting...");

  setenv("TZ", TIME_ZONE, 1);
  tzset();
  Wire.begin();  // clock module on D4 (SDA) and D5 (SCL)
  readClockModule();
  if (!rtcFound) Serial.println("No clock module (that's OK when the Pi is in range).");
  else if (clockOk) Serial.println("Clock module time: " + timeStamp("%Y-%m-%d %H:%M:%S"));
  else Serial.println("Clock module found, not set yet. It gets set from the Pi.");

  pinMode(MOTION_SENSOR_PIN, INPUT);
  attachInterrupt(digitalPinToInterrupt(MOTION_SENSOR_PIN), onMotion, RISING);

  smallRgb = (uint8_t *)ps_malloc(SMALL_W * SMALL_H * 3);
  if (!startCamera() || !smallRgb) {
    while (true) delay(1000);  // stop here, the camera needs fixing first
  }

  sdReady = SD.begin(SD_CS_PIN);
  if (sdReady) {
    if (!SD.exists("/photos")) SD.mkdir("/photos");
    waitingToSend = countWaiting();
    Serial.printf("microSD card OK (%llu MB free, %d pictures waiting to send)\n",
                  (SD.totalBytes() - SD.usedBytes()) / (1024 * 1024), waitingToSend);
  } else {
    Serial.println("No microSD card found. The live view still works, but nothing is saved.");
  }

  // Join the Pi's camera Wi-Fi. Don't wait for it: out of range, the camera
  // keeps taking and saving pictures, and sends them when it's back.
  WiFi.mode(WIFI_STA);
  WiFi.setSleep(false);
  WiFi.setAutoReconnect(true);
  WiFi.begin(WIFI_NAME, WIFI_PASSWORD);

  server.on("/", showPage);
  server.on("/picture.jpg", showPicture);
  server.on("/status", showStatus);
  server.on("/files", listFiles);
  server.on("/download", downloadFile);
  server.on("/delete", deleteFile);
  server.begin();

  Serial.println("Motion sensor needs about 30 seconds to settle after power-on.");
}

void loop() {
  server.handleClient();

  // Just joined (or re-joined) the Pi's Wi-Fi?
  static bool wasConnected = false;
  static unsigned long lastTimeCheck = 0;
  bool connected = WiFi.status() == WL_CONNECTED;
  if (connected && !wasConnected) {
    Serial.print("On the Pi's Wi-Fi. Live page: http://");
    Serial.print(WiFi.localIP());
    Serial.println("  (or http://rooted-camera.local)");
    MDNS.begin("rooted-camera");
    MDNS.addService("http", "tcp", 80);
    getTimeFromPi();
    lastTimeCheck = millis();
  }
  if (!connected && wasConnected) {
    Serial.println("Out of range of the Pi. Saving pictures to the card until it's back.");
    piReachable = false;
  }
  wasConnected = connected;

  if (connected && millis() - lastTimeCheck >= TIME_CHECK_EVERY_MS) {
    lastTimeCheck = millis();
    getTimeFromPi();
  }

  static unsigned long lastPush = 0;
  if (connected && millis() - lastPush >= PUSH_EVERY_MS) {
    lastPush = millis();
    pushWaitingPictures();
  }

  static unsigned long lastPictureTime = 0;
  if (millis() - lastPictureTime >= PICTURE_EVERY_MS) {
    lastPictureTime = millis();
    takePicture();
  }
}
