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

