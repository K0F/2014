PGraphics platno;
ArrayList generators;
ArrayList machines;

float dirsx[] = {-1,0,1,-1,0,1,-1,0,1};
float dirsy[] = {-1,-1,-1,0,0,0,1,1,1};

float SMOOTHING = 3000.0;

float CYCLES = 1.1;
float SPEED = 2.55;
float AL = 19.5;

int NUM_GEN = 20;
int NUM_MACHINES = 100;


void setup(){

  size(800,400);

  clear();
}

void clear(){


  generators = new ArrayList();

  for(int i = 0 ; i < NUM_GEN;i++){
    generators.add(new Generator());
  }

  machines = new ArrayList();

  for(int i = 0 ; i < NUM_MACHINES;i++){
    machines.add(new Machine());
  }

  platno = createGraphics(width,height,JAVA2D);

  platno.loadPixels();

}

void mousePressed(){

clear();
}

void draw(){

  background(255);

  for(Object tmp : machines){
    Machine m = (Machine)tmp;
    m.draw(platno);
  }

  image(platno,0,0);


}


class Machine{
  PVector pos,lpos;
  int current;
  int cycle;
  float speed;
  float smx,smy;
  Machine(){

    speed = random(50,100) * SPEED;

    pos = new PVector(width/2,height/2);
    lpos = new PVector(pos.x,pos.y);
    
    smx = pos.x;
    smy = pos.y;

    cycle = (int)(random(50,100) * CYCLES);
    current = (int)random(generators.size());
  }


  void draw(PGraphics _platno){


    noStroke();
    fill(0);
    rectMode(CENTER);
    rect(pos.x,pos.y,3,3);

    float d = dist(pos.x,pos.y,lpos.x,lpos.y);
    if(d<=100){

      _platno.beginDraw();
      _platno.stroke(0,AL);
      _platno.line(pos.x,pos.y,lpos.x,lpos.y);
      _platno.endDraw();
   _platno.scale(-1,1);
      _platno.translate(-width,0);
      _platno.stroke(0,AL);
      _platno.line(pos.x,pos.y,lpos.x,lpos.y);
      
    }
    move();


  }

  void move(){

    lpos = new PVector(pos.x,pos.y);

    PVector dir = new PVector(0,0);


    Generator curr = (Generator)generators.get(current);
    boolean mat[] = new boolean[curr.matrix.length];
    
    for(int i = 0 ; i < curr.matrix.length;i++)
      mat[i]=curr.matrix[i];

    if(frameCount%cycle==0)
      current++;

    if(current>=generators.size())
      current = 0;


    for(int i = 0 ; i < curr.matrix.length;i++){

      if(mat[i]){
        dir.add(new PVector(dirsx[i],dirsy[i]));
      }
    }

   // println(dir.x+" "+dir.y);
    dir.normalize();
    dir.mult(speed);

    PVector target = new PVector(dir.x,dir.y);
    target.mult(cycle);


    smx += (target.x-smx)/SMOOTHING;
    smy += (target.y-smy)/SMOOTHING;
    
    pos = (new PVector(smx,smy));



    border();

  }

  void border(){


    if(pos.x>width)pos.x=0;
    if(pos.x<0)pos.x=width;
    if(pos.y>height)pos.y=0;
    if(pos.y<0)pos.y=height;
  }



}

class Generator{

  boolean [] matrix;

  Generator(){


    matrix = new boolean[9];

    for(int i = 0 ;i < matrix.length;i++){
      matrix[i] = (random(50)>25)?true:false;
    }
  }

  void draw(){


  }


}


