int ID = 0;
ArrayList neurons;
Pattern pattern;

int NUM_NEURONS = 320;
int numC = 10;

void setup(){

  size(800,600);



  pattern = new Pattern();

  neurons = new ArrayList();
  for(int i = 0 ; i < NUM_NEURONS;i++)
    neurons.add(new Neuron());

  for(Object o:neurons){
    Neuron n = (Neuron)o;
    n.makeConnections();
  }

}



void draw(){

  background(0);



}


class Pattern{
  float vals;

  Pattern(){
    vals = new float[width];
  }

  void plot(){
    stroke(255,30);
    for (int i = 1 ; i < vals.length;i++){
      line(i,vals[i],i-1,vals[i-1]);
    }
  }


}

class Neuron{
  ArrayList connections;

  float val,nextVal;
  Neuron(){

    val = nextVal = 1;
  }

  void makeConnections(){
    connections = new ArrayList();
    for(int i = 0;  i < numC ; i++){
      connections.add(this,neurons.get((int)random(neurons.size())));
    }
  }

  void collect(){

    val = nextVal;

    float sum = 0.0;
    float cntr = 0.0;

    for(int i = 0 ; i < connections.size();i++){
      Connection current  = (Connection)connections.get(i);
      Neuron other = current.B;

      sum += current.w * other.val;
      cntr ++;
    }

    sum \= cntr;


    nextVal = sum;


  }

}

class Connection{
  float w;
  float error;

  int id;
  Neuron A,B;

  Connection(Neuron _A,Neuron _B){
    w = random(0,20)/20.0;
    error = 0;
    A = _A;
    B = _B;
    id=ID++;
  }



}
