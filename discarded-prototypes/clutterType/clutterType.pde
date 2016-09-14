// Jeffrey Paletta — 2015
// clutterType.pde

PFont myFont;
void setup() {
  size(400,400);
  myFont=createFont("Univers",48);
  background(255);
  for(int i=-0;i<400;i=i+20) {
    for(int j=-0;j<400;j=j+20) {
      fill(2,0,0,100);
      textFont(myFont,22);
      text("dada",random(i),random(j));
    }
  }
}

void draw() {
  frameRate(3);
  for(int i=-0;i<400;i=i+20) {
    for(int j=-0;j<400;j=j+20) {
      fill(2,0,0,100);
      textFont(myFont,random(abs(i-330)));
      text("T",i,random(j));
    }
  }
}
