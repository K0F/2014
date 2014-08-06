
void setup(){
  size(320,320);

}


void draw(){

  background(getColorFromInt(frameCount));

}


color getColorFromInt(int i) {
  int B_MASK = 255;
  int G_MASK = 255<<8;
  int R_MASK = 255<<16;

  int r = i & R_MASK;
  int g = i & G_MASK;
  int b = i & B_MASK;

  return (color(r,g,b));
}

