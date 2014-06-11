void getGPS() {
  while (Serial3.available()) {
    gps.encode(Serial3.read());
  }
}

void GPS_Init() {

  Serial3.begin(9600);
  
  delay(100);
      
  // Must set the higher baud rate before update rate
  Serial3.write("$PMTK251,57600*2C"); // Set 57600 baud rate 
  Serial3.write(0x0D); // CR
  Serial3.write(0x0A); // NL

  Serial3.end();
  delay(100);
  Serial3.begin(57600);  // Change to new 57600 baud rate
  
  delay(100); //Settle time

  Serial3.write("$PMTK220,100*2F"); // Set 10Hz update rate
  Serial3.write(0x0D); // CR
  Serial3.write(0x0A); // NL
}
