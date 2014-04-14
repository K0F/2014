
int num = 300;

PVector [] pnts;
float speed = 1000.0;
float spread = 30.0;

void setup(){

  size(400,400,P3D);

  pnts = new PVector[num];

  ortho();
}


void draw(){

  background(0);

  pushMatrix();
  translate(width/2,height/2,0);
  rotateX(frameCount/100.0);
  rotateY(frameCount/100.0);
  translate(-width/2,-height/2);

  pushMatrix();
  translate(width/2,height/2,0);


  for(int i = 0 ; i < pnts.length;i++){

    PVector origin = new PVector(
        (noise((frameCount+i*spread)/speed,0,0)-0.5)*width,
        (noise(0,(frameCount+i*spread)/speed,0)-0.5)*width,
        (noise(0,0,(frameCount+i*spread)/speed)-0.5)*width
        );    

    pnts[i] = new PVector(
        screenX(origin.x,origin.y,origin.z),
        screenY(origin.x,origin.y,origin.z),
        screenZ(origin.x,origin.y,origin.z)
        );

  }

  popMatrix();
  popMatrix();


  noFill();
  stroke(255,55);

  fill(255,55);
  for(int i = 1 ; i < pnts.length-1;i++){

    float d = dist(pnts[i+1].x,pnts[i+1].y,pnts[i-1].x,pnts[i-1].y);
    /*
       line(pnts[i].x-pnts[i].z*10.0,pnts[i].y,pnts[i].x+pnts[i].z*10.0,pnts[i].y);
       line(pnts[i].x,pnts[i].y-pnts[i].z,pnts[i].x,pnts[i].y+pnts[i].z);
       line(pnts[i].x,pnts[i].y,pnts[i].x,0);
     */
    ellipse(pnts[i].x,pnts[i].y,d/2,d/2);

  }

}
