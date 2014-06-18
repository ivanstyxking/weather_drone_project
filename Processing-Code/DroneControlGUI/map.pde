//map stuff
void edges() { //add opaque borders around map
  noStroke();
  fill(0);
  rect(0, 18, 10, 501);
  rect(0, 519, width, height);
  rect(0, 0, width, 18);
  rect(511, 18, width-511, 518);
  stroke(100, 255, 0);
  fill(100, 255, 0);
}
void displaymap(float x, float y) { //main map procedure
  rect(10, 18, 500, 500); //initial border
  textFont(font1, 12);
  fill(100, 255, 0);
  noFill();
  pushMatrix();
    translate(-1*syncX, -1*syncY); //translate all events to the current sync position
    wayPoint(); //drag circle
    translate(260, 268);
    displayWaypoints(); //self explanatory
    targetwaypoint(targetWP); //display the target information
    translate(syncX, syncY);
    grid();
  popMatrix();
  pushMatrix();
    positioning(x, y);
  popMatrix();
}
void grid() {
  strokeWeight(1);
  stroke(100, 255, 0, 75);
  for (int i = -250; i<250;i+=10) {
    i+=10;
    line(i, -250, i, 250);
  }
  for (int j = -250;j<250;j+=10) {
    j+=10;
    line(-250, j, 250, j);
  }
  stroke(255, 0, 0, 75);
  line(-250, 0, 250, 0);
  line(0, -250, 0, 250);
  stroke(100, 255, 0, 255);
}
void glider() {
  strokeWeight(2);
  line(0, -7, 0, 7);
  line(-8, 4, 8, 4);
  line(-1, -6, 1, -6);
  strokeWeight(1);
}
void positioning(float x, float y) {
  textAlign(LEFT);
  fill(100, 255, 0);
  text("x = "+int(round((x-syncX) )), 20, 30);
  text("y = "+int(round((y+syncY) )), 20, 50);
  text("1 pix = "+nf(scale, 1, 2)+"m", 400, 30);
  translate(10, 18);
  gX = x;
  gY = -1*y;
  y=250+-1*y;
  x=x+250;
  translate(x-syncX, y-syncY);
  pushMatrix();
  rotate(radians(heading+180));
  glider();
  popMatrix();
}
void wayPoint() {
  if ((mousePressed)&&(mouseX>10)&&(mouseX<510)&&(mouseY>18)&&(mouseY<518)) {
    fill(0, 255, 0);
    ellipse(mouseX+syncX, mouseY+syncY, 10, 10);
    noFill();
  }
}
void mouseReleased() {
  release = true;
  if ((mouseX>10)&&(mouseX<510)&&(mouseY>18)&&(mouseY<518)) {
    waypointcount++;
    if(waypointcount>64){
      waypointcount=64;
    }
    ymouse = int((mouseY+syncY));
    xmouse = int((mouseX+syncX));
    yval = (-1*(268+-1*ymouse));
    xval = (xmouse -260) ;
    waypointX[waypointcount-1] = xval;
    waypointY[waypointcount-1] = yval;
  }
}
void displayWaypoints() {
  homeWaypoint(homeX,homeY);
  for (int moo = 0;moo<=waypointcount-1;moo++) {
    if (moo == targetValue) {
      fill(100, 255, 0);
      ellipse(waypointX[moo], waypointY[moo], 18, 18);
      fill(0);
      text(moo+1, waypointX[moo], waypointY[moo]+4);
    }
    else {
      noFill();
      ellipse(waypointX[moo], waypointY[moo], 18, 18);
      fill(100, 255, 0);
      text(moo+1, waypointX[moo], waypointY[moo] +5);
    }
    if (moo>=1) {
      stroke(100, 255, 0, 125);
      line(waypointX[moo], waypointY[moo], waypointX[moo-1], waypointY[moo-1] );
      stroke(100, 255, 0);
    }
  }
}
void homeWaypoint(float x,float y){
  ellipse(x,y,18,18);
  text("H",x,y+4);
}
void targetwaypoint(int target) {
  target-=1;
  targetValue = target;
  strokeWeight(2);
  stroke(255,0,0,125);
  if(info){
  line(gX,gY,homeX,homeY);
   text(int(round(sqrt(sq(gX-homeX)+sq(gY-homeY)))),(gX+homeX)/2,(gY+homeY)/2);
  }
  stroke(100,255,0,125);
  if ((waypointcount >= target+1)&&(info)) {
    float targX = waypointX[target];
    float targY = waypointY[target];
    if (target>0) {
      pX = waypointX[target-1];
      pY = waypointY[target-1];
    }
    else {
      pX = waypointX[target];
      pY = waypointY[target];
    }
    line(gX, gY, targX, targY);
    line(gX, gY, pX, pY );
    fill(100, 255, 0);
    int distance_to_target = int(round(sqrt(abs(sq(gY-targY)+sq(gX-targX))))); //distance of glider to target waypoint
    int distance_to_prev = int(round(sqrt(abs(sq(gY-pY)+sq(gX-pX))))); //distance of glider to previous waypoint
    float d = abs((targX-pX)*(pY-gY)-(pX-gX)*(targY-pY))/sqrt(sq(targX-pX)+sq(targY-pY)); //find length of glider from linear route
    float theta=atan(-1*(targX-pX)/(targY-pY));
    float Xintercept =  d*cos(theta);
    float Yintercept= d*sin(theta);
    if ((((gX+Xintercept>=pX)&&(gX+Xintercept<=targX))||((gX+Xintercept>=targX)&&(gX+Xintercept<=pX)))&&
      (((gY+Yintercept>=pY)&&(gY+Yintercept<=targY))||((gY+Yintercept>=targY)&&(gY+Yintercept<=pY)))) {
      line(gX, gY, gX+Xintercept, gY+Yintercept);
    }
    else {
      Xintercept = d*cos(theta+radians(180));
      Yintercept = d*sin(theta+radians(180));
      line(gX, gY, gX+Xintercept, gY+Yintercept);
    }
    textFont(font1, 12);
    text(int(distance_to_target ), (gX+targX)/2, (gY+targY)/2);
    text(int(distance_to_prev ), (gX+pX)/2, (gY+pY)/2);
    if(target>0){
    text(int(round(d)), (2*gX+Xintercept)/2, (2*gY+Yintercept)/2);
    }
    fill(255,0,0);
    text(int(round(sqrt(sq(gX-homeX)+sq(gY-homeY)))),(gX+homeX)/2,(gY+homeY)/2);
    strokeWeight(1);
  }
  noFill();
}
void button(float buttonX, float buttonY, String name, int function) {
  pushMatrix();
  translate(buttonX, buttonY);
  noFill();
  if ((mouseX>=buttonX)&&(mouseX<=buttonX+100)&&
    (mouseY>buttonY)&&(mouseY<buttonY+25)) {
    strokeWeight(2);
    if (mousePressed) {
      fill(100, 255, 0);
      buttonFunction(function);
    }
  }
  rect(0, 0, 100, 25);
  text(name, 50, 17);
  popMatrix();
  strokeWeight(1);
}
void scaling_button() {
  pushMatrix();
  translate(0,-50);
  rect(530, 200, 25, 25);
  if ((mouseX>=530)&&(mouseX<=555)&&
    (mouseY+50>=200)&&(mouseY+50<=225)) {
      strokeWeight(2);
      rect(530, 200, 25, 25);
    if (mousePressed) {
      scale+=0.01;
    }
  }
  strokeWeight(1);
  rect(530, 230, 25, 25);
  if ((mouseX>=530)&&(mouseX<=555)&&
    (mouseY+50>=230)&&(mouseY+50<=255)) {
      strokeWeight(2);
      rect(530, 230, 25, 25);
    if (mousePressed) {
      scale-=0.01;
    }
  }
  strokeWeight(3);
  line(535, 242.5, 550, 242.5);
  line(542.5, 205, 542, 220);
  line(535, 212.5, 550, 212.5);
  strokeWeight(1);
  popMatrix();
}
void buttonFunction(int k) { //value k selects the procedure that the button executes
  switch(k) {
  case 1: 
    syncX = gX;
    syncY = gY; 
    break;
  case 2:
    altSync = alt;
    break;
  case 3:
    homeX = gX;
    homeY = gY;
    break;
  }
}
void mousePressed(){
  if((mouseX>530)&&(mouseX<630)&&
  (mouseY>240)&&(mouseY<265)) {
    info = !info;
  }
}

