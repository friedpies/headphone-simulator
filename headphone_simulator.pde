import g4p_controls.*;
import processing.sound.*;
import signal.library.*;

SoundFile audioFile;
SignalFilter filter1;
SignalFilter filter2;

float sourceSignal, sourceSignalPrev;
float minCutoff1 = 1.0;
float beta1 = .7;
float filteredSignal1, filteredSignal1Prev; 
float minCutoff2 = 2.6;
float beta2 = 5.7;
float filteredSignal2, filteredSignal2Prev;

Amplitude rms;
AudioDevice device;
color ledColors[] = new color[8]; 
color colorChoice = color(0);


float maxVolumeDetected = 0;
int deviceBands = 128;
int ledBin = 0;
int ledFade = 0;
float rmsSumRaw;
float rmsSumSmoothed;
int rmsScalerRaw;
int rmsScalerSmoothed;

final String ONOFF[] = {"OFF", "ON"};
final String DISPLAYMODE[] = {"MODE1", "MODE2", "MODE3"};
String currentOnOffState = ONOFF[0];
String currentDisplayMode = DISPLAYMODE[2];

public void setup() {
  size(1200, 1000, P3D);
  createGUI();
  customGUI();
  colorMode(HSB, 360, 100, 100);

  device = new AudioDevice(this, 44000, deviceBands);
  calculateColors(currentOnOffState);

  filter1 = new SignalFilter(this);
  filter1.setMinCutoff(minCutoff1);
  filter1.setBeta(beta1);

  filter2 = new SignalFilter(this);
  filter2.setMinCutoff(minCutoff2);
  filter2.setBeta(beta2);
}

public void draw() {
  background(0);
  stroke(50);

  calculateColors(currentOnOffState);
  addFade();

  drawLEDS();

  //rect(width / 2 - 300, height / 2, int(sourceSignal * 500), int(sourceSignal * 500));
  //rect(width / 2, height / 2, int(filteredSignal1 * 500), int(filteredSignal1 * 500));
  //rect(width / 2 + 300, height / 2, int(filteredSignal2 * 500), int(filteredSignal2 * 500));
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