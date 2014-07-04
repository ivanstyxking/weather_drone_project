void getGPS() {
  if (Serial1.available() > 0) {
    gps.encode(Serial1.read());
  }
}

void GPS_Init() {

  Serial1.begin(9600);
  
  delay(100);
      
  // Must set the higher baud rate before update rate
  Serial1.write("$PMTK251,57600*2C"); // Set 57600 baud rate 
  Serial1.write(0x0D); // CR
  Serial1.write(0x0A); // NL

  Serial1.end();
  delay(100);
  Serial1.begin(57600);  // Change to new 57600 baud rate
  
  delay(100); //Settle time

  Serial1.write("$PMTK220,100*2F"); // Set 10Hz update rate
  Serial1.write(0x0D); // CR
  Serial1.write(0x0A); // NL
}
