/*
Coded by Kof @ 
Wed Aug 27 05:27:21 CEST 2014
*/

boolean render = true;

void setup(){

  size(1280,720,OPENGL);
  frameRate(30);

}

void init(){

  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();
  super.init();

}

void draw(){
  if(frameCount==1){
    frame.setLocation(0,0);
  }

  background(0);

  float r = height/2;
  translate(width/2,height/2);
  for(float i = 0; i < HALF_PI*10000;i++){
    rotate(frameCount/1000000.0134);
    float a = (cos((i+frameCount)/1000.0 ));
    float b = (sin((i+frameCount)/1000.13 ));
    stroke(255,12);
    line(r*b*0.5,r*a,r*b*a,r*a);
  }

  if(render)
    saveFrame("/home/kof/render/shapeStudy/fr#####.png");

  if(frameCount%12600==0)
    exit();
}
