
void I2C_Init()
{
  Wire.begin();
}

void I2C_Request() {
  
  Wire.requestFrom(2,20);
  
  while(Wire.available())    // slave may send less than requested
  { 
    char c = Wire.read(); // receive a byte as character
    Serial.print(c);         // print the character
  }
}

void I2C_Send() {

  Wire.beginTransmission(2);
  char buffer[2];
  messages[1].toCharArray(buffer, 2);
  Wire.write(buffer);
  Wire.endTransmission();
  
  delay(100);
  
}
