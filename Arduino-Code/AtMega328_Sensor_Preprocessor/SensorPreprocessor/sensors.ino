void getBMP() {

  sensors_event_t event;
  bmp.getEvent(&event);

  if (event.pressure) {
    bmpPressure = event.pressure;
    bmp.getTemperature(&bmpTemperature);

    bmpAltitude = bmp.pressureToAltitude(seaLevelPressure,bmpPressure,bmpTemperature); 
  } else {
    bmpReadFailed = true;
  }
}

void getDHT() {  // Can only be called once every 2 seconds

  dhtHumidity = dht.readHumidity();  // Read humidity
  dhtTemperatureC = dht.readTemperature(false);  // Read temperature in C
  dhtTemperatureF = dht.readTemperature(true);  // Read temperature in F for computing heat index

  if (isnan(dhtHumidity) || isnan(dhtTemperatureC) || isnan(dhtTemperatureF)) {
    dhtReadFailed = true;  // Do something if read fails
    return;
  }

  heatIndexF = dht.computeHeatIndex(dhtTemperatureF, dhtHumidity); // Computer heat index
  heatIndexC = (heatIndexF-32)/1.8; // Convert heat index to C
}

