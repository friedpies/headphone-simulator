import g4p_controls.*;
import processing.sound.*;
import signal.library.*;

SoundFile audioFile;
AudioDevice device;
FFT fft;
SignalFilter filters;



int deviceBands = 16;
int fftBands = 16;
float[] spectrum = new float[fftBands];



float[] sourceSignals;
float[] filteredSignals;
float[] normalizedFilteredSignals = new float[16];
float minCutoff = 1.0;
float beta = 0.7;


int ledBin = 0;
int ledFade = 0;
float mapMaxValue = -2;


color ledColors[] = new color[8]; 
color colorChoice =   color(0);
int[] hue = new int[8];
int[] saturation = new int[8];
int[] brightness = new int[8];
int[] opacity = new int[8];
int[] size = new int[8];


final String ONOFF[] = {"OFF", "ON"};
final String DISPLAYMODE[] = {"MODE1", "MODE2", "MODE3"};
String currentOnOffState = ONOFF[0];
String currentDisplayMode = DISPLAYMODE[0];


public void setup() {
  size(1200, 1000, P3D);
  createGUI();
  customGUI();

  ellipseMode(CENTER);
  colorMode(HSB, 360, 100, 100, 100);  
  device = new AudioDevice(this, 44000, deviceBands);
  calculateColors(currentOnOffState);

  filters = new SignalFilter(this, fftBands);
  filters.setMinCutoff(minCutoff);
  filters.setBeta(beta);
}

public void draw() {
  minCutoff = 1.0;
  beta = 0.7;
  filters.setMinCutoff(minCutoff);
  filters.setBeta(beta);
  background(0);
  stroke(50);

  calculateColors(currentOnOffState);
  addFade();
  drawLEDS();
  drawFFT();
  println(normalizedFilteredSignals);

  //rect(width / 2 - 200, 800, int(sourceSignal * 300), int(sourceSignal * 300));
  //rect(width / 2, 800, int(filteredSignal1 * 300), int(filteredSignal1 * 300));
  //rect(width / 2 + 200, 800, int(filteredSignaml2 * 300), int(filteredSignal2 * 300));
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