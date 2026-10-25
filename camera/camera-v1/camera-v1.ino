// Rooted Warriors Wildlife Camera — version 1 (Option C)
//
// What it does:
//   - Takes a picture every 2 seconds.
//   - Checks the motion sensor: did it feel something since the last picture?
//   - Shows both on a little web page you can open on any computer
//     or phone on the same Wi-Fi.
//
// Later we'll change it to send the pictures to our online camera app.
//
// Board settings (Tools menu):
//   Board: XIAO_ESP32S3    PSRAM: OPI PSRAM
//
// Wiring (see updates/CAMERA-BUILD.md):
//   Motion sensor OUT -> D0    + -> 3V3    - -> GND

#include "esp_camera.h"
#include <WiFi.h>
#include <WebServer.h>
#include "secrets.h"

// ---------- Settings you can change ----------
const unsigned long PICTURE_EVERY_MS = 2000;  // 2000 ms = 2 seconds
const int MOTION_SENSOR_PIN = D0;

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

WebServer server(80);

// The newest picture, kept so the web page can show it.
uint8_t *latestPicture = nullptr;
size_t latestPictureSize = 0;
size_t latestPictureSpace = 0;

unsigned long pictureNumber = 0;
unsigned long sensorCount = 0;     // pictures where the motion sensor felt something
bool latestSensorSaw = false;
unsigned long lastPictureTime = 0;

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
  esp_camera_fb_return(fb);

  // Did the motion sensor feel something since the last picture?
  latestSensorSaw = sensorWentOff || digitalRead(MOTION_SENSOR_PIN) == HIGH;
  sensorWentOff = false;

  pictureNumber++;
  if (latestSensorSaw) sensorCount++;

  Serial.printf("Picture %lu  (%u bytes)  motion sensor: %s\n",
                pictureNumber, (unsigned)latestPictureSize, latestSensorSaw ? "YES" : "no");
}

// ---------- The web page ----------
const char PAGE[] PROGMEM = R"rawliteral(
<!DOCTYPE html><html><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Rooted Warriors Camera</title>
<style>
 body{font-family:'Avenir Next','Trebuchet MS',sans-serif;background:#f4efe1;color:#22301f;margin:0;padding:16px;text-align:center}
 h1{color:#1c3b2a;font-size:22px}
 img{width:100%;max-width:640px;border:4px solid #b48fd9;border-radius:14px}
 .light{display:inline-block;margin:10px;padding:10px 18px;border-radius:12px;font-weight:bold;background:#efe9d8}
 .yes{background:#3f9b4c;color:#fff}
</style></head><body>
<h1>&#127794; Rooted Warriors Wildlife Camera</h1>
<img id="pic" src="/picture.jpg">
<div><span id="sensor" class="light">Motion sensor: ...</span></div>
<p id="info"></p>
<script>
async function update(){
  try{
    const s = await (await fetch('/status')).json();
    document.getElementById('pic').src = '/picture.jpg?n=' + s.picture;
    const el = document.getElementById('sensor');
    el.textContent = 'Motion sensor: ' + (s.sensor ? 'YES, felt something!' : 'nothing');
    el.className = 'light' + (s.sensor ? ' yes' : '');
    document.getElementById('info').textContent =
      'Picture #' + s.picture + ' · the sensor felt something in ' + s.sensorCount + ' pictures';
  }catch(e){}
}
update(); setInterval(update, 2000);
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
                ",\"sensor\":" + String(latestSensorSaw ? "true" : "false") +
                ",\"sensorCount\":" + String(sensorCount) + "}";
  server.send(200, "application/json", json);
}

void setup() {
  Serial.begin(115200);
  delay(1500);
  Serial.println("\nRooted Warriors Wildlife Camera v1 starting...");

  pinMode(MOTION_SENSOR_PIN, INPUT);
  attachInterrupt(digitalPinToInterrupt(MOTION_SENSOR_PIN), onMotion, RISING);

  if (!startCamera()) {
    while (true) delay(1000);  // stop here, the camera needs fixing first
  }

  WiFi.mode(WIFI_STA);
  WiFi.setSleep(false);
  WiFi.begin(WIFI_NAME, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println();
  Serial.print("Connected! Open this in a browser: http://");
  Serial.println(WiFi.localIP());

  server.on("/", showPage);
  server.on("/picture.jpg", showPicture);
  server.on("/status", showStatus);
  server.begin();

  Serial.println("Motion sensor needs about 30 seconds to settle after power-on.");
}

void loop() {
  server.handleClient();

  if (millis() - lastPictureTime >= PICTURE_EVERY_MS) {
    lastPictureTime = millis();
    takePicture();
  }
}
