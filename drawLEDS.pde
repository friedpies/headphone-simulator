public void calculateColors(String mode) {
  switch(currentOnOffState) {
    case("OFF"):
    clearColors();
    break;

    case("ON"):
    calculateRMS();

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

  sourceSignalPrev = sourceSignal;
  filteredSignal1Prev = filteredSignal1;
  filteredSignal1 = filter1.filterUnitFloat(sourceSignal);
  filteredSignal2Prev = filteredSignal2;
  filteredSignal2 = filter2.filterUnitFloat(sourceSignal);
  sourceSignal = rms.analyze();
  colorChoice = color(map(filteredSignal1, 0, 0.4, 0, 200), 100 - map(filteredSignal1, 0, 0.4, 1, 60), 100);


  ledBin = int(filteredSignal1 * 30); //calculate bargraph ints
  //println(ledBin);
  ledFade = int(filteredSignal2 * 30) % 10; //calculate bargraph remainder


  rmsSumRaw += (rms.analyze() - rmsSumRaw) * .1;
  rmsSumSmoothed += (rms.analyze() - rmsSumRaw) * .025;

  rmsScalerRaw = int(rmsSumRaw * 250);
  rmsScalerSmoothed = int(rmsSumSmoothed * 250);
}

public void calculateMode1() {

  ledBin = int(filteredSignal1 * 15); //calculate bargraph ints
  //println(ledBin);
  ledFade = int(filteredSignal2 * 150) % 10; //calculate bargraph remainder

  if (ledBin > 4) { 
    ledBin = 4;
  }

  for (int i = 0; i < 4; i++) {
    if (i < ledBin) {
      ledColors[i] = colorChoice;
      ledColors[7-i] =  colorChoice;
    }
  }
}

public void calculateMode2() {
  ledBin = int(filteredSignal1 * 15); //calculate bargraph ints
  //println(ledBin);
  ledFade = int(filteredSignal2 * 150) % 10; //calculate bargraph remainder

  if (ledBin > 4) { 
    ledBin = 4;
  }

  for (int i = 0; i < 4; i++) {
    if (i < ledBin) {
      ledColors[i + 4] = colorChoice;
      ledColors[3-i] =  colorChoice;
    }
  }
}

public void calculateMode3() {
  ledBin = int(filteredSignal1 * 30); //calculate bargraph ints
  ledFade = int(filteredSignal2 * 300) % 10; //calculate bargraph remainder
  if (ledBin > 7) {
    ledBin = 7;
  }
  for (int i = 0; i < 8; i++) {
    if (i < ledBin) {
      ledColors[i] = colorChoice;
    }
  }
}

public void clearColors() {
  for (int i = 0; i < 8; i++) {
    ledColors[i] = color(0);
  }
}

public void addFade() {
  for (int i = 0; i < 8; i++) {
    
    if (int(byte(ledColors[i] >> 24)) >= 10 ) {
      ledColors[i] -= color(0, 10);
    }
  }
  println(int(byte(ledColors[0] >> 24)));
}