public void calculateColors(String mode) {
  switch(currentOnOffState) {
    case("OFF"):
    clearColors();
    break;

    case("ON"):
    calculateFFT();
    calculateMode3();
    break;
  }
}

public void calculateFFT() {

  //sourceSignalPrev = sourceSignal;
  //filteredSignal1Prev = filteredSignal1;
  //filteredSignal1 = filter1.filterUnitFloat(sourceSignal);
  //filteredSignal2Prev = filteredSignal2;
  //filteredSignal2 = filter2.filterUnitFloat(sourceSignal);
  fft.analyze(spectrum);
  filteredSignals = filters.filterUnitArray(spectrum);
}

public void calculateMode1() {
  for (int i = 0; i < 8; i++) {
    normalizedFilteredSignals[i] = map(log(filteredSignals[i]), -10, mapMaxValue, 0, 100);
    hue[i] = int(map(log(filteredSignals[i]), -3, mapMaxValue, 337, 285));
    saturation[i] = 100;
    brightness[i] = int(map(log(filteredSignals[i]), -5, mapMaxValue, 37, 97));
    ;
    opacity[i] = int(map(log(filteredSignals[i]), -9, mapMaxValue, 55, 100));
    size[i] = int(map(log(filteredSignals[i]), -6, mapMaxValue, 51, 100));
    //print(hue); print("  "); println(saturation);
  }
}

public void calculateMode2() {
  for (int i = 0; i < 4; i++) {
    normalizedFilteredSignals[i] = map(log(filteredSignals[i]), -10, mapMaxValue, 0, 100);
    normalizedFilteredSignals[7 - i] = map(log(filteredSignals[i]), -10, mapMaxValue, 0, 100);

    hue[i] = int(map(log(filteredSignals[i]), -3, mapMaxValue, 337, 285));
    hue[7 - i] = int(map(log(filteredSignals[i]), -3, mapMaxValue, 337, 285));

    saturation[i] = 100;
    saturation[7 - i] = 100;

    brightness[i] = int(map(log(filteredSignals[i]), -5, mapMaxValue, 37, 97));
    brightness[7 - i] = int(map(log(filteredSignals[i]), -5, mapMaxValue, 37, 97));
    ;

    opacity[i] = int(map(log(filteredSignals[i]), -9, mapMaxValue, 55, 100));
    opacity[7 - i] = int(map(log(filteredSignals[i]), -9, mapMaxValue, 55, 100));

    size[i] = int(map(log(filteredSignals[i]), -6, mapMaxValue, 51, 100));
    size[7 - i] = int(map(log(filteredSignals[i]), -6, mapMaxValue, 51, 100));
    //print(hue); print("  "); println(saturation);
  }
}

  public void calculateMode3() {
    for (int i = 0; i < 4; i++) {
      normalizedFilteredSignals[i + 4] = map(log(filteredSignals[i]), -10, mapMaxValue, 0, 100);
      normalizedFilteredSignals[3 - i] = map(log(filteredSignals[i]), -10, mapMaxValue, 0, 100);

      hue[i + 4] = int(map(log(filteredSignals[i]), -3, mapMaxValue, 337, 285));
      hue[3 - i] = int(map(log(filteredSignals[i]), -3, mapMaxValue, 337, 285));

      saturation[i + 4] = 100;
      saturation[3 - i] = 100;

      brightness[i + 4] = int(map(log(filteredSignals[i]), -5, mapMaxValue, 37, 97));
      brightness[3 - i] = int(map(log(filteredSignals[i]), -5, mapMaxValue, 37, 97));


      opacity[i + 4] = int(map(log(filteredSignals[i]), -9, mapMaxValue, 55, 100));
      opacity[3 - i] = int(map(log(filteredSignals[i]), -9, mapMaxValue, 55, 100));

      size[i + 4] = int(map(log(filteredSignals[i]), -6, mapMaxValue, 51, 100));
      size[3 - i] = int(map(log(filteredSignals[i]), -6, mapMaxValue, 51, 100));
      //print(hue); print("  "); println(saturation);
    }
  }

  public void drawLEDS() {
    int rectSize = 110;
    float rotationSpeed = float(frameCount) / 400;
    //stroke(100, 0, 100);

    for (int i = 0; i < 8; i++) {
      fill(color(hue[i], saturation[i], brightness[i], opacity[i]));
      pushMatrix();
      translate(600, 400, -385);
      rotateY(-rotationSpeed);
      //rotateX(rotationSpeed);
      rotateZ(-rotationSpeed);
      pushMatrix();
      rotateY(float(i)/4.1);
      translate(0, 0, 500);
      ellipse(0, 0, size[i], size[i]);
      //drawDiffusedLED(0, 0, 100, ledColors[i]);
      popMatrix();
      popMatrix();
    }
  }

  void drawFFT() {

    for (int currentChannel = 0; currentChannel < fftBands; currentChannel++) {
      float w = 20;
      float x = 20 * (float)currentChannel;
      float yNoisy    = height - ( log(spectrum[currentChannel]) * height );
      float yFiltered = height - ( normalizedFilteredSignals[currentChannel] * height );

      noStroke();

      // Noisy signal
      //fill(130);
      //ellipse(200+ x + w/2, yNoisy - 200, w, w);



      // Filtered signal
      fill(200);
      ellipse(200 + x + w/2, yFiltered - 200, w * 0.6, w * 0.6);
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
    //println(int(byte(ledColors[0] >> 24)));
  }

  void drawDiffusedLED(float xcoord, float ycoord, float diameter, color ledColor) {
    color white = color(0, 0, 80);
    color gradientColor = color(0);

    strokeWeight(2);
    if (int(byte(ledColor >> 24)) >= 10 ) {

      for (int i = 0; i < diameter; i++) {
        float n = map(i, 0, diameter, 0, 1);
        gradientColor = lerpColor(white, ledColor, n);
        stroke(gradientColor);
        ellipse(xcoord, ycoord, i, i);
      }
    }
  }