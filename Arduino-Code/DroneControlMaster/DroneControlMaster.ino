#include <Wire.h>
#include <Servo.h>

char incomingChar;
String incomingString;
String outgoingString;

int commaPosition;
int messageNum;

String messages[5]; // Incoming messages
int servoPos[5]; // Positions of the servos

unsigned long timeoutStart = 0;
unsigned long timeoutCurrent = 0;

boolean serialLoop = false;

Servo myServo1;
Servo myServo2;
Servo myServo3;


void setup()
{ 
  Serial.begin(115200);

  I2C_Init();

  myServo1.attach(9);
  myServo2.attach(10);
  myServo3.attach(11);
  

  servoPos[1] = 90;
  servoPos[2] = 90;
  servoPos[3] = 90;
  incomingString = "";
}

void loop() { //Main Loop

  serialCheck();
  servoSet();
}



