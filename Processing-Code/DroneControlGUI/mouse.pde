
void mouseReleased() {
  release = true;
  if (pageNum == 2) {
    if ((mouseX>10)&&(mouseX<510)&&(mouseY>18)&&(mouseY<518)) {
      waypointcount++;
      if (waypointcount>64) {
        waypointcount=64;
      }
      ymouse = int((mouseY+syncY));
      xmouse = int((mouseX+syncX));
      yval = (-1*(268+-1*ymouse));
      xval = (xmouse -260) ;
      waypointX[waypointcount-1] = xval;
      waypointY[waypointcount-1] = yval;
    }
  }
  if (pageNum == 1) {
    if (mouseX >= 45 && mouseX <= 95 && mouseY >= 150 && mouseY <= 170) { // Checks launch button
      launch();
    }

    if (mouseX >= 190 && mouseX <= 210 && mouseY >= 85 && mouseY <= 105) {  // Checks '+' button
      serialPortNum ++;
    }
    if (mouseX >= 240 && mouseX <= 260 && mouseY >= 85 && mouseY <= 105) {  // Checks '-' button
      if (serialPortNum >= 1) {
        serialPortNum --;
      } else {
        serialPortNum = 0;
      }
    }
    if (mouseX >= 190 && mouseX <= 212.5 && mouseY >= 110 && mouseY <= 130) {  // Checks 'Yes' button
      usingController = true;
    }
    if (mouseX >= 227.5 && mouseX <= 260 && mouseY >= 110 && mouseY <= 130) {  // Checks '-' button
      usingController = false;
    }
  }
}

void mousePressed() {
  if ((mouseX>530)&&(mouseX<630)&&
    (mouseY>240)&&(mouseY<265)) {
    info = !info;
  }
}

