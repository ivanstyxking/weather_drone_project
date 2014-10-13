class Graph {

  //Variables and setup stuff 
  int offSetX = 0;
  int offSetY = 0;
  float dataRangeLower = 0;
  float dataRangeUpper = -100;
  int dataNum;
  int lastMillis = 0;
  int updateInt;
  int displaySide = LEFT;
  boolean showLines = true;

  Graph (int num, int time, float range1, float range2) {
    dataNum = num;
    updateInt = time;
    dataRangeLower = range1;
    dataRangeUpper = range2;
  }
  void update() {
    pushMatrix();  // Pushes the matrix
    translate(offSetX, offSetY);  // Applys the transformation
    //Stuff to run in the update loops
    stroke(100, 255, 0);


    if (displaySide == 37) {  // Is text is to be displayed on the left
      textAlign(RIGHT);
      fill(100, 255, 0, 255);
      text(int(dataRangeUpper), -2, 5);
      text(int(dataRangeLower), -2, 125);
      text(0, 5, 132);
      text(int(0.04*updateInt), 210, 132);
    }
    if (displaySide == 39) {  // Is text is to be displayed on the right
      textAlign(LEFT);
      fill(255, 100, 0, 255);
      text(int(dataRangeUpper), 220, 5);
      text(int(dataRangeLower), 224, 125);
      text(int(0.04*updateInt), 210, 132);
    }

    if (showLines) {
      line(0, 120, 220, 120);
      line(0, 0, 0, 120);
      for (int x = 20; x <= 220; x+= 20) {  // Draw Horizontal lines
        stroke(100, 255, 0, 70);
        line(x, 0, x, 120);
      }
      for (int x = 0; x < 120; x+= 20) {  // Draw Vertical lines
        stroke(100, 255, 0, 70);
        line(0, x, 220, x);
      }
    }
    for (int x = 0; x < data[dataNum].length; x++) {  // Draw data points 
      noFill();
      if (displaySide == 37) {
        stroke(100, 255, 255);
      }
      if (displaySide == 39) {
        stroke(255, 100, 0, 255);
      }
      float temp;
      if (data[dataNum][x] < dataRangeLower) {
        temp = dataRangeLower;
      } else {
        temp = data[dataNum][x];
      }        
      ellipse(x*5, map(temp, dataRangeLower, dataRangeUpper, 120, 0), 2, 2);
    }

    for (int x = 0; x < data[dataNum].length-1; x++) { 
     float temp1;
      if (data[dataNum][x] < dataRangeLower) {
        temp1 = dataRangeLower;
      } else {
        temp1 = data[dataNum][x];
      } 
     float temp2;
      if (data[dataNum][x+1] < dataRangeLower) {
        temp2 = dataRangeLower;
      } else {
        temp2 = data[dataNum][x+1];
      }  
      line(x*5, map(temp1, dataRangeLower, dataRangeUpper, 120, 0), x*5+5, 
      map(temp2, dataRangeLower, dataRangeUpper, 120, 0));  // Connects data points
    }
    popMatrix();  // Pops the matrix

      if (millis() - lastMillis > updateInt) { // Array shifts at update interval
      data[0][0] = 50;//pressureMB;
      data[1][0] = 980;//humidityDHT;
      
      lastMillis = millis();
      for (int x = data[dataNum].length-1; x > 0; x--) {
        data[dataNum][x] = data[dataNum][x - 1];
      }
    }
  }
  void posistion(int x, int y, int side, boolean show) {
    offSetX = x;
    offSetY = y;
    displaySide = side;  //Left is 37 Right is 39
    showLines = show;
  }
  void drawExtra(int x, int y, int lengthX, int lengthY) {
    rect(x, y, lengthX, lengthY);  // Rectangle for the graph
    text("Humidity & Pressure", 301, 532);
  }
}

