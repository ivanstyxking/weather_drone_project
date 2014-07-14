void console_out(){ //I'll work on this later...
  rectMode(CORNER);
  textFont(font1,12);
  fill(100,255,0);
  text("Console",40,height-170);
  text("map", 20, 15);
  noFill();
  rect(10,height-165,500,150);
  content();
}
void content(){
  textFont(font1,12);
  textLeading(10);
  textAlign(LEFT);
  text("Array 1: " + checkNum[0] + "\n" + 
       "Array 2: "+checkNum[1] + "\n" +
       "Array 3: "+checkNum[2] + "\n" +
       "Array 4: "+checkNum[3] + "\n" +
       "Array 5: "+checkNum[4] + "\n" +
       "Array 6: "+checkNum[5] + "\n" +
       "Array 7: "+checkNum[6] + "\n" +
       "Array 8: "+checkNum[7] + "\n" +
       "Check number is: " + checkNum[0]+"\n" +
       "Sent message is: " + "R," + sensorGroup + "," + checkNum[0] + ",%" + "\n" +
       "Lag Check Delay: " + lagCheckDelay 
       ,20,height-150);
  textAlign(CENTER);
}
