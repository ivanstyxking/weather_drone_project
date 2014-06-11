void getGPS() {
  while (Serial.available()) {
    gps.encode(Serial.read());
  }
}

void GPS_Init() {

  Serial.begin(9600);
      
  // Must set the higher baud rate before update rate
  Serial.write("$PMTK251,57600*2C"); // Set 57600 baud rate 
  Serial.write(0x0D); // CR
  Serial.write(0x0A); // NL

  Serial.begin(57600);  // Change to new 57600 baud rate
  
  delay(10); //Settle time

  Serial.write("$PMTK220,100*2F"); // Set 10Hz update rate
  Serial.write(0x0D); // CR
  Serial.write(0x0A); // NL
}
