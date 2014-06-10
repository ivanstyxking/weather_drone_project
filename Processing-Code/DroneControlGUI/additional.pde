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
