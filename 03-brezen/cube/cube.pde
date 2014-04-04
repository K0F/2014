
float alpha = 35;

float speed = 1000.0;
float spread = 5.0;
int num = 80;

float boundary = 0.5;

ArrayList point_cloud;


PGraphics frame;

void setup(){

  size(512,512,P3D);
  noSmooth();

  frame = createGraphics(width,height,P2D);

  frame.beginDraw();
  frame.strokeWeight(20);
  frame.stroke(0);
  frame.fill(200);
  frame.rect(0,0,width,height);
  frame.filter(BLUR,20);
  frame.endDraw();


  ortho();
  generate();
}

void mousePressed(){
  generate();
}

void generate(){
  point_cloud = new ArrayList();

  for(int i = 0 ; i < num; i++){
    point_cloud.add(
        new PVector(
          random(-boundary,boundary),
          random(-boundary,boundary),
          random(-boundary,boundary)
          )
        );
  }
}

void object(){
  beginShape();
  for(Object tmp : point_cloud){
    PVector a = (PVector)tmp;
    vertex(a.x,a.y,a.z);
  }
  endShape();
}

void draw(){

  background(frame);

  noFill();
  stroke(0,alpha);

  pushMatrix();


  translate(width/2,height/2);
  rotateX(noise(frameCount/400.0,0,0)*TWO_PI);
  rotateY(noise(0,frameCount/400.0,0)*TWO_PI);
  rotateZ(noise(0,0,frameCount/400.0)*TWO_PI);
  translate(-width/2,-height/2);





  translate(width/2,height/2);

  for(int i = 1 ; i < num ; i++){
  

    PVector mod = new PVector(
        noise((frameCount-i*spread)/speed,0,0),
        noise(0,(frameCount-i*spread)/speed,0),
        noise(0,0,(frameCount-i*spread)/speed)
        );

    pushMatrix();

    rotateX(mod.x*TWO_PI);
    rotateY(mod.y*TWO_PI);
    rotateZ(mod.z*TWO_PI);
    translate((mod.x-0.5)*420.0,(mod.y-0.5)*420.0,(mod.z-0.5)*420.0);
    scale(pow(i*mod.mag()*3.0,1.2));

    object();
    popMatrix();

  }
  popMatrix();
}
