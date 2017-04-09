// Need G4P library


import g4p_controls.*;
import processing.sound.*;

SoundFile audioFile;
//FFT fft;
Amplitude rms;
AudioDevice device;
color ledColors[] = new color[8]; 

float lightScaler = 80;
float scale = 5;
int deviceBands = 128;
int ledBin = 0;
int ledFade = 0;
float rmsSumRaw;
float rmsSumSmoothed;
int rmsScalerRaw;
int rmsScalerSmoothed;
//float[] sum = new float[fftBands];
final String ONOFF[] = {"OFF", "ON"};
final String DISPLAYMODE[] = {"MODE1", "MODE2", "MODE3"};
String currentOnOffState = ONOFF[0];
String currentDisplayMode = DISPLAYMODE[2];

public void setup() {
  size(1200, 1000, P3D);
  createGUI();
  customGUI();
  colorMode(HSB, 360, 100, 100);
  lights();
  device = new AudioDevice(this, 44000, deviceBands);
  calculateColors(currentOnOffState);
}

public void draw() {
  background(0);
  stroke(50);
  calculateColors(currentOnOffState);
  drawLEDS();
}


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