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
void barometer(float millibars,int X, int Y,float rangeStart,float rangeEnd){
  if(millibars>rangeEnd){
    millibars = rangeEnd;
  }
  if(millibars<rangeStart){
    millibars=rangeStart;
  }
  pushMatrix();
  translate(X,Y);
  stroke(100,255,0);
  stroke(255,100,0,100);
  rect(0,-10,60,130);
  rect(57,-55,50,40);
  textFont(font1,12);
  text("mB",57,-65);
  textFont(font1,12);
  text(nf(millibars,1,1),57,-50);
  for(float i=rangeStart/10;i<=rangeEnd/10;i+=2){
    if(i<=millibars/10){
      stroke(255,100,0);
    }else{
    stroke(255,100,0,130);
    }
    line(-25,100-i*2+rangeStart/10,5,100-i*2+rangeStart/10);
    textFont(font1,9);
    if(i%10 == 0){
    text(nf(i*10,1,0),17,103-i*2+rangeStart/10);
    }
  }
  popMatrix();
}
