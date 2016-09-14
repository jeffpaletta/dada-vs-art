
// Jeffrey Paletta — 2015
// dadaPlay.pde — v1.0


/*
 * drag                : draws with text
 * del, backspace      : clear screen
 * arrow up            : angle distortion +
 * arrow down          : angle distortion -
 * s                   : save png
 * r                   : start pdf recording
 * e                   : stop pdf recording
 */

import processing.pdf.*;
import java.util.Calendar;

boolean recordPDF = false;

float x = 0, y = 0;
float stepSize = 5.0;

PFont font;
String letters = "Text to draw goes here";

//define the minimun point size
int fontSizeMin = 10;
float angleDistortion = 0.0;

int counter = 0;

void setup() {
  // use full screen size 
  //size(displayWidth, displayHeight);
  //book size
  size(2160,1440);
  background(255);
  smooth();
  cursor(CROSS);

  x = mouseX;
  y = mouseY;

  font = createFont("American Typewriter",36);
  //font = createFont("GEOGROTESQUECOMP-DEMIBOLD.OTF",48);
  textFont(font,fontSizeMin);
  textAlign(LEFT);
  fill(0);

  /*
  // load image
   PImage img = loadImage(selectInput("dada_##"));
   image(img, 0, 0, width, height);
   */
}

void draw() {
  //guide
  line(1080,0,1080,1440);
  if (mousePressed) {
    float d = dist(x,y, mouseX,mouseY);
    textFont(font,fontSizeMin+d/2);
    char newLetter = letters.charAt(counter);
    stepSize = textWidth(newLetter);

    if (d > stepSize) {
      float angle = atan2(mouseY-y, mouseX-x); 

      pushMatrix();
      translate(x, y);
      rotate(angle + random(angleDistortion));
      text(newLetter, 0, 0);
      popMatrix();

      counter++;
      if (counter > letters.length()-1) counter = 0;

      x = x + cos(angle) * stepSize;
      y = y + sin(angle) * stepSize; 
    }
  }
}


void mousePressed() {
  x = mouseX;
  y = mouseY;
}

void keyReleased() {
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
  if (key == DELETE || key == BACKSPACE) background(255);

  // pdf export     
  if (key =='r' || key =='R') {
    if (recordPDF == false) {
      beginRecord(PDF, timestamp()+".pdf");
      println("recording started");
      recordPDF = true;
      textAlign(LEFT);
      fill(0);
    }
  } 
  else if (key == 'e' || key =='E') {
    if (recordPDF) {  
      println("recording stopped");
      endRecord();
      recordPDF = false;
      background(255); 
    }
  } 
}

void keyPressed() {
  // angleDistortion ctrls arrowkeys up/down 
  if (keyCode == UP) angleDistortion += 0.1;
  if (keyCode == DOWN) angleDistortion -= 0.1; 
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
