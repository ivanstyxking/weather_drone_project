void recieveSerial() {
  serialRequest();


  print("Sensor 1: ");
  println(sensors[1]);
  print("Sensor 2: ");
  println(sensors[2]);
  print("Sensor 3: ");
  println(sensors[3]);
  print("Sensor 4: ");
  println(sensors[4]);

}

void serialRequest() {

  checkNumInc();

  checkNum[0] = int(random(100, 999));

  println("Array 1: " + checkNum[0]);
  println("Array 2: " + checkNum[1]);
  println("Array 3: " + checkNum[2]);
  println("Array 4: " + checkNum[3]);
  println("Array 5: " + checkNum[4]);
  println("Array 6: " + checkNum[5]);
  println("Array 7: " + checkNum[6]);
  println("Array 8: " + checkNum[7]); 

  println("Check number is: " + checkNum[0]);

  serialPort.write("R,1," + checkNum[0] + ",%");

  println("Sent message is: " + "R,1," + checkNum[0] + ",%");


  incomingChar = ' ';                                             //Clear all variables before start
  incomingString = "";
  if (serialPort.available() > 0) {                               //If a serial message is avaible run the while loop
    while (incomingChar != '%') {                                 //If the last character wasn't the end character then continue
      incomingChar = (char)serialPort.read();
      incomingString += incomingChar;                             //Read and add the last revieved byte to the string
      if (serialPort.available() == 0 && incomingChar != '%') {   //Wait for the next charater unless the end character has been sent
        timeoutStart = millis();                                  //Start the timeout timer
        while (serialPort.available () == 0) {
          timeoutCurrent = millis() - timeoutStart;
          if (timeoutCurrent > 50) {                              //If the timeout timer > 50 ms
            incomingChar = ' ';
            incomingString = "";            //Erase the last message and return
            println("Message dropped");
            return;
          }
        }
      }
    }

    println("Incoming string is: " + incomingString);
    //afterString();
    //Stuff to do with the new string
    splitString();
  }
}

void splitString() {
  messageNum = 0;
  do {
    commaPosition = incomingString.indexOf(',');
    if (commaPosition != -1) {
      messages[messageNum] = incomingString.substring(0, commaPosition);
      incomingString = incomingString.substring(commaPosition+1, incomingString.length());
      messageNum += 1;
    }
  }
  while (commaPosition >=0); 
  sensorSort();
}

void sensorSort() {

  boolean test = mesLagCheck();
  println("Lag check num: " + messages[4]);
  println("Result of lag check: " + test);
  
  
  if (messages[0].equals("S") && test) {
    orientation[0]=float(messages[1]);
    orientation[1]=float(messages[2]);
    orientation[2]=float(messages[3]);
  }
  else {
    // Error if an incorrect string is recieved
  }
}

void sendSerial() {

  serialPort.write("S,1," + str(throttle) + ",%");    //Send all values to the plane
  serialPort.write("S,2," + str(ailerons) + ",%");
  serialPort.write("S,3," + str(ailerons2) + ",%");
  serialPort.write("S,4," + str(elevator) + ",%");
  serialPort.write("S,5," + str(rudder) + ",%");
  serialPort.write("S,6," + str(gear) + ",%");
}

void checkNumInc() {
  posInArr = 10;
  while (posInArr > 0) {
    checkNum[posInArr] = checkNum[posInArr - 1];  
    posInArr -= 1;
  }
}

boolean mesLagCheck() {
  if (int(messages[4]) == checkNum[0]) {          // Lag / serial buffer check
  println("Message latency: 0");
  return true;
  }
  else if (messages[4].equals(str(checkNum[1]))) {       
  println("Message latency: 1");
  return true;
  }
  else if (messages[4].equals(str(checkNum[2]))) {       
  println("Message latency: 2");
  return true;
  }
  else if (messages[4].equals(str(checkNum[3]))) {       
  println("Message latency: 3");
  return true;
  }
  else if (messages[4].equals(str(checkNum[4]))) {       
  println("Message latency: 4");
  return true;
  }
  else if (messages[4].equals(str(checkNum[5]))) {       
  println("Message latency: 5");
  return true;
  }
  else if (messages[4].equals(str(checkNum[6]))) {       
  println("Message latency: 6");
  return true;
  }
  else if (messages[4].equals(str(checkNum[7]))) {       
  println("Message latency: 7");
  return true;
  }
  else if (messages[4].equals(str(checkNum[8]))) {       
  println("Message latency: 8");
  return true;
  }
  else {
    println("Max message lag exceded");
    serialFlush();
    return false;
  }
}

void serialFlush() {
  println("---------------------| Flushing |-------------------------");
  serialPort.clear();
  serialRequest();
  delay(100);
}

