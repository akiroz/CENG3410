#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

#define SCREEN_WIDTH  128
#define SCREEN_HEIGHT 64
#define OLED_RESET    -1 // Reset pin # (or -1 if sharing Arduino reset pin)
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

void setup() {
  // SSD1306_SWITCHCAPVCC = generate display voltage from 3.3V internally
  if(!display.begin(SSD1306_SWITCHCAPVCC, 0x3C)) {
    for(;;);
  }
  
  display.clearDisplay();
  display.setTextSize(1);
  display.setTextColor(WHITE);
  display.setTextWrap(false);
  display.setCursor(0,0);
  display.display();
  
  delay(1000);
  Serial.begin(115200);
}

int lineNum = 0;

void loop() {
  String s = Serial.readStringUntil('\n');
  if (s.length() < 1) return;
  if (s.startsWith("HTTP")) return;
  if (s[0] == '\\') {
    display.clearDisplay();
    display.display();
    lineNum = 0;
  } else {
    display.setCursor(0, lineNum*8);
    lineNum += 1; lineNum %= 8;
    display.println(s);
    display.display();
  }
}

