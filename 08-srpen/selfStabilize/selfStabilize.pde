
int ID = 0;
int STEP_SIZE = 2;
int X = STEP_SIZE, Y=STEP_SIZE;
ArrayList nodes;

void setup(){

  size(200,200,P2D);

  nodes = new ArrayList();

  while(Y < height-STEP_SIZE || X < width-STEP_SIZE){

    nodes.add(new Node());

    X+=STEP_SIZE;

    if(X>width-STEP_SIZE){
      X = STEP_SIZE;
      Y += STEP_SIZE;
    }
  }

 for(Object o:nodes){
    Node tmp = (Node)o;
    tmp.connect();
  }

}



void draw(){

  background(0);

  for(Object o:nodes){
    Node tmp = (Node)o;
    tmp.plot();
  }

}

class Node{

  int id;
  PVector pos;
  float energy,next_energy;
  ArrayList links,weights;


  Node(){
    id = ID;
    ID++;
    next_energy = energy = 0.5;

    pos = new PVector(X,Y);
  }

  void connect(){
    weights = new ArrayList();
    links = new ArrayList();
    for(int i = 0 ; i < nodes.size();i++){
      Node n = (Node)nodes.get(i);
      if(dist(pos.x,pos.y,n.pos.x,n.pos.y)<=STEP_SIZE*1.8){
        links.add(n);
        weights.add(1.0);
      }
    }
  }

  void plot(){

    compute();

    rectMode(CENTER);
    
    fill(energy*127);
    noStroke();
    rect(pos.x,pos.y,STEP_SIZE,STEP_SIZE);

    /*
    for(int i = 0; i < links.size();i++){
      Node n = (Node)links.get(i);
      float w = (Float)weights.get(i);
      stroke(255,w*50);
      line(pos.x,pos.y,n.pos.x,n.pos.y);
    }
    */
  }

  void compute(){
    energy = next_energy;
    
    float sum = 0;
    
    int mostD = 0;
    float d = 0;
/*
    for(int i = 0 ; i < links.size();i++){
      Node n = (Node)links.get(i);
      
      if(d>abs(energy-n.energy)){
        mostD = i;
        d = abs(energy-n.energy);
      }
    }

    if(d==0)
*/
mostD = (int)(random(links.size()));
    for(int i = 0 ; i < links.size();i++){
      Node n = (Node)links.get(i);
      float w = (Float)weights.get(i);

      sum += w * n.energy;

    }

    sum /= (links.size()+0.0f);
    Node n = (Node)links.get(mostD);
    
    sum = n.energy;
    next_energy += (exp(-sum*200.0)*35.0-energy)/(3.5*2.0);
    
    if(dist(pos.x,pos.y,mouseX,mouseY)<STEP_SIZE) 
      next_energy = (sin(frameCount/10.0)+1.0);

    //next_energy += random(-1000,1000)/100.0;
  }


}
