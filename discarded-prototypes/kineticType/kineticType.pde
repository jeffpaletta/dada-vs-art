// Jeffrey Paletta
// kineticType.pde

import geomerative.*;

float xoff = 0.0;
float yoff = 0.0;

float xInc= 0.01; 
float yInc = 0.015; 

boolean stopAnime = false; 

//———————————————————————————————————————————————————————
RFont maFonte;
String monTexte = "Dada";
String monTexte2 = "Play";

//———————————————————————————————————————————————————————
void setup() { 
  size(900, 500);
  smooth();
  background(0);
  strokeWeight(0.5);
  rectMode(CENTER);
}

//—————————————————— MERGE —————————————————————————————————————
void draw() {
  background(0);
  float deplacementX = noise(xoff)*width;
  float deplacementY = noise(yoff)*height;

  xoff += xInc;
  yoff += yInc;

  RG.init(this);
  maFonte = new RFont("FreeSans.ttf", 230, CENTER);
  translate (width/2, height/1.7);

  float frequence = map(deplacementX, 300, 500, 03, 200);

  RCommand.setSegmentLength(frequence);
  RGroup maGroupe = maFonte.toGroup(monTexte);
  RPoint[] mesPoints = maGroupe.getPoints();

  beginShape();
  for (int i=0; i<mesPoints.length;i++) {
    point(mesPoints[i].x, mesPoints[i].y);
    noFill();
    stroke(255, 150);

    vertex(mesPoints[i].x, mesPoints[i].y);

    float rotation = map(deplacementY, 0, height, 0, radians(360)); 
    pushMatrix();
    translate(mesPoints[i].x, mesPoints[i].y);
    rotate(rotation);    
    rect(0, 0, frequence/7, frequence/7);
    popMatrix();
  }
  endShape();


  //2———————————————— DESIGN ———————————————————————————————————————

  float frequence2 = map(deplacementX, 300, 500, 200, 3);
  RCommand.setSegmentLength(frequence2);
  RGroup maGroupe2 = maFonte.toGroup(monTexte2);
  RPoint[] mesPoints2 = maGroupe2.getPoints();

  beginShape();
  for (int i=0; i<mesPoints2.length;i++) {
    noFill();
    stroke(255, 150);
    vertex(mesPoints2[i].x, mesPoints2[i].y);
    ellipse(mesPoints2[i].x, mesPoints2[i].y, frequence2/6, frequence2/6);
  }
  endShape();
}
void keyReleased() {
  if (key == 's' || key =='S')
    saveFrame("000_###.jpg");

  if (key == 'f' || key =='F')
    stopAnime = !stopAnime;
  if (stopAnime == true)
    noLoop();
  else 
    loop();
}
