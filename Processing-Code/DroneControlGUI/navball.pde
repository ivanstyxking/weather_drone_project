void navball() {
  stroke(100,255,0);
  rect(756, 495, 454, 383);
  textFont(font1, 12);
  fill(100,255,0);
  text("navball", width-450, height-475);
  noFill();
  ellipse(originX, originY, diam, diam);
  altimeter(altitudeGPS-altSync);
  speedo();
  lines();
  compass(int(headingGPS),165,-80,"GPS");
  compass(heading2,-165,-80,"Magnetic");
  yvar = 5*(orientation[0]);
  rotation = -2*(orientation[1]);
  pushMatrix();
  translate(originX, originY);
  rotate(radians(rotation));
  for (float y = -diam/2+diam/18;y<=diam/2-diam/18;y=y+diam/9) {
    line(-20, y, 20, y);
    text(round(y*3/10), -32, y);
    text(round(y*3/10), 30, y);
  }

  fill(0, 255, 0, 50);
  arc(0, 0, diam, diam, 6*asin(yvar/diam/2), radians(180)-6*asin(yvar/diam/2), CHORD);
  noFill();
  popMatrix();
}

void lines() {
  pushMatrix();
  translate(originX, originY);
  strokeWeight(3);
  stroke(100, 255, 0, 150);
  line(-50, 0, -diam/2, 0);
  line(-50, 3, -50, 10);
  line(50, 0, diam/2, 0);
  line(50, 3, +50, 10);
  rectMode(CENTER);
  rect(0, 0, 10, 10);
  rectMode(CORNER);
  textFont(font1, 10);
  textAlign(CENTER);
  strokeWeight(2);
  fill(100, 255, 0, 150);

  stroke(100, 255, 0, 255);

  strokeWeight(1);
  popMatrix();
}
void altimeter(float alt) {
  rect(originX+190, originY, 50, 20);
  text(round(alt), originX+190, originY+5);
}
void speedo() {
  rect(originX-190, originY, 50, 20);
  text(round(speedMpsGPS), originX-190, originY+5);
}
void compass(int bearing, int compx,int compy, String type) {
  pushMatrix();
  translate(compx,compy);
  fill(100,255,0);
  text(type,originX,originY+150);
  pushMatrix();
  translate(originX, originY+220);
  stroke(255, 0, 0, 200);
  line(0, -25, 0, -50);
  stroke(100, 255, 0);
  noFill();
  ellipse(0, 0, 100, 100);
  textFont(font1, 18);
  while ( (bearing>360)||(bearing<0)) {
    if (bearing>360) {
      bearing-=360;
    }
    if (bearing<0) {
      bearing+=360;
    }
  }
  String bearing_str = str(bearing);
  if (bearing_str.length() == 1) {
    text("00"+bearing_str, 0, 3);
  }
  if (bearing_str.length() == 2) {
    text("0"+bearing_str, 0, 3);
  }
  if (bearing_str.length() == 3) {
    text(bearing_str, 0, 3);
  }
  fill(255, 0, 0);
  bearing=bearing*-1;
  rotate(radians(bearing));
  stroke(100, 255, 0, 100);
  line(0, 50, 0, 25);
  line(50, 0, 25, 0);
  line(0, -50, 0, -25);
  line(-50, 0, -25, 0);
  for(float a=22.5;a<=67.5;a=a+22.5){
  compassgrid(a);
  }
  text("N", 0, -55);
  fill(0, 255, 0);
  textFont(font1, 12);
  text("E", 55, 0);
  text("S", 0, 60);
  text("W", -55, 0);
  popMatrix();
  fill(100, 255, 0, 150);
  stroke(100, 255, 0, 255);
  popMatrix();
}
void compassgrid(float angle){
  pushMatrix();
  rotate(radians(angle));
  line(0, 50, 0, 40);
  line(50, 0, 40, 0);
  line(0, -50, 0, -40);
  line(-50, 0, -40, 0);
  popMatrix();
}

