void serialCheck() {
  if (Serial.available() > 0) {                               //If a serial message is avaible run the while loop
    incomingChar = ' ';                                          //Clear all variables before start
    incomingString = "";
    while (incomingChar != '%') {                              //If the last character wasn't the end character then continue
      incomingChar = (char)Serial.read();
      incomingString += incomingChar;                          //Read and add the last revieved byte to the string
      if (Serial.available() == 0 && incomingChar != '%') {   //Wait for the next charater unless the end character has been sent
        timeoutStart = millis();                               //Start the timeout timer
        while (Serial.available() == 0) {
          timeoutCurrent = millis() - timeoutStart;
          if (timeoutCurrent > 50) {                           //If the timeout timer > 50 ms
            incomingChar = ' ';
            incomingString = "";                               //Erase the last message and return
            return;
          }
        }
      }
    }       
    afterString();   
    //Stuff to do with the new string
  }
}

void afterString() {
  splitString();
}

void splitString() {
  messageNum = 0;
  do {
    commaPosition = incomingString.indexOf(',');
    if(commaPosition != -1) {
      messages[messageNum] = incomingString.substring(0,commaPosition);
      incomingString = incomingString.substring(commaPosition+1, incomingString.length());
      messageNum += 1;
    }
  }
  while(commaPosition >=0);

  //After string has been split (string sorting)

  msgDetect();
}

void msgDetect() {                                          // Detects what type of message has come through
  if (messages[0] == "R") {
    sensorGet();
  }
  else if (messages[0] == "S") {
    servoSort();
  }
  else {
  }
}

