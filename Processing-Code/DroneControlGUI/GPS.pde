void lockGPS(boolean areyouthere){
  if(!areyouthere){
    textFont(font1,30);
    if(millis()-(millis()-millis()%1000)>500){
      noFill();
      stroke(255,0,0,150);
      rect(166,254,198,30);
      fill(255,0,0,150);
      text("No GPS lock",175,280);
    }
  }
  stroke(100,255,0);
  noFill();
}
