int siz = 300;
int step = 50;

void setup(){

  size(800,600,P3D);

  ortho();
}




void draw(){

  background(255);

  translate(width/2,height/2);
  rotateX(radians(35));
  rotateZ(radians(45));
  translate(-width/2,-height/2);

  for(int y = -siz; y<siz;y+=step){
    for(int x = -siz; x<siz;x+=step){
      pushMatrix();

      translate(width/2+x,height/2+y);//,100.0*noise((x+frameCount)/100.0,y/100.0));
      rotateX((frameCount+x)/100.0);
      rotateY((frameCount+y)/200.0);
      rotateZ((frameCount+x+y)/400.0);

      box(step/2);

      popMatrix();
    }
  }
}
