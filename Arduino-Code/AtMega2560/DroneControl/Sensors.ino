void sensorGet() {

  if (messages[1] == "1") { // Send Gyros
    String buffer = "S,1," 
      + String(charRoll) + ","
      + String(charPitch) + ","
      + String(charYaw) + "," 
      + messages[2] + ",%";        
    Serial.print(buffer);
  }
  else if (messages[1] == "2"){  // Send GPS data
    float buffer1 = gps.location.lat(); 
    float buffer2 = gps.location.lng();
    float buffer3 = gps.speed.mps();
    float buffer4 = gps.course.deg();
    float buffer5 = gps.altitude.meters();
    float buffer6 = gps.altitude.meters();

    Serial.print("S,2,");
    Serial.print(buffer1);
    Serial.print(","); 
    Serial.print(buffer2);
    Serial.print(",");
    Serial.print(buffer3);
    Serial.print(",");
    Serial.print(buffer4);
    Serial.print(",");
    Serial.print(buffer5);
    Serial.print(",");
    Serial.print(buffer6);
    Serial.print("," + messages[2] + ",%");   
  } 
  else if (messages[1] == "3") {  // Send sensor data
    Serial.print("S,3," 
          + dht22[1] + "," 
          + dht22[2] + ","
          + dht22[3] + "," 
          + messages[2] + ",%");

  }
  else { // If message is unrecognised
  }
}

void servoSort() {
  servo1.write(messages[1].toInt());
}

void Servo_Init(){

  servo1.attach(24);
  servo2.attach(25);

  servo1.write(90);
  servo2.write(90);


}

void readSensorPreprocessor() {
  int x = 1;
  while (x < 4) {
    Wire.beginTransmission(2);
    Wire.write(x);
    Wire.endTransmission();

    Wire.requestFrom(2,4);

    dht22[x] = "";
    while(Wire.available()) {   // slave may send less than requested 
      char c = Wire.read(); // receive a byte as character
      dht22[x] += c;
      
    }
    x += 1;
  }
}




