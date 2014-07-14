void keyPressed(){ //key operations controlling map
  if(key == BACKSPACE){ //remove most recent waypoint (points to an array index)
    waypointcount--;
    if(waypointcount<1){
      waypointcount=0;
    }
  }
  if(key == CODED){
    if(keyCode == UP){ //select the target wp
      targetWP++;
    }
    if(keyCode == DOWN){
      targetWP--;
    }
  }
  if(targetWP>waypointcount){ //if target exceeds array index
    targetWP-=waypointcount; //loops to beginning
  }
  if(targetWP<1){ //if array index below 0th index
    targetWP = waypointcount; //loop to last
  }
}
//Let me just comment here to explain what this procedure does
void tempDisplay(float temp1, float temp2, int X, int Y){
  pushMatrix();
    translate(X,Y);
    rect(0,0,150,50);
    textFont(font1,12);
    stroke(100,255,0,70);
    rect(-35,0,60,40);
    rect(35,0,60,40);
    text("bmp",-38,-10);
     text("dht",30,-10);
     text("Temperature",0,-30);
    textFont(font1,20);
    text(nf(temp1, 1, 1),-38,15);
    stroke(100,255,0);
    ellipse(-9,-5,5,5);
    fill(255,100,0);
    text(nf(temp2, 1, 1),32,15);
    noFill();
    stroke(255,100,0);
    ellipse(60,-5,5,5);
  popMatrix();
}
