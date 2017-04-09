public void calculateColors(String mode) {
  switch(mode) {
    case("OFFMODE"):
    for (int i = 0; i < 8; i++) {
      ledColors[i] = color(0);
    }
    break;

<<<<<<< HEAD
    case("ON"):
    calculateRMS();
    ledBin = rmsScalerSmoothed / 10; //calculate bargraph ints
    ledFade = rmsScalerSmoothed % 10; //calculate bargraph remainder


    switch(currentDisplayMode) {
      case("MODE1"): //outside -> inside
      calculateMode1();
      break;

      case("MODE2"):
      calculateMode2();
      break;

      case("MODE3"):
      calculateMode3();
      break;
=======
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
      
>>>>>>> parent of 5fd4302... Added mode switching
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
<<<<<<< HEAD
}

public void calculateRMS() {
  rmsSumRaw += (rms.analyze() - rmsSumRaw) * .035;
  rmsSumSmoothed += (rms.analyze() - rmsSumRaw) * .035;

  rmsScalerRaw = int(rmsSumRaw * 250);
  rmsScalerSmoothed = int(rmsSumSmoothed * 250);
  println(rmsScalerRaw);
}

public void calculateMode1() {

  if (ledBin > 4) { 
    ledBin = 4;
  }

  for (int i = 0; i < 4; i++) {
    if (i < ledBin) {
      ledColors[i] = color(rmsScalerRaw * 1.5, 100, (rmsScalerRaw * 3));
      ledColors[7-i] =  color(rmsScalerRaw * 1.5, 100, (rmsScalerRaw * 3));
    } else {
      ledColors[i] = color(0);
      ledColors[7 - i] = color(0);
    }
  }
  if (ledFade != 0) {
    ledColors[ledBin] = color(rmsScalerRaw * 1.5, 100, 100 * (float(ledFade) / 10));
    ledColors[7 - ledBin] = color(rmsScalerRaw * 1.5, 100, 100 * (float(ledFade) / 10));
  }
}

public void calculateMode2() {
  if (ledBin > 4) { 
    ledBin = 4;
  }

  for (int i = 0; i < 4; i++) {
    if (i < ledBin) {
      ledColors[i + 3] = color(rmsScalerRaw * 1.5, 100, (rmsScalerRaw * 3));
      ledColors[4-i] =  color(rmsScalerRaw * 1.5, 100, (rmsScalerRaw * 3));
    } else {
      ledColors[i + 3] = color(0);
      ledColors[4 - i] = color(0);
    }
  }
  if (ledFade != 0) {
    ledColors[ledBin + 3] = color(rmsScalerRaw * 1.5, 100, 100 * (float(ledFade) / 10));
    ledColors[4 - ledBin] = color(rmsScalerRaw * 1.5, 100, 100 * (float(ledFade) / 10));
  }
}

public void calculateMode3() {
  if (ledBin > 7) {
    ledBin = 7;
  }
  for (int i = 0; i < 8; i++) {
    if (i < ledBin) {
      ledColors[i] = color(rmsScalerRaw * 1.5, 100, 100 * pow(rmsScalerRaw / 40), exp(1)));
    } else {
      ledColors[i] = color(0);
    }
  }
  //if (ledFade != 0) {
  //  ledColors[ledBin] = color(rmsScalerRaw * 1.5, 100, 100 *  pow((float(ledFade) / 10), exp(1)));
  //}
}

public void clearColors() {
  for (int i = 0; i < 8; i++) {
    ledColors[i] = color(0);
  }
=======
>>>>>>> parent of 5fd4302... Added mode switching
}