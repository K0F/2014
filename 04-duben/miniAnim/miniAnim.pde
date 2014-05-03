
Ball ball;


void setup(){

  size(320,320,P3D);
  ortho();

  ball = new Ball();

}

void draw(){
  background(0);


  ball.draw();


}



class Ball{
  PGraphics map;
  PVector pos, acc, vel, lpos;
  float rot;
  int w,h;
  int SPHERE_SIZE = 14;
  int SPHERE_DETAIL = 6;
  float d = 0;
  Ball(){

    w = h = 32;

    pos = new PVector(width/2,height/2);
    lpos = new PVector(width/2,height/2);
    acc = new PVector(0,0);
    rot = 0;
    vel = new PVector(0.1,0);

    redraw();


  }

  void redraw(){
    lpos = new PVector(pos.x,pos.y,pos.z);
    pos.x += (mouseX-pos.x)/10.0;
    pos.y += (mouseY-pos.y)/10.0;
    rot = atan2(lpos.y-pos.y,lpos.x-pos.x)+HALF_PI;
    d += dist(lpos.x,lpos.y,pos.x,pos.y);

    map = createGraphics(w,h,P3D);
    map.beginDraw();
    map.noSmooth();
    map.strokeWeight(1);
    map.background(0);
    map.ortho();
    map.sphereDetail(SPHERE_DETAIL);
    map.translate(w/2,h/2,0);
    map.noFill();
    map.stroke(255,75);
    map.rotate(d/(SPHERE_SIZE+0.0),cos(rot),sin(rot),-1);
    map.sphere(SPHERE_SIZE);
    map.endDraw();


  }

  void draw(){
    redraw();
    image(map,pos.x-w/2,pos.y-h/2);
  }


}
