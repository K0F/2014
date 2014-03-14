void init(){
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();

  super.init();
}

void setup(){
  size(1024,768,OPENGL);
  colorMode(HSB);
}





void draw(){
  
  if(frameCount==1)
  frame.setLocation(0,0);

  background(127*(sin(frameCount/300.0)+1.0));

  noStroke();
  for(int i = 0 ; i < 150;i++){
    pushMatrix();
    translate(width/2+(noise(((frameCount+i*10)-.5)/311.1))*(width/2-150/2),height/2);

    rotate((frameCount+i*10)/100.0);

    fill(i%2==0?255:0,180);

    rectMode(CENTER);

    float r = noise(frameCount/100.0+i/10.0)*height;
    rect(0,0,r,r);
    popMatrix();
  }
}
