
void getGPS() {
  while (Serial.available()) {
    gps.encode(Serial.read());
  }
}

void GPS_Init() {

  Serial.begin(9600);

  Serial.write("$PMTK251,57600*2C"); // Must set the higher baud rate before update rate
  Serial.write(0x0D);  // CR
  Serial.write(0x0A);  // NL

  Serial.begin(57600);
  delay(10); 

  Serial.write("$PMTK220,100*2F");
  Serial.write(0x0D);  // CR
  Serial.write(0x0A);  // NL

}
