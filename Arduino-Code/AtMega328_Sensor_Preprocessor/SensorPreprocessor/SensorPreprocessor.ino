#include <Wire.h>
#include <DHT.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BMP085_U.h>

DHT dht(2, DHT22);  // Create DHT object
Adafruit_BMP085_Unified bmp = Adafruit_BMP085_Unified(10085);  // Create object for BMP085/BMP180

float bmpPressure;
float bmpTemperature;

float seaLevelPressure;
float bmpAltitude;

float dhtHumidity;
float dhtTemperatureC;
float dhtTemperatureF;

float heatIndexF;
float heatIndexC;

boolean dhtReadFailed;
boolean bmpReadFailed;

int sensor;


void setup() {

  pinMode(9, OUTPUT);
  pinMode(13, OUTPUT);
  Wire.begin(2);
  Wire.onRequest(requestEvent);
  Wire.onReceive(recieveEvent);
  Serial.begin(115200);
  delay(100);

  if (!bmp.begin()) {  // Test to see if sensor initalized correctly
  } 

  delay(100);  

  dht.begin(); 
}


void loop() {

  // 2 second loop



}

void requestEvent() {
  digitalWrite(9, LOW);
  if (sensor == 1) {
    //char buffer [5];
    //dtostrf(dhtHumidity,2,2,buffer);
    //Wire.write(buffer);
    Wire.write("1234");
  }
  else if (sensor == 2) {

  } 
  else {

  }
}

void recieveEvent(int howMany) {

  digitalWrite(13, HIGH);
  sensor = Wire.read();
}





