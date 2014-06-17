void sensorGet() {

  if (messages[1] == "1") { // Send Gyros
    String buffer = "S,1," 
      + String(charRoll) + ","
      + String(charPitch) + ","
      + String(charYaw) + "," 
      + messages[2] + ",%";        
    Serial.print(buffer);
  }
  else if (messages[2] == "2"){  // Send GPS data
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
  else if (messages[2] == "3") {  // Send sensor data

  }
  else { // If message is unrecognised
  }
}

void servoSort() {
  servo1.write(messages[1].toInt());
}

void Servo_Init(){

  servo1.attach(24);

  servo1.write(90);

}

void readSensorPreprocessor() {
  
}

