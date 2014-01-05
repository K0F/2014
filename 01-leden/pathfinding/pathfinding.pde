ArrayList sites;
ArrayList connections;
ArrayList walkers;

Site end;

int num = 100;
int NUMBER_OF_CONNECTIONS = 5;
int BORDER = 100;



int NUM_WALKERS = 500;
int MAX_STEPS = 100;
float HEURESTICS = 95.0;

float AVERAGE = 1.0;

float RECORD = 999999999;

void setup(){

  size(1024,768,P2D);

  reset();

  smooth();
  rectMode(CENTER);

  ellipseMode(CENTER);
  textFont(createFont("Semplice Regular",8,false));
  textAlign(CENTER);

}

/////////////////

Site getMostDistant(){
  float d = 0.0;
  Site first = (Site)sites.get(0);
  int idx = -1;

  for(int i = 1 ; i < sites.size();i++){
    Site tmp = (Site)sites.get(i);
    float dd = dist(tmp.pos.x,tmp.pos.y,first.pos.x,first.pos.y);
    if(dd>d){
      d = dd;
      idx = i;
    }
  }

  return (Site)sites.get(idx);
}

void reset(){

  sites = new ArrayList();

  for(int i = 0 ; i < num;i++)
    sites.add(new Site());

  recalculate();

  end = getMostDistant();

  walkers = new ArrayList();

  for(int i = 0 ; i < NUM_WALKERS;i++)
    walkers.add(new Walker());

}

void recalculate(){

  connections = new ArrayList();

  for(int i = 0 ; i < sites.size();i++){
    Site s = (Site)sites.get(i);
    s.castConnections(NUMBER_OF_CONNECTIONS);
  }
}

void mousePressed(){
  reset();
}

float averageD(){

  float sum = 0;
  for(int i = 0 ; i < connections.size();i++){
    Connection c = (Connection)connections.get(i);
    sum+=c.distance;
  }
  sum /= (connections.size()+1.0);
  return sum;
}

void align(float speed){

  AVERAGE = averageD();

  for(int i = 0 ; i < connections.size();i++){
    Connection c = (Connection)connections.get(i);

    float q = noise(frameCount/100.0+c.A.pos.x/100.0)*4.0;
    speed = c.distance * q;

    if(abs(c.distance-AVERAGE) > 2.0)
      if(c.distance < AVERAGE){
        c.A.pos.x -= (c.B.pos.x-c.A.pos.x) / speed;   
        c.A.pos.y -= (c.B.pos.y-c.A.pos.y) / speed;   
        c.B.pos.x -= (c.A.pos.x-c.B.pos.x) / speed;   
        c.B.pos.y -= (c.A.pos.y-c.B.pos.y) / speed;
      }else if(c.distance > AVERAGE){
        c.A.pos.x += (c.B.pos.x-c.A.pos.x) / speed;   
        c.A.pos.y += (c.B.pos.y-c.A.pos.y) / speed;   
        c.B.pos.x += (c.A.pos.x-c.B.pos.x) / speed;   
        c.B.pos.y += (c.A.pos.y-c.B.pos.y) / speed;
      }
  }
  recalculate();
}

void drawConnections(){
  stroke(0,45);
  for(int i = 0 ; i < connections.size();i++){
    Connection c = (Connection)connections.get(i);
    strokeWeight(c.weight);
    stroke(0,40);
    line(c.A.pos.x,c.A.pos.y,c.B.pos.x,c.B.pos.y);
    fill(100,0,0,100);
    noStroke();

    PVector mid = new PVector(lerp(c.A.pos.x,c.B.pos.x,0.5),lerp(c.A.pos.y,c.B.pos.y,0.5));
    text(round(c.distance),mid.x,mid.y);
    /*
       pushMatrix();
       translate(c.B.pos.x,c.B.pos.y);
       rotate(atan2(c.B.pos.y-c.A.pos.y,c.B.pos.x-c.A.pos.x)+HALF_PI);
       triangle(0,0,3+c.weight,12+c.weight,-3-c.weight,12+c.weight);
       popMatrix();
     */
  }
}


void draw(){
  background(255);

  for(int i = 0 ; i < num;i++){
    Site s = (Site)sites.get(i);
    s.draw();
  }

  //  align(100.0);
  drawConnections();

  for(int i = 0; i < walkers.size();i++){

    Walker walker = (Walker)walkers.get(i);
    walker.draw();
  }
}

class Walker{
  PVector pos;
  Site current,next;
  float speed = 2.0;
  float hist = 0;
  ArrayList fullhist;

  Walker(){
    fullhist = new ArrayList();

    current = (Site)sites.get(0);
    pos = new PVector(current.pos.x,current.pos.y);
    next = getNext();

    //println(next);
  }

