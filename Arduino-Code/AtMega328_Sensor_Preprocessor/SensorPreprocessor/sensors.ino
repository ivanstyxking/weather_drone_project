void getDHT() {  // Can only be called once every 2 seconds

  humidity = dht.readHumidity();  // Read humidity
  temperatureC = dht.readTemperature(false);  // Read temperature in C
  temperatureF = dht.readTemperature(true);  // Read temperature in F for computing heat index

  if (isnan(humidity) || isnan(temperatureC) || isnan(temperatureF)) {
    readFailed = true;  // Do something if read fails
    return;
  }

  heatIndexF = dht.computeHeatIndex(temperatureF, humidity); // Computer heat index
  heatIndexC = (heatIndexF-32)/1.8; // Convert heat index to C
}
