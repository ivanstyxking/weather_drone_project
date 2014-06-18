void clock(){ //pushMatrix/popMatrix are AMAZING
  stroke(75,192,0);
  noFill();
  ellipse(586,100,100,100);
  pushMatrix();
  translate(586,100);
  for(int b=1;b<=12;b++){
    line(0,50,0,40);
    rotate(radians(30));
  }
  pushMatrix();
  rotate(radians(second()*6+180)); //display seconds
  strokeWeight(1);
  stroke(255,100,0,180);
  line(0,0,0,50);
   stroke(100,255,0,150);
  popMatrix();
  pushMatrix();
  rotate(radians(minute()*6+180)); //display minutes
  strokeWeight(2);
  line(0,0,0,40);
  popMatrix();
  pushMatrix();
  float hour = hour();
  if(hour() > 12){
    hour-=12; 
  }
  rotate(radians(hour()*30+minute()/2+180)); //display hour with the minutes into account
  strokeWeight(3);
  line(0,0,0,30);
  popMatrix();
  popMatrix();
  stroke(100,255,0);
  strokeWeight(1);
}
