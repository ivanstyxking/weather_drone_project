void keyPressed(){
  if(key == BACKSPACE){
    waypointcount--;
    if(waypointcount<1){
      waypointcount=0;
    }
  }
  if(key == CODED){
    if(keyCode == UP){
      targetWP++;
    }
    if(keyCode == DOWN){
      targetWP--;
    }
  }
  if(targetWP>waypointcount){ //if target exceeds array index
    targetWP-=waypointcount; //loops to beginning
  }
  if(targetWP<1){ //if array index out of below 0th index
    targetWP = waypointcount; //loop to last
  }
}
