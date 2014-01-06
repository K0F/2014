Shape test;
int imgno = 0;
float rots[] = {-35,35};
float dist = 10;

int step = 2;

void setup(){

  size(800,800);

  test =new Shape(64,64);

  background(0);
}


void draw(){

  test.detect(10);

}

class Shape{
  PGraphics tile,mask;
  int w,h;
  int x,y;

  Shape(int _w,int _h){
    w=_w;
    h=_h;

    prepare();
  }

  void prepare(){

    float rot = radians(rots[(int)random(rots.length)]);

    tile = createGraphics(w,h,JAVA2D);
    tile.beginDraw();
    tile.smooth();
    tile.translate(w/2,h/2);
    tile.rotate(rot);
    tile.translate(-w/2,-h/2);
    tile.fill(255);
    tile.noStroke();
    tile.triangle(w/5*2,10,w/5*3,10,w/2,h-10);
    tile.endDraw();

    mask = createGraphics(w,h,JAVA2D);
    mask.beginDraw();
    mask.smooth();
    mask.translate(w/2,h/2);
    mask.rotate(rot);
    mask.translate(-w/2,-h/2);
    mask.fill(255);
    mask.stroke(255);
    mask.strokeWeight(dist);
    mask.triangle(w/5*2,10,w/5*3,10,w/2,h-10);
    mask.endDraw();
  }

  void detect(int iter){

    for(int i = 0 ; i < iter;i++){
      prepare();



      x = (int)random(width-w);
      y = (int)random(height-h);

      loadPixels();
      tile.loadPixels();

      boolean overlap = false;

      int X = 0;
      int Y = 0;

SKIP:
      for(int _y = y; _y < y + h - 2 ; _y+=step){
        X = 0;
        for(int _x = x; _x < x + w - 2; _x+=step){
          if(brightness(pixels[(_y)*width+(_x)]) > 3 && brightness(mask.pixels[Y*w+X]) > 3){
            overlap = true;
            break SKIP;
          }
          X+=step;
        }
        Y+=step;
      }


      if(!overlap){
        draw();
      }
    }


  }

  void draw(){
    image(tile,x,y);
  }

  void clear(){
    save("out"+nf(imgno,5)+".png");
    x=0;
    y=0;
    background(0);
  }

}
