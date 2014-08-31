int ID = 0;
ArrayList neurons;
Pattern pattern;

int side = 64;

int NUM_NEURONS = side*side;
int numC = 2;
int NUM_INPUTS = side-1;

int SHIFT = 0;

float L_SPEED = side;

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

  if(frameCount%10==0)
  SHIFT++;

  if(SHIFT>width-NUM_INPUTS-1)
  SHIFT = 0;

  pattern.plot();

  inputVals(SHIFT);

  for(int i = NUM_INPUTS; i < neurons.size();i++){
    Neuron n = (Neuron)neurons.get(i);
    n.collect();
  }

  Neuron last = (Neuron)neurons.get(neurons.size()-1);
  float mean_error = pattern.vals[NUM_INPUTS+SHIFT] - last.val;

  for(int i = NUM_INPUTS; i < neurons.size();i++){
    Neuron n = (Neuron)neurons.get(i);
    n.backprop(mean_error);
  }

  pattern.results[SHIFT] = last.val;

  translate(SHIFT,0);
  for(int i = 0; i < neurons.size();i++){
    Neuron n = (Neuron)neurons.get(i);
    n.plot(i);
  }
}

void inputVals(int shift){
  for(int i =0 ; i < NUM_INPUTS;i++){
    Neuron n = (Neuron)neurons.get(i);
    n.val = pattern.vals[i+shift];
  }
}

class Pattern{
  float vals[];
  float results[];

  Pattern(){
    vals = new float[width];
    results = new float[width];

    for(int i = 0 ; i < vals.length;i++)
      vals[i] = noise(i/10.0);
  }

  void plot(){
    for (int i = 1 ; i < vals.length;i++){
    stroke(255,30);
      line(i,vals[i]*height,i-1,vals[i-1]*height);
    stroke(#ffcc00,30);
      line(i,results[i]*height,i-1,results[i-1]*height);
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
      connections.add(new Connection(this,(Neuron)neurons.get((int)random(neurons.size()))));
    }
  }

  void plot(int _i){
    stroke(val*255);
    point(_i%side,_i/side);
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

    sum /= cntr;
    nextVal = sum;
  }

  void backprop(float err){
    for(int i = 0;  i < connections.size(); i++){
        Connection c = (Connection)connections.get(i);
        c.w += (1.5-abs(err))/L_SPEED;
    }
  }

}

class Connection{
  float w;
  float error;

  int id;
  Neuron A,B;

  Connection(Neuron _A,Neuron _B){
    w = 1.0;
    error = 0;
    A = _A;
    B = _B;
    id=ID++;
  }
}
