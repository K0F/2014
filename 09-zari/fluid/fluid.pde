

ArrayList painters;
int NUM = 10000;


void setup(){

  size(800,350);


  painters = new ArrayList();

  for(int i = 0 ; i < NUM;i++){
    painters.add(new Painter(random(width),random(height)));
  }
  background(255);

}





void draw(){

  fill(255,15);
  rect(0,0,width,height);

  for(Object o: painters){
    Painter p = (Painter)o;
    p.draw();

  }






}


class Painter{
  PVector pos;
  PVector dir;

  Painter(float _x,float _y){
    pos = new PVector(_x,_y);
    dir = new PVector(noise(_x,0)-0.5,noise(0,_y)-0.5);
  }


  void draw(){
    PVector expos = new PVector(pos.x,pos.y);

    dir = new PVector(noise((pos.x)/100.0,0,frameCount/100.0)-0.5,noise(0,(pos.y)/100.0,frameCount/100.0)-0.5);
    dir.mult(noise(0,0,frameCount/100.0)*10.0);

    Painter ran = (Painter)painters.get((int)random(painters.size()));
    float d = dist(ran.pos.x,ran.pos.y,pos.x,pos.y);
    PVector repulsion = new PVector(pos.x-ran.pos.x,pos.y-ran.pos.y);
    repulsion.normalize();
    repulsion.mult(10.0/(d+1.0));
    
    pos.add(dir);
    pos.add(repulsion);

    border();

    stroke(0,15);
    if(dist(pos.x,pos.y,expos.x,expos.y)<height-2)
    line(pos.x,pos.y,expos.x,expos.y);
  }

  void border(){
    
    if(pos.x>width)pos.x=0;
    if(pos.y>height)pos.y=0;
    if(pos.x<0)pos.x=width;
    if(pos.y<0)pos.y=height;

  }




}
