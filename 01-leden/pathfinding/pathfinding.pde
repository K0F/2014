ArrayList sites;
int num = 10;

void setup(){

  size(800,600,P2D);

  sites = new ArrayList();

  for(int i = 0 ; i < num;i++)
    sites.add(new Site());


  for(int i = 0 ; i < sites.size();i++){
    Site s = (Site)sites.get(i);

    s.calculateDistances();

  }

  rectMode(CENTER);

  textFont(createFont("Semplice Regular",8,false));
}


void draw(){
  background(255);

  for(int i = 0 ; i < num;i++){
    Site s = (Site)sites.get(i);

    s.draw();

  }


}

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

class Site{
  PVector pos;
  ArrayList distances;

  Site(){
    pos = new PVector(random(width),random(height));
  }

  void calculateDistances(){

    distances = new ArrayList();
    for(int i = 0 ; i < sites.size();i++){
      Site s = (Site)sites.get(i);
      distances.add((float)dist(pos.x,pos.y,s.pos.x,s.pos.y));
    }


  }

  void draw(){
    pushMatrix();
    translate(pos.x,pos.y);
    text(sites.indexOf(this),0,0);
    noStroke();
    fill(0);
    rect(0,0,5,5);
    popMatrix();

    drawPaths();

  }

  void drawPaths(){
    stroke(0,15);
    for(int i = 0 ; i < sites.size();i++){
      Site s = (Site)sites.get(i);
      line(pos.x,pos.y,s.pos.x,s.pos.y);
    }
  }


}
