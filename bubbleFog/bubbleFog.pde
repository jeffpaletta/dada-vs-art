// Jeffrey Paletta — 2015
// bubbleFog.pde

import geomerative.*;

RFont myFont;
RGroup myGroup;
RPoint[] myPoints;
String myText = "CHANCE&PLAY";

FontAgent[] myAgents;
int step = 3;
boolean stopAnime = false;

void setup() {
  size(800, 350);
  background(0);
  smooth();

  RG.init(this);
  myFont = new RFont("FreeSans.ttf", 113, CENTER);

  RCommand.setSegmentLength(10);
  RCommand.setSegmentator(RCommand.UNIFORMLENGTH);
  myGroup = myFont.toGroup(myText);
  myPoints = myGroup.getPoints();

  myAgents = new FontAgent[myPoints.length];
  for (int i=0; i<myPoints.length; i++) {
    myAgents[i] = new FontAgent(new PVector(myPoints[i].x, myPoints[i].y));
  }
}


void draw() {
  translate(400, 205);
  background(0);
  fill(255);

  for (int i = 0; i < myPoints.length; i++) {
    myAgents[i].display();
    myAgents[i].motion();
  }
}

void keyPressed() {
  if (key == 'f' || key == 'F') 
    stopAnime = !stopAnime;
  if (stopAnime == true)
    noLoop();
  else loop();

  if (key == '+')
    step++;
  println(step);

  if (key == '-')
    step--;
}  