  void draw(){
    pushMatrix();
    translate(pos.x,pos.y);
    fill(#ffcc00,120);
    ellipse(0,0,10,10);
    popMatrix();



    if(next!=null&&current!=null)
      move();


  }

  void move(){
    PVector dir = new PVector(next.pos.x-current.pos.x,next.pos.y-current.pos.y);
    dir.normalize();
    dir.mult(speed);
    pos.add(dir);

    if(dist(pos.x,pos.y,next.pos.x,next.pos.y) < 1.0){



      if(next==end){
        if(RECORD>hist){
          RECORD = hist;  
          win(1.0);
        }else{
          win(0.1);
        }
      } 

      Site previous = current;
      current = next;
      pos = new PVector(current.pos.x,current.pos.y);

      while(previous==next)
        next = getNext();

    }
  }

  void lose(){
    ArrayList filtered = new ArrayList();
    for(int i = 0 ; i < fullhist.size();i++){
      Connection c = (Connection)fullhist.get(i);
      boolean uniq = true;

      for(int q = 0; q < filtered.size();q++)
      {
        Connection ctmp = (Connection)connections.get(q);
        if(ctmp==c){
          uniq = false;
          break;
        }
      }

      if(uniq)
        filtered.add(c);
    }

    for(int q = 0;q<filtered.size();q++){
      Connection c = (Connection)fullhist.get(q);
      c.weight += (1.0-c.weight)/100.0;
    }
    walkers.add(new Walker());
    walkers.remove(this);
  }

  void win(float reward){
    ArrayList filtered = new ArrayList();
    for(int i = 0 ; i < fullhist.size();i++){
      Connection c = (Connection)fullhist.get(i);
      boolean uniq = true;

      for(int q = 0; q < filtered.size();q++)
      {
        Connection ctmp = (Connection)connections.get(q);
        if(ctmp==c){
          uniq = false;
          break;
        }
      }

      if(uniq)
        filtered.add(c);
    }

    for(int q = 0;q<filtered.size();q++){
      Connection c = (Connection)fullhist.get(q);
      c.weight += reward;
    }
    walkers.add(new Walker());
    walkers.remove(this);
  }

  Site getNext(){

    ArrayList dirs = new ArrayList();
    ArrayList indexes = new ArrayList();
    for(int i = 0 ; i < connections.size();i++){
      Connection c = (Connection)connections.get(i);
      Site a = c.A;
      Site b = c.B;

      //bidirectional
      if(a == current){
        dirs.add(b);
        indexes.add(i);
      }
      if(b == current){
        dirs.add(a);
        indexes.add(i);
      }


    }

    float maxW = 1.0;
    int best = (int)random(dirs.size());

    //heurestics
    if(random(100) < HEURESTICS)
      for(int i = 0 ; i < dirs.size();i++){
        Connection c = (Connection)connections.get((Integer)indexes.get(i));
        if(c.weight > maxW ){
          maxW = c.weight;
          best = i;
        }
      }

    int choice = best;
    hist += ((Connection)connections.get(choice)).distance;
    Connection ccc = (Connection)connections.get((Integer)indexes.get(choice));
    //experimental weakening
    ccc.weight += (1.0-ccc.weight)/100.0;
    Site tmp = (Site)dirs.get(choice);
    fullhist.add(ccc);
    return tmp;
  }

}

class Connection{
  Site A,B;
  float distance;
  float weight;

  Connection(Site _A,Site _B){
    weight = 1.0;
    A=_A;
    B=_B;
    distance = dist(A.pos.x,A.pos.y,B.pos.x,B.pos.y);
  }

}

class Site{
  PVector pos;

  Site(){
    pos = new PVector(random(BORDER,width-BORDER),random(BORDER,height-BORDER));
  }

  void castConnections(int num){


    for(int q = 0 ; q < num ; q++){

      float d = width*height;
      int sel = -1;

      for(int i = 0 ; i < sites.size();i++){
        if(i!=sites.indexOf(this)){
          Site s = (Site)sites.get(i);
          float tmp = dist(s.pos.x,s.pos.y,pos.x,pos.y);

          boolean isin = false;

          //already has check
          for(int ii = 0 ; ii < connections.size();ii++){
            Connection c = (Connection)connections.get(ii);
            if((c.B == s && c.A == this) || (c.A == s && c.B == this))
              isin = true;
          }

          if(tmp < d && !isin){
            d = tmp;
            sel = i;
            //if(!isin)
            // sel = i;
          }
        }
      }

      if(sel != -1){
        //println(sites.indexOf(this)+" => "+sites.indexOf((Site)sites.get(sel)));
        connections.add(new Connection(this,(Site)sites.get(sel)));
      }
    }

  }

  void draw(){
    pushMatrix();
    translate(pos.x,pos.y);
    fill(this==end?#ff0000:0);
    text(sites.indexOf(this),0,-4);
    noStroke();
    fill(this==end?#ff0000:0);
    rect(0,0,5,5);
    popMatrix();


  }



}
