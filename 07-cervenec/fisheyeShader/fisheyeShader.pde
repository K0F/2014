
PShader fisheye;
PImage txt;

void setup(){

  size(512,512,P2D);

  fisheye = loadShader("frag.glsl");

  txt = loadImage("grid.jpg");

}


void draw(){

  shader(fisheye);

  image(txt,0,0,width,height);

/*
  beginShape();
  texture(txt);
  vertex(0,0,0,0,0);
  vertex(0,height,0,0,1);
  vertex(width,height,0,1,1);
  vertex(width,0,0,1,0);

  endShape();
*/

}
