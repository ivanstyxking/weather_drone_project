//main procedure

import processing.serial.*;

float originX =756;
float originY =480;
float diam = 300;

PFont font1;
float airspeed = 30;
float alt = 3301;

int heading, targetValue,heading2; 
int targetWP = 2;

boolean sending, recieving;
boolean release, mouseOver, info;

int ymouse, xmouse;

float yval, xval, x, y, yvar, rotation, gX, gY, pX, pY, altSync, homeX, homeY;
float[] waypointX = new float[64];
float[] waypointY = new float[64];
int[] sensors = new int[5];

float bmpTemperature = 32;
float dhtTemperature = 34;

int waypointcount = 0;

float tempx, tempy, syncX, syncY, scale, initX, initY;
float angle = 0;

float throttle = 0;
float ailerons = 90; //Default (center values)
float ailerons2 = 90;
float elevator = 90;
float rudder = 90;
float gear = 20;

String[] messages = new String[10];
float[] orientation = new float[3];
int[] servoPos = new int[11];
int[] checkNum = new int[11];

long timeoutStart = 0;
long timeoutCurrent = 0;

char incomingChar;
String incomingString;
String outgoingString;

int commaPosition;
int messageNum;
int posInArr;

Serial serialPort;

void setup() {
  heading2 = 0; //temporary

  String portName = Serial.list()[0];
  serialPort = new Serial(this, portName, 115200);

  info = false;
  homeX = 0;
  homeY = 0;
  syncX = 0;
  syncY = 0;
  scale = 1;
  size(1000, 700);
  stroke(100, 255, 0);
  font1 = createFont("Consolas", 14, true);
}
void draw() {
  strokeWeight(1);
  background(0);
  heading = -1*int(0.1*angle);
  displaymap(tempx, tempy);
  edges(); //display objects only in map region
  lockGPS(false); //the argument here will have to communicate with the arduino code
  gauge(1, ailerons, 1.4, "ailrs"); //guage args : [int shift, float value, float scaler, String name]
  gauge(2, ailerons2, 1.4, "ailrs2");
  gauge(3, elevator, 1.4, "elev");
  gauge(4, throttle, 1.4, "throt");
  gauge(5, rudder, 1.4, "rud");
  gauge(6,gear,1.4,"gear");
  tempDisplay(bmpTemperature,dhtTemperature,685,200);
  barometer(999,570,395,990,1030);
  navball();
  scaling_button();
  console_out();
  orbit(0.1*angle);
  button(530, 270, "map sync", 1); //GUI buttons :: [position x, position y, name, case procedure]
  button(635, 270, "alt sync", 2);
  button(635, 240, "home", 3);
  button(530, 240, "info", 4);
  clock();
  angle++;
  
  serialRequest();
  sendSerial();
  
  throttle = mouseY;
}
void orbit(float angle) { //temporary code - simulates the glider positions
  angle=radians(angle);
  tempx = 100*cos(angle);
  tempy = 100*sin(angle);
  alt+=0.2;
}


