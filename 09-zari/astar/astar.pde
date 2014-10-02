
int res = 10;

Map map;
Finder finder;

void setup(){
  size(320,320);


  map = new Map();
  finder = new Finder();


}




void draw(){

  background(0);

  stroke(255);
  fill(#ffcc00);

  for(int y = 0;y<width;y+=res){
    for(int x = 0;x<width;x+=res){
      if(map.obstacle[x/res][y/res])
      rect(x,y,res,res);
    }
  }


}


class Map{
  boolean obstacle[][];

  Map(){
    generate(10,100);
  }

  void generate(int a,int b){
    obstacle = new boolean[width/res][height/res];
    int X = 0,Y = 0;
    for(int y = 0;y<width;y+=res){
      for(int x = 0;x<width;x+=res){
        obstacle[X][Y] = random(b)<a?true:false;
        X++;
      }
      X=0;
      Y++;
      
    }
  }
}

class Finder{
  PVector src,dest,pos;

  Finder(){
    src = new PVector((int)random(10),(int)random(10));
      dest = new PVector((int)random(10),(int)random(10));
      pos = new PVector(src.x,src.y);
  }





}
