import procontroll.*;
import net.java.games.input.*;

//main procedure

import processing.serial.*;

float originX =756;
float originY =480;
float diam = 300;

PFont font1;

int pageNum = 1;
int serialPortNum = 0;
boolean usingController = true;

int targetValue, heading2; 
int targetWP = 1;

boolean sending, recieving;
boolean release, mouseOver, info;

int ymouse, xmouse;

float yval, xval, x, y, yvar, rotation, gX, gY, pX, pY, altSync, homeX, homeY;
float[] waypointX = new float[64];
float[] waypointY = new float[64];
int[] sensors = new int[5];

int waypointcount = 0;

float tempx, tempy, syncX, syncY, scale, initX, initY;

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
long previousMillis = 0;

char incomingChar;
String incomingString;
String outgoingString;

int commaPosition;
int messageNum;
int posInArr;
int requestNumber = 1;
int lagCheckDelay;
int sensorGroup;

float pressureMB;
float humidityDHT;
float temperatureDHT;
float heatIndexDHT;
float temperatureBMP;

float lattitudeGPS;
float longitudeGPS;
float speedMpsGPS;
float headingGPS;
float altitudeGPS;
float satillitesGPS;

Serial serialPort;

ControllIO controller;
ControllDevice device;
ControllStick leftStick;
ControllStick rightStick;
ControllSlider throttleSlider;
ControllButton aButton;
ControllButton bButton;

void setup() {
  heading2 = 0; //temporary

  info = false;
  homeX = 0;
  homeY = 0;
  syncX = 0;
  syncY = 0;
  scale = 1;
  size(350, 300);
  stroke(100, 255, 0);
  font1 = createFont("Consolas", 14, true);
}
void draw() {
  strokeWeight(1);
  background(0);

  if (pageNum == 2) {
    mainPage();
  } else {
    setupPage();
  }
}

void mainPage() {
  // heading = -1*int(0.1*angle);
  displaymap(tempx, tempy);
  edges(); //display objects only in map region
  lockGPS(); //the argument here will have to communicate with the arduino code
  gauge(1, ailerons, 1.3, "ailrs"); //guage args : [int shift, float value, float scaler, String name]
  gauge(2, ailerons2, 1.3, "ailrs2");
  gauge(3, elevator, 1.3, "elev");
  gauge(4, throttle, 1.3, "throt");
  gauge(5, rudder, 1.3, "rud");
  gauge(6, gear, 1.3, "gear");
  tempDisplay(temperatureBMP, temperatureDHT, 660, 200);
  barometer(pressureMB, 570, 395, 990, 1030);
  hygrometer(humidityDHT, width-58, 395, color(0, 255, 255));
  signalStrength(90, 635, 60);
  navball();
  scaling_button();
  console_out();
  //orbit(0.1*angle);
  button(530, 270, "map sync", 1); //GUI buttons :: [position x, position y, name, case procedure]
  button(635, 270, "alt sync", 2);
  button(635, 240, "home", 3);
  button(530, 240, "info", 4);
  clock();
  //angle++;

  if (millis() - previousMillis >= 20) {
    previousMillis = millis();

    sendValuesSerial();  // Only called once every IDK
    serialRequestNum();  // Only called once every 10ms
  }

  serialRecieve();

  if (usingController) {  // Get controller values
    ailerons = 90 + rightStick.getX();
    rudder = 90 + leftStick.getX();
    elevator = 90 + leftStick.getY();
    throttle = 90 + throttleSlider.getValue();
  } else {  // Get mouse values
    throttle = mouseY;
  }
}

void setupPage() {
  fill(0, 0, 0);
  rect(45, 85, 135, 20);
  rect(45, 110, 135, 20);
  rect(45, 150, 50, 20);  // Text boxes

  rect(190, 85, 20, 20);
  rect(215, 85, 20, 20);
  rect(240, 85, 20, 20);  // Serial number boxes

  if (usingController) {
    fill(100, 255, 0);
    rect(190, 110, 32.5, 20);
    fill(0, 0, 0);
    rect(227.5, 110, 32.5, 20);
    text("Yes", 196.5, 125);
    fill(100, 255, 0);
    text("No", 236.5, 125);
  } else {
    fill(100, 255, 0);
    rect(227.5, 110, 32.5, 20);  // Controller buttons
    fill(0, 0, 0);
    rect(190, 110, 32.5, 20);
    text("No", 236.5, 125);
    fill(100, 255, 0);
    text("Yes", 196.5, 125);
  }

  textFont(font1, 20);
  fill(100, 255, 0);
  text("Weather Drone Control", 50, 50);

  textFont(font1, 12);
  fill(100, 255, 0);
  text("Serial Port", 75, 100);
  text("+", 197.5, 100);
  text(serialPortNum, 222, 100);
  text("-", 247, 100);
  text("Use Xbox controller", 50, 125);
  text("Launch", 50, 165);
}

void launch() {
  try {
    String portName = Serial.list()[serialPortNum];
    serialPort = new Serial(this, portName, 57600);
    pageNum = 2;
  }
  catch (Exception e) {
    println("Something broke");
    pageNum = 1;
    return;
    // Invalid serial port code
  }
  frame.setSize(1004, 728);
  size(1000, 700);
  stroke(100, 255, 0);
  font1 = createFont("Consolas", 14, true);

  if (usingController) {  // Controller setup code
    controller = ControllIO.getInstance(this);
    device = controller.getDevice("Controller (XBOX 360 For Windows)");
    device.setTolerance(0.05f);
    
    ControllSlider leftSliderX = device.getSlider("X Axis");
    ControllSlider leftSliderY = device.getSlider("Y Axis");
    ControllSlider rightSliderX = device.getSlider("X Rotation");
    ControllSlider rightSliderY = device.getSlider("Y Rotation");
    throttleSlider = device.getSlider("Z Axis");
    
    leftStick = new ControllStick(leftSliderX, leftSliderY);
    rightStick = new ControllStick(rightSliderX, rightSliderY); 
    leftStick.setMultiplier(90f);
    rightStick.setMultiplier(90f);
    throttleSlider.setMultiplier(90f);
  }
}

void orbit(float angle) { //temporary code - simulates the glider positions
  angle=radians(angle);
  tempx = 100*cos(angle);
  tempy = 100*sin(angle);
}

