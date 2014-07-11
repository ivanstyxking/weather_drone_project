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
    rect(0,0,100,50);
    textFont(font1,12);
    stroke(100,255,0,70);
    rect(-23,0,40,40);
    rect(23,0,40,40);
    text("bmp",-25,-10);
     text("dht",20,-10);
     text("Temperature",0,-30);
    textFont(font1,30);
    text(nf(temp1, 2, 1),-25,15);
    stroke(100,255,0);
    ellipse(-6,-5,5,5);
    fill(255,100,0);
    text(nf(temp2, 2, 1),20,15);
    noFill();
    stroke(255,100,0);
    ellipse(39,-5,5,5);
  popMatrix();
}
