#include <Adafruit_NeoPixel.h> //used for LEDs
#include <SoftwareSerial.h> //Used for transmitting to the device
SoftwareSerial softSerial(2, 3); //RX, TX
#include "SparkFun_UHF_RFID_Reader.h" //Library for controlling the M6E Nano module
RFID nano; //Create instance

#define LED_PIN    6
#define BUZZER1    9
#define BUZZER2    10
#define LED_COUNT  82

// Declare our NeoPixel strip object:
Adafruit_NeoPixel strip(LED_COUNT, LED_PIN, NEO_GRB + NEO_KHZ800);

  static uint32_t white = strip.Color(255, 255, 255);
  static uint32_t red = strip.Color(255, 5, 0);
  static uint32_t amber = strip.Color(255, 85, 0);
  static uint32_t green = strip.Color(0, 255, 0);
  
// setup() function -- runs once at startup --------------------------------

void setup() {

  strip.begin();           // INITIALIZE NeoPixel strip object (REQUIRED)
  strip.show();            // Turn OFF all pixels ASAP
  strip.setBrightness(20); // Set BRIGHTNESS to about 1/5 (max = 255)

  pinMode(BUZZER1, OUTPUT);
  pinMode(BUZZER2, OUTPUT);

  startup();
}

void loop() {
  // put your main code here, to run repeatedly:

//flashZone(white,60);

//expiredZone(red, 60);

//lowoutStock(amber, 20);
//lowoutStock(amber, 60);
 
//testZones(white);
//testZones(red);
//testZones(amber);
//testZones(green);

rainbow(10);

}

void startup() {
  // Run startup test to make sure all LEDs working
  strip.fill(white, 0, 82);
  strip.show();
  delay(200);
  strip.fill(red, 0, 82);
  strip.show();
  delay(200);
  strip.fill(amber, 0, 82); 
  strip.show();
  delay(200); 
  strip.clear();
  strip.show();
  delay(500);
  strip.fill(green, 0, 82);
  strip.show();
  delay(300);
  strip.clear();
  strip.show();
  delay(100);
  strip.fill(green, 0, 82);
  strip.show();
  delay(300);
  strip.clear();
  strip.show();
  
  tone(BUZZER1, 2093, 150); //C
  delay(150);
  tone(BUZZER1, 2349, 150); //D
  delay(150);
  tone(BUZZER1, 2637, 150); //E
  delay(150);
}

void testZones(uint32_t colour) {
  strip.clear();
  strip.fill(colour, 0, 20);
  strip.show();
  delay(800);
  strip.clear();
  strip.fill(colour, 20, 20);
  strip.show();
  delay(800);
  strip.clear();
  strip.fill(colour, 40, 20);
  strip.show();
  delay(800);
  strip.clear();
  strip.fill(colour, 60, 22);
  strip.show();
  delay(800);
  strip.clear();
}

void flashZone(uint32_t colour, int zoneStart) {
  delay(3000);
  strip.fill(colour, zoneStart, 21);
  strip.show();
  delay(5000);
  strip.clear();
  strip.show();
  delay(500);
  strip.fill(colour, zoneStart, 21);
  strip.show();
  delay(500);
  strip.clear();
  strip.show();
  delay(500);
  strip.fill(colour, zoneStart, 21);
  strip.show();
  delay(500);
  strip.clear();
  strip.show();
}

void expiredZone(uint32_t colour, int zoneStart) {
for (int i = 0; i <= 10; i++)
  strip.fill(colour, zoneStart, 21);
  strip.show();
  delay(500);
  strip.clear();
  strip.show();
  delay(500);
}

void lowoutStock(uint32_t colour, int zoneStart) {
  strip.fill(colour, zoneStart, 21);
  strip.show();
  delay(1000);
  strip.clear();
  strip.show();
}

// Rainbow cycle along whole strip. Pass delay time (in ms) between frames.
void rainbow(int wait) {
  for(long firstPixelHue = 0; firstPixelHue < 5*65536; firstPixelHue += 256) {
    for(int i=0; i<strip.numPixels(); i++) { // For each pixel in strip...
      int pixelHue = firstPixelHue + (i * 65536L / strip.numPixels());
      strip.setPixelColor(i, strip.gamma32(strip.ColorHSV(pixelHue)));
    }
    strip.show(); // Update strip with new contents
    delay(wait);  // Pause for a moment
  }
}
