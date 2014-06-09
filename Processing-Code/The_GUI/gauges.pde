void gauge(int shift,float value, float scale, String name){
  strokeWeight(1);
  noFill();
  rectMode(CENTER);
  float xpos = width-40*shift;
  rect(xpos,160,20,300);
  strokeWeight(10);
  line(xpos,300,xpos,310-value*scale);
  textFont(font1,12);
  fill(100,255,0);
  textAlign(CENTER);
  text("data gauges",width-425, 30);
  text(name,xpos,320); //display gauge names
  textFont(font1,10);
  text(int(value),xpos,300-value*scale); //display gauge value
  noFill();
  strokeWeight(1);
}
