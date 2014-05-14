/*
Coded by Kof @ 
Mon May 12 12:14:55 CEST 2014



   ,dPYb,                  ,dPYb,
   IP'`Yb                  IP'`Yb
   I8  8I                  I8  8I
   I8  8bgg,               I8  8'
   I8 dP" "8    ,ggggg,    I8 dP
   I8d8bggP"   dP"  "Y8ggg I8dP
   I8P' "Yb,  i8'    ,8I   I8P
  ,d8    `Yb,,d8,   ,d8'  ,d8b,_
  88P      Y8P"Y8888P"    PI8"8888
                           I8 `8,
                           I8  `8,
                           I8   8I
                           I8   8I
                           I8, ,8'
                            "Y8P'
*/

int num = 50;

float rots[];
float speeds[];
float L[];

int MEM_SIZE = 1000;

ArrayList mem;
ArrayList graph1, graph2;

void setup(){

  size(1000,512,P2D);

smooth();

  rots = new float[num];
  L = new float[num];
  speeds = new float[num];

  mem = new ArrayList();
  graph1 = new ArrayList();
  graph2 = new ArrayList();

  for(int i = 0 ; i < num;i++){
    speeds[i] = (random(-PI,PI))/60.0;
    L[i] = random(5,20);
    rots[i] = 0;
  }
}


void draw(){

  background(0);


  stroke(255);

  for(int i = 0 ; i < num;i++){
    rots[i] += speeds[i];
  }

  pushMatrix();

  translate(width/2,height/2);

  for(int i = 0 ; i < num;i++){

    rotate(rots[i]);
    line(L[i],0,0,0);
    translate(L[i],0);

    if(i==num-1){
      mem.add(new PVector(screenX(0,0),screenY(0,0)));
      graph1.add(new PVector(frameCount%width,screenY(0,0)));
      graph2.add(new PVector(frameCount%width,screenX(0,0)/(width/(height+0.0))));
    }
  }

  if(mem.size()>MEM_SIZE){
    mem.remove(0);
    graph1.remove(0);
    graph2.remove(0);
  }

  noFill();

  popMatrix();

  for(int i = 1 ; i < mem.size();i++){
    stroke(#ffffff,map(i,0,mem.size(),0,255));
    PVector tmp = (PVector)mem.get(i);
    PVector tmpp = (PVector)mem.get(i-1);

    line(tmp.x,tmp.y,tmpp.x,tmpp.y);
  }

  for(int i = 1 ; i < mem.size();i++){
    stroke(#ffcc00,map(i,0,mem.size(),0,255));
    PVector tmp = (PVector)graph1.get(i);
    PVector tmpp = (PVector)graph1.get(i-1);

    float d = dist(tmp.x,tmp.y,tmpp.x,tmpp.y);

    if(d<50) 
      line(tmp.x,tmp.y,tmpp.x,tmpp.y);
  }

  for(int i = 1 ; i < mem.size();i++){
    stroke(#ff0000,map(i,0,mem.size(),0,255));
    PVector tmp = (PVector)graph2.get(i);
    PVector tmpp = (PVector)graph2.get(i-1);

    float d = dist(tmp.x,tmp.y,tmpp.x,tmpp.y);

    if(d<50) 
      line(tmp.x,tmp.y,tmpp.x,tmpp.y);
  }
}
