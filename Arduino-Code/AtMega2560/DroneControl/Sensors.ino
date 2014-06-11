void sensorGet() {

  if (messages[1] == "1") {
    String buffer = "S," 
        + String(charRoll) + ","
        + String(charPitch) + ","
        + String(charYaw) + "," 
        + messages[2] + ",%";        
    Serial.print(buffer);
  }
  else if (messages[2] == "2"){
    
  } 
  else {    
  }
}

void servoSort() {
  servo1.write(messages[1].toInt());
}

void Servo_Init(){
  
  servo1.attach(51);
  
  servo1.write(90);
  
}
