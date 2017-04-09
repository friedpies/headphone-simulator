// Need G4P library


import g4p_controls.*;
import processing.sound.*;

SoundFile audioFile;
//FFT fft;
Amplitude rms;
AudioDevice device;
color[] ledColors = new color[8]; 

float lightScaler = 80;
float scale = 5;
int deviceBands = 128;
int ledBin = 0;
<<<<<<< HEAD
int ledFade = 0;
float color1Hue = 0;
float color2Hue = 180;
float rmsSumRaw;
float rmsSumSmoothed;
int rmsScalerRaw;
int rmsScalerSmoothed;
int colorCalc;
=======
//int fftBands = 16;
float smoothFactor = 0.05;
float rmsSum;
int rmsScaler;
>>>>>>> parent of 5fd4302... Added mode switching
//float[] sum = new float[fftBands];
String mode = "OFFMODE";

public void setup() {
  size(1200, 1000, P3D);
  createGUI();
  customGUI();
  lights();
  device = new AudioDevice(this, 44000, deviceBands);

  calculateColors(mode);
  // Place your setup code here
}

public void draw() {
  background(0);
  stroke(50);
  calculateColors(mode);
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