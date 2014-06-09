
void sensorGet() {
  I2C_Send();
  I2C_Request();
  //Serial.write("S,");    
  //Serial.print(String(messages[1]) +  ",%");
}

void servoSet() {


  myServo1.write(servoPos[1]);
  myServo2.write(servoPos[2]);
  myServo3.write(servoPos[3]);
  //something();
}

void servoSort() {                                           //Puts the servo message in the correct variable
  servoPos[1] = messages[1].toInt();
  servoPos[2] = messages[2].toInt();
  servoPos[3] = messages[3].toInt();
  //printServos();
}

