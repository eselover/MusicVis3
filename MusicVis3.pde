import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

int R = 0;
int G = 0;

AudioPlayer song;
BeatDetect beat;
Minim minim;

void setup()
{
  size(1000, 1000, P3D);
  background(0);

  minim = new Minim(this);
  song = minim.loadFile("Breathing.mp3", 1024);
  song.loop();
  beat = new BeatDetect();
}

void draw()
{
  noStroke();
  fill(0, 0, 50);
  rect(0, 0, width, height);
  
  // Gets seconds that the application has been running
  float time = millis()/1000.0;

  beat.detectMode(BeatDetect.FREQ_ENERGY);
  beat.detect(song.mix);
  
  // Moves and Rotates the Spheres
  translate(500, 500, 0);
  rotateX(cos(time / 2));
  rotateY(sin(time / 2));
  rotateZ(cos(time / 2) + sin(time / 2));

  // When beat detects a bass drum frequency makes another sphere inside the other with a different rotation
  if (beat.isKick())
  {
    stroke(150, 150, 200);
    noFill();
    pushMatrix();
    rotateX(sin(time) + cos(time));
    rotateY(cos(time));
    rotateZ(atan(time));
    sphere(300);
    popMatrix();
  }

  // When beat detects a snare drum frequency makes another sphere inside the other with the same angle of rotation
  if (beat.isSnare())
  {
    stroke(0, 255, 0);
    noFill();
    sphere(100);
  }
  // makes the biggest sphere
  stroke(R, G, 255);
  noFill();
  sphere(400);
}

