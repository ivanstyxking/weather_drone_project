#include <Wire.h>
#include <DHT.h>
#include <Adafruit_Sensor.h>

DHT dht(8, DHT22);  // Create DHT object

float humidity;
float temperatureC;
float temperatureF;

float heatIndexF;
float heatIndexC;

boolean readFailed;

int sensor;

char buffer [5];

long previousMillis = 0;
long interval = 2000;      

void setup() {

  pinMode(A3, OUTPUT);
  Wire.begin(2);
  Wire.onRequest(requestEvent);
  Wire.onReceive(recieveEvent);

  delay(100);  

  dht.begin(); 
}


void loop() {

  

  unsigned long currentMillis = millis();
  if(currentMillis - previousMillis > interval) {  // 2 second loop
    digitalWrite(A3, LOW);  // Prevent a i2c request
    delay(10);
    previousMillis = currentMillis;
    getDHT();
    digitalWrite(A3, HIGH);
  }

}

void requestEvent() {
  
  if (sensor == 1) {  // Writes dhtHumidity
    dtostrf(humidity,2,2,buffer);
    Wire.write(buffer);
  }
  else if (sensor == 2) {  // Writes dhtTemperature
    dtostrf(temperatureC,2,2,buffer);
    Wire.write(buffer);
  } 
  else if (sensor == 3) {  // Writes heatIndex
    dtostrf(heatIndexC,2,2,buffer);
    Wire.write(buffer);
  }
  else {

  }
}

void recieveEvent(int howMany) {
  digitalWrite(A3, LOW);
  sensor = Wire.read();
}







