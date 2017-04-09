public void calculateColors(String mode) {
  switch(currentOnOffState) {
    case("OFF"):
    clearColors();
    break;

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
    }

    break;
  }
}



public void drawLEDS() {
  int rectSize = 110;
  float rotationSpeed = float(frameCount) / 400;
  stroke(100, 0, 100);
  rectMode(CENTER);

  for (int i = 0; i < 8; i++) {
    fill(ledColors[i]);
    pushMatrix();
    translate(600, 400, -385);
    rotateY(-rotationSpeed);
    //rotateX(rotationSpeed);
    rotateZ(-rotationSpeed);
    pushMatrix();
    rotateY(float(i)/4.1);
    translate(0, 0, 500);
    rect(0, 0, rectSize, rectSize, 10);
    popMatrix();
    popMatrix();
  }
}

public void calculateRMS() {
  rmsSumRaw += (rms.analyze() - rmsSumRaw) * .025;
  rmsSumSmoothed += (rms.analyze() - rmsSumRaw) * .025;

  rmsScalerRaw = int(rmsSumRaw * 250);
  rmsScalerSmoothed = int(rmsSumSmoothed * 250);
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
      ledColors[i + 3] = color(rmsScalerRaw * 1.5, 100, (rmsScalerRaw * 3) * float(i + 1)*.5);
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
      ledColors[i] = color(rmsScalerRaw * 1.5, 100, (rmsScalerRaw * 3));
    } else {
      ledColors[i] = color(0);
    }
  }
  if (ledFade != 0) {
    ledColors[ledBin] = color(rmsScalerRaw * 1.5, 100, 100 * (float(ledFade) / 10));
  }
}

public void clearColors() {
  for (int i = 0; i < 8; i++) {
    ledColors[i] = color(0);
  }
}