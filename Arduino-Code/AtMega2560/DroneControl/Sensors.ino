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

    Serial.print("S,2,");
    Serial.print(gps.location.lat(), 6);
    Serial.print(","); 
    Serial.print(gps.location.lng(), 6);
    Serial.print(",");
    Serial.print(gps.speed.mps());
    Serial.print(",");
    Serial.print(gps.course.deg());
    Serial.print(",");
    Serial.print(gps.altitude.meters());
    Serial.print(",");
    Serial.print(gps.satellites.value());
    Serial.print("," + messages[2] + ",%");   
  } 
  else if (messages[1] == "3") {  // Send sensor data
    Serial.print("S,3," 
          + dht22[1] + "," 
          + dht22[2] + ","
          + dht22[3] + ","
          + stringPressure + ","
          + stringTemperature + ","
          + stringAltitude + "," 
          + messages[2] + ",%");

  }
  else { // If message is unrecognised
  }
}

void servoSort() {
  servo1.write(messages[1].toInt());
  servo2.write(messages[2].toInt());
  servo3.write(messages[3].toInt());
  servo4.write(messages[4].toInt());
}

void Servo_Init(){

  servo1.attach(0);
  servo2.attach(1);
  servo3.attach(2);
  servo4.attach(3);
  

  servo1.write(0);
  servo2.write(90);
  servo3.write(90);
  servo4.write(90);


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
      char c = Wire.read(); // receive a byte as character;
      dht22[x] += c;
    }
    x += 1;
  }
}




