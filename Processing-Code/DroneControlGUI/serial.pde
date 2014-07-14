void serialRequestNum() {
  
    serialRequest(requestNumber);
  if (requestNumber < 3) {
    requestNumber ++;
  } else {
    requestNumber = 1;
  }
}

void serialRequest(int sensorGroupTemp) {

  sensorGroup = sensorGroupTemp;
  
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

  serialPort.write("R," + sensorGroup + "," + checkNum[0] + ",%");

  println("Sent message is: " + "R," + sensorGroup + "," + checkNum[0] + ",%");
}

void serialRecieve() {

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

  boolean test = true; //mesLagCheck();
  println("Lag check num: " + messages[5]);
  println("Result of lag check: " + test);


  if (messages[0].equals("S") && messages[1].equals("1") && test) {
    orientation[0] = float(messages[3]);
    orientation[1] = float(messages[2]);
    orientation[2] = float(messages[4]);
    heading2 = int(orientation[2]);
  } 
  
  else if (messages[0].equals("S") && messages[1].equals("2") && test) {
    lattitudeGPS = float(messages[2]);
    longitudeGPS = float(messages[3]);
    speedMpsGPS = float(messages[4]);
    headingGPS = float(messages[5]);
    altitudeGPS = float(messages[6]);
    satillitesGPS = int(messages[7]);
  }
  
  else if (messages[0].equals("S") && messages[1].equals("3") && test) {
    humidityDHT = float(messages[2]);
    temperatureDHT = float(messages[3]);
    heatIndexDHT = float(messages[4]);
    pressureMB = float(messages[5]);
    temperatureBMP = float(messages[6]);
  } else {
    // Error if an incorrect string is recieved
  }
}

void sendValuesSerial() {
  serialPort.write("S," + str(round(throttle)) + "," + str(round(ailerons)) + "," + str(round(elevator)) + "," + str(round(rudder)) + ",%");    //Send all values to the plane
  println("Sent Message is: S," + str(round(throttle)) + "," + str(round(ailerons)) + "," + str(round(elevator)) + "," + str(round(rudder)) + ",%");
}

void checkNumInc() {
  posInArr = 10;
  while (posInArr > 0) {
    checkNum[posInArr] = checkNum[posInArr - 1];  
    posInArr -= 1;
  }
}

boolean mesLagCheck() {
  if (int(messages[5]) == checkNum[0]) {          // Lag / serial buffer check
    println("Message latency: 0");
    lagCheckDelay = 0;
    return true;
  } else if (messages[5].equals(str(checkNum[1]))) {       
    println("Message latency: 1");
    lagCheckDelay = 1;
    return true;
  } else if (messages[5].equals(str(checkNum[2]))) {       
    println("Message latency: 2");
    lagCheckDelay = 2;
    return true;
  } else if (messages[5].equals(str(checkNum[3]))) {       
    println("Message latency: 3");
    lagCheckDelay = 3;
    return true;
  } else if (messages[5].equals(str(checkNum[4]))) {       
    println("Message latency: 4");
    lagCheckDelay = 4;
    return true;
  } else if (messages[5].equals(str(checkNum[5]))) {       
    println("Message latency: 5");
    lagCheckDelay = 5;
    return true;
  } else if (messages[5].equals(str(checkNum[6]))) {       
    println("Message latency: 6");
    lagCheckDelay = 6;
    return true;
  } else if (messages[5].equals(str(checkNum[7]))) {       
    println("Message latency: 7");
    lagCheckDelay = 7;
    return true;
  } else if (messages[5].equals(str(checkNum[8]))) {       
    println("Message latency: 8");
    lagCheckDelay = 8;
    return true;
  } else {
    println("Max message lag exceded");
    serialFlush();
    return false;
  }
}

void serialFlush() {
  println("---------------------| Flushing |-------------------------");
  serialPort.clear();
  delay(100);
}

