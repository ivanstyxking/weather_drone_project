
float originX =756;
float originY =500;
float diam = 300;
PFont font1;
float airspeed = 30;
float alt = 3301;
int heading,targetValue;
int targetWP = 2;
boolean sending,recieving;
boolean release,mouseOver,info;
int ymouse,xmouse;
float yval,xval,x,y,yvar,rotation,gX,gY,pX,pY,altSync,homeX,homeY;
float[] waypointX = new float[1000];
float[] waypointY = new float[1000];
int waypointcount = 0;
float tempx,tempy, syncX, syncY,scale,initX,initY;
float angle = 0;
void setup(){
  info = false;
  homeX = 0;
  homeY = 0;
  syncX = 0;
  syncY = 0;
   scale = 1;
  size(1000,800);
  stroke(100,255,0);
  font1 = createFont("Consolas",14,true);
}
void draw(){
  strokeWeight(1);
  background(0);
  heading = -1*int(0.1*angle);
  displaymap(tempx,tempy);
  edges(); //display objects only in map region
  lockGPS(false);
  gauge(1,255,1,"var1");
  gauge(2,133,1,"var2");
  gauge(3,50,1,"var3");
  gauge(4,270,1,"var4");
  gauge(5,100,1,"var5");
  navball();
  scaling_button();
  console_out();
  orbit(0.1*angle);
  
  button(530,270,"map sync",1);
  button(635,270,"alt sync",2);
  button(635,240,"home",3);
  button(530,240,"info",4);
  clock();
  angle++;
  if(mouseOver){
    cursor(HAND);
  }else{
  }
}
void orbit(float angle){ //temporary code - simulates the glider positions
  angle=radians(angle);
  tempx = 100*cos(angle);
  tempy = 100*sin(angle);
  alt+=0.2;
}




