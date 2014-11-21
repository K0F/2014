import processing.video.*;
import codeanticode.gsvideo.*;

Movie myMovie;
GSCapture input;

PImage mask;



String name = "VTS_03_2.VOB";
float duration = 0;

boolean flick = false;

int seek = 5;

void init(){
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();
  super.init();

}

void setup() {
  size(720,576,P2D);
  myMovie = new Movie(this, "/home/kof/render/mesner_predstaveni/"+name);
  myMovie.loop();


  noiseSeed(19);

  mask = loadImage("mask.png");
  println(name+" : "+duration);
  input = new GSCapture(this, 640,480,"/dev/video1");
  input.start();
}

void draw() {
  if(frameCount<5)
    frame.setLocation(0,0);

  float am = (noise(millis()/100000.0))*255;

  tint(255,255);

  if(flick){
    //if(frameCount%25==0)
    //myMovie.jump(random(seek-5,seek));
    image(input,0,0);
  }else{
    if(frameCount%1==0){
      translate(0,height);
      scale(1,-1);
    }
    //image(myMovie, 0,sin(millis()/am*1000.0)*am/30.0);
    //fill(0,585);
    //rect(0,0,width,height);
    blend(myMovie,0,0,width,height,(int)random(-5,5),(int)random(-5,5),width,height,ADD);
    blend(myMovie,0,0,width,height,0,0,width,height,MULTIPLY);
  }
  noTint();

  imageMode(CENTER);
  image(mask,width/2,height/2);
  imageMode(CORNER);
}
// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

public void captureEvent(GSCapture c) {
  c.read();
}

void keyPressed(){
  if(key==' ')
    flick = !flick;

  if(keyCode==LEFT)
    seek--;

  if(keyCode==RIGHT)
    seek++;

  seek = constrain(seek,5,2000);
}
