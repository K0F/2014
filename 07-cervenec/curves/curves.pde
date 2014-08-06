
Entity e;

void setup(){
  size(800,600);
  e = new Entity();
}


void draw(){
  background(0);


  e.plot();
}


class Entity{

  PVector pos,vel,target;
  ArrayList trace;
  float speed = 5.0;

  Entity(){

    trace = new ArrayList();
    pos=  new PVector(random(width),random(height));
    target=  new PVector(random(width),random(height));
    vel = new PVector(0,0);

  }

  void move(){

    pos.add(vel);
    vel = new PVector(1/sin((target.x-pos.x)/(width/2.0)),1/sin((target.y-pos.y)/(height/2.0)));
    vel.normalize();
    vel.mult(speed);

    if(dist(pos.x,pos.y,target.x,target.y) < 10){
      target=  new PVector(random(width),random(height));
    }

    trace.add(new PVector(pos.x,pos.y));

    if(trace.size()>1000){
      trace.remove(0);
      trace.remove(0);

      }
  }

  void plot(){

    move();

    stroke(255,55);

    for(int i = 1 ; i< trace.size();i+=2){
      PVector a= (PVector)trace.get(i-1);
      PVector b= (PVector)trace.get(i);
      line(a.x,a.y,b.x,b.y);
    }

  }


}
