void gauge(int shift,float value, float scale, String name){
  //value;
  if(value>180){
    value=180;
  }
  if(value<0){
    value=0;
  }
  strokeWeight(1);
  noFill();
  rectMode(CENTER);
  float xpos = width-40*shift;
  rect(xpos,145,20,260);
  strokeWeight(10);
  line(xpos,270,xpos,270-value*scale);
  textFont(font1,12);
  fill(100,255,0);
  textAlign(CENTER);
  text("data gauges",width-425, 30);
  text(name,xpos,295); //display gauge names
  textFont(font1,10);
  text(int(value),xpos,277-value*scale-15); //display gauge value
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
  for(float i=rangeStart;i<=rangeEnd;i+=1){
    if(i<=millibars){
      stroke(255,100,0);
    }else{
    stroke(255,100,0,130);
    }
    line(-25,50-(rangeStart-i)*-3,5,50-(rangeStart-i)*-3);
    textFont(font1,9);
    if(i%5 == 0){
    text(nf(i,1,0),17,53-(rangeStart-i)*-3);
    }
  }
  popMatrix();
}
void hygrometer(float value, int X, int Y, color c){
  pushMatrix();
    translate(X,Y);
    stroke(c,100);
    rect(0,-10,60,130);
    rect(-57,-55,50,40);
    textFont(font1,12);
    fill(c);
    text("%",-57,-65);
    text(nf(value,1,1),-57,-50);
    noFill();
    for(float i=0;i<=60;i++){
      if(i<=value*60/100){
        stroke(c);
      }else{
        stroke(c,130);
      }
      strokeWeight(1);
      line(-25,50+(i)*-2,5,50+(i)*-2);
      if(i%6==0){
        textFont(font1,9);
        text(nf(i*10/6,1,0),17,53-i*2);
      }
    }
  popMatrix();
}

void signalStrength(float strength, int X, int Y) {
  pushMatrix();
  translate(X, Y);
  textAlign(LEFT);
  fill(100,255,0);
  text("signal :",0,-35);
  fill(100, 255, 0);
  colorMode(HSB, 300, 1, 1);
  textFont(font1,18);
  fill(strength,1,1);
  text(nf(strength,1,1)+"%",0,-20);
  textSize(9);
  for (int i=0;i<=100;i++) {
    if (i<=strength) {
      stroke(strength, 1, 1);
    }
    else {
      stroke(strength, 1, 1, 100);
    }
    if (i%2==0) {
      line(i, 0, i, -i/3);
    }
    if (i%10 == 0) {
      pushMatrix();
      translate(i, -i+3);
      rotate(PI/2);
      fill(strength, 1, 1);
      text(i, i, 0);
      popMatrix();
    }
  }
  popMatrix();
  colorMode(RGB, 255);
  noFill();
  textAlign(CENTER);
}
