PImage [] layers;


void setup(){

  size(1280*3,720,OPENGL);

  colorMode(HSB);

  layers = new PImage[1];

  layers[0] = loadImage("one.png");


}

void draw(){

  background(0);

  tint(frameCount%255,127,127,(sin(millis()/100.0)+1.0)*128.0);
  image(layers[0],0,0);
  tint(255,(sin(millis()/102.0+100.0)+1.0)*128.0);
  image(layers[0],width/3,0);
  tint(255,(sin(millis()/103.0+1000.0)+1.0)*128.0);
  image(layers[0],width/3*2,0);

  println(frameRate);

}


