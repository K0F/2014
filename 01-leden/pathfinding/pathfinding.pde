ArrayList sites;
ArrayList connections;

int num = 99;
int NUMBER_OF_CONNECTIONS = 2;
int BORDER = 20;

float AVERAGE = 1.0;

void setup(){

  size(800,600,P2D);

  reset();

  smooth();
  rectMode(CENTER);

  textFont(createFont("Semplice Regular",8,false));
  textAlign(CENTER);
}

void reset(){

  sites = new ArrayList();

  for(int i = 0 ; i < num;i++)
    sites.add(new Site());

  recalculate();

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

void draw(){
  background(255);


  for(int i = 0 ; i < num;i++){
    Site s = (Site)sites.get(i);

    s.draw();

  }

  align(100.0);
  drawConnections();

}

void align(float speed){

  AVERAGE = averageD();

  for(int i = 0 ; i < connections.size();i++){
    Connection c = (Connection)connections.get(i);

    speed = c.distance;

    if(abs(c.distance-AVERAGE)>2.0)
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
    stroke(0,40);
    line(c.A.pos.x,c.A.pos.y,c.B.pos.x,c.B.pos.y);
    fill(100,0,0,100);
    noStroke();
    pushMatrix();

    PVector mid = new PVector(lerp(c.A.pos.x,c.B.pos.x,0.5),lerp(c.A.pos.y,c.B.pos.y,0.5));
    text(round(c.distance),mid.x,mid.y);

    translate(c.B.pos.x,c.B.pos.y);
    rotate(atan2(c.B.pos.y-c.A.pos.y,c.B.pos.x-c.A.pos.x)+HALF_PI);
    triangle(0,0,3,12,-3,12);
    popMatrix();
  }
}

/*
   class Path{
   int A,B = 0;
   ArrayList way;

   Path(){
   A = (int)random(sites.size());
   B = (int)random(sites.size());

   while(B==A)
   B = (int)random(sites.size());

   }

   void calculate(){

   way = new ArrayList();
   float d = width*height;

   Site start = (Site)sites.get(A);

   int index = A;
   int next = A;

   while(index==B){

   for(int i = 0 ; i < start.distances.size();i++){
   float tmp = (Float)start.distances.get(i);
   if(tmp<d){
   d = tmp;
   index = i;
   }
   next = index;
   way.add(index);
   }


   }



   }

   }
 */
class Connection{
  Site A,B;
  float distance;

  Connection(Site _A,Site _B){
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
    text(sites.indexOf(this),0,-4);
    noStroke();
    fill(0);
    rect(0,0,5,5);
    popMatrix();


  }



}
