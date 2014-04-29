


void setup(){

  size(1280,720,P2D);
  frameRate(60);
}


void draw(){


  background(0);


  int cntr = 0;

  float s = 20.0+10.0*(sin(frameCount/40.0)+random(-0.1,0.1));

  noStroke();
if(frameCount%5==0)
  for(float i = 0 ; i < width;i+=s){

  if(i==0)
  println(s);

  s = constrain(s,1,width);
  fill(cntr%2==0?color(255,0,0):color(0,255,0));
  
  rect(i,0,s+1,height);
  cntr++;
  }



}
