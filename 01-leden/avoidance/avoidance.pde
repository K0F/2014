Shape test;
int imgno = 0;
float rots[] = {-7,7,180};
float dist = 10;
float siz = 60;
int step = 1;

PFont font;

void setup(){

  size(800,800);

  font = createFont(PFont.list()[(int)random(PFont.list().length)],siz,true);
  test =new Shape(80,80);

  background(0);

  smooth();

}

void keyPressed(){
  clear();
}

void draw(){

  test.detect(50);

}

void clear(){
  font = createFont(PFont.list()[(int)random(PFont.list().length)],55,true);
  test =new Shape(64,64);

  save("out"+nf(imgno,5)+".png");
  imgno++;
  background(0);
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
    tile.textFont(font,random(12,siz));
    tile.textAlign(CENTER);
    tile.smooth();
    tile.translate(w/2,h/2);
    tile.rotate(rot);
    tile.translate(-w/2,-h/2);
    tile.fill(255);
    tile.noStroke();
    tile.text((char)(int)random(33,122)+"",w/2,h-20);
    tile.endDraw();
    /*
       mask = createGraphics(w,h,JAVA2D);
       mask.beginDraw();
       mask.smooth();
       mask.translate(w/2,h/2);
       mask.rotate(rot);
       mask.translate(-w/2,-h/2);
       mask.fill(255);
       mask.stroke(255);
       mask.strokeWeight(dist);
       mask.endDraw();
     */
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
          if(brightness(pixels[(_y)*width+(_x)]) > 3 && brightness(tile.pixels[Y*w+X]) > 3){
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


}
