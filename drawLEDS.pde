public void calculateColors() {
  color from = color(255, 0, 0);
  color to = color(0, 0, 255);

  for (int i = 0; i < 8; i++) {
    ledColors[i] = lerpColor(from, to, float(i) / 8);
  }
}

public void drawLEDS() {
  int rectSize = 110;
  noStroke();
  rectMode(CENTER);
  for (int i = 0; i < 8; i++) {
    fill(ledColors[i]);
    rect(100 + (i * 1000 / 7), 150, rectSize, rectSize, 10);
  }
}