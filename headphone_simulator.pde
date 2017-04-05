// Need G4P library


import g4p_controls.*;
import processing.sound.*;

SoundFile audioFile;
Amplitude amp;
AudioIn in;
color[] ledColors = new color[8]; 

public void setup() {
  size(1200, 500, JAVA2D);
  createGUI();
  customGUI();
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start();
  amp.input(in);
  // Place your setup code here
}

public void draw() {
  background(0);
  stroke(50);
  calculateColors();
  drawLEDS();
  println(amp.analyze());
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI() {
}

public void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    audioFile = new SoundFile(this, selection.getAbsolutePath());
  }
}