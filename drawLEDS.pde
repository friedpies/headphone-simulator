public void calculateColors(String mode) {
  switch(mode) {
    case("OFFMODE"):
    for (int i = 0; i < 8; i++) {
      ledColors[i] = color(0);
    }
    break;

    case("ONMODE"):
    //fft.analyze();
    rmsSum += (rms.analyze() - rmsSum) * smoothFactor;
    rmsScaler = int(rmsSum * 500);
    ledBin = rmsScaler / 10;
    
    println(rmsScaler);
    for (int i = 0; i < 8; i++) {
      //sum[i] += (fft.spectrum[i] - sum[i]) * smoothFactor; 
      color from = color(255, 0, 255, 255);
      color to = color(255, 0, 0, 0);
      if (i <= ledBin){
      //ledColors[i] = lerpColor(to, from, sum[i] * 10);
      ledColors[i] = lerpColor(to, from, rmsSum * 4 );
      }
      else {
       ledColors[i] = color(0); 
      }
      
    }
    
    break;
  }
}



public void drawLEDS() {
  int rectSize = 110;
  float rotationSpeed = float(frameCount) / 400;
  stroke(255);
  rectMode(CENTER);
  //for (int i = 0; i < 8; i++) {
  //  fill(ledColors[i]);
  //  rect(100 + (i * 1000 / 7), 150, rectSize, rectSize, 10);
  //}

  for (int i = 0; i < 8; i++) {
    fill(ledColors[i]);
    pushMatrix();
    translate(600, 400, -385);
    rotateY(rotationSpeed);
    rotateX(rotationSpeed);
    rotateZ(rotationSpeed);
    pushMatrix();
    rotateY(float(i)/4.1);
    translate(0, 0, 500);
    rect(0, 0, rectSize, rectSize, 10);
    popMatrix();
    popMatrix();
  }
}