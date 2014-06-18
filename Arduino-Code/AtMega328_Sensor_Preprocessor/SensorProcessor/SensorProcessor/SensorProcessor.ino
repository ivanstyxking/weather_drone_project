#include "DHT.h"

DHT dht(2, DHT22);

boolean readFailed;

float humidity;
float temperatureC;
float temperatureF;
float heatIndexF;
float heatIndexC;

long previousMillis = 0;
long interval = 2000;

void setup() {
  Serial.begin(115200); 

  dht.begin();
}

void loop() {

  unsigned long currentMillis = millis();  // Loop runs every 2 seconds  
  if(currentMillis - previousMillis > interval) {
    previousMillis = currentMillis;   

    readDHT();
    sendSensors();
  }
}

void readDHT() {

  humidity = dht.readHumidity();  // Read sensors
  temperatureC = dht.readTemperature(false);
  temperatureF = dht.readTemperature(true);

  if (isnan(humidity) || isnan(temperatureC) || isnan(temperatureF)) {
    readFailed = true;
    return;
  }

  // Compute heat index
  // Must send in temp in Fahrenheit!
  heatIndexF = dht.computeHeatIndex(temperatureF, humidity);  // Compute heat index (real feel)
  heatIndexC = (heatIndexF-32)/1.8;
}

void sendSensors() {
  Serial.print("Humidity: ");
  Serial.println(humidity);
 Serial.print("Temperature: ");
  Serial.println(temperatureC);
  Serial.print("Heat index: ");
  Serial.println(heatIndexC);
}
