#include "DHT.h"

DHT dht(2, DHT22);

boolean readFailed;

float humidity;
float temperatureC;
float temperatureF;
float heatIndex;

long previousMillis = 0;
long interval = 2000;

void setup() {
  Serial.begin(115200); 
 
  dht.begin();
}

void loop() {

  unsigned long currentMillis = millis();  
  if(currentMillis - previousMillis > interval) {
    
    previousMillis = currentMillis;   
    readDHT();
    Serial.print(humidity);
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
  heatIndex = dht.computeHeatIndex(temperatureF, humidity);  // Compute heat index (real feel)
  
}
