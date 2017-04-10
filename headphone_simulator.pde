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
color colorChoice =   color(0);
int hue = 0;
int saturation = 0;
int brightness = 0;
int opacity = 100;


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
String currentDisplayMode = DISPLAYMODE[0];


public void setup() {
  size(1200, 1000, P3D);
  createGUI();
  customGUI();
  //noFill();
  colorMode(HSB, 360, 100, 100, 100);  
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


  //rect(width / 2 - 200, 800, int(sourceSignal * 300), int(sourceSignal * 300));
  //rect(width / 2, 800, int(filteredSignal1 * 300), int(filteredSignal1 * 300));
  //rect(width / 2 + 200, 800, int(filteredSignal2 * 300), int(filteredSignal2 * 300));
  //println(int(byte(color(0, 255) >> 24)));
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