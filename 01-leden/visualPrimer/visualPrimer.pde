/*
Coded by Kof @ 
Mon Jan 20 23:41:01 CET 2014



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

boolean hit;

boolean hits[];

boolean save = false;

void setup(){

  size(1280,720,OPENGL);

  frameRate(25);
  hits = new boolean[0];
}


void draw(){
  hit = false;

  if(isPrime(frameCount))
    hit = true;

  background(0);
  noStroke();
  fill(255);

  if(hit){
    ellipse(width/2,height/2,720/2,720/2);
  }

  hits = expand(hits,hits.length+1);
  hits[hits.length-1] = hit;

  /*
     if(hit){
     loadPixels();

     int x = width/2, y = height/2-720/4;

     for(int i = 0 ; i < hits.length;i++){
     if(hits[i])
     pixels[y*width+x] = color(255);

     x++;

     float d = dist(x,y,width/2,height/2);

     if(d >= 720/4){
     y++;
     x = (int)width/2-(x-width/2);
     }

     }

     updatePixels();
     }
   */
  if(save)
    saveFrame("/home/kof/render/visualPrimer/#####.png");


}

boolean isPrime(int num){
  if(num%2==0 && num!=2)
    return false;

  boolean prime = false;

  int c = 0;

test:
  for(int i = 1;i<=num;i+=2){
    if(num%i==0)
      c++;

    if(c>2)
      break test;

  }

  prime = c==2 ? true : false;

  return prime;
}
