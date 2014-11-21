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
  size(768,1024,OPENGL);
  myMovie = new Movie(this, "/home/kof/render/mesner_predstaveni/"+name);
  myMovie.loop();


  noiseSeed(19);

  mask = loadImage("mask.png");
  println(name+" : "+duration);
  input = new GSCapture(this, 640,480,"/dev/video1");
  input.start();
}

float H = 150;

void draw() {


  if(frameCount<5)
    frame.setLocation(0,0);
  background(0);

  float am = (noise(millis()/10000.0))*255;

  tint(255,255-am);

  if(flick){
    //if(frameCount%25==0)
    //myMovie.jump(random(seek-5,seek));

    input.filter(GRAY);
    image(input, 50,H+50+sin(millis()/am*1000.0)*am/60.0);

    //blend(a,0,0,width,height,(int)random(-5,5),(int)random(-5,5),width,height,ADD);
    //blend(a,0,0,width,height,0,0,width,height,MULTIPLY);
  }else{
    image(myMovie, 60,H+sin(millis()/am*1000.0)*am/60.0+80,620,430);
    //fill(0,585);
    //rect(0,0,width,height);
    //blend(myMovie,0,0,width,height,(int)random(-5,5),(int)random(-5,5),width,height,ADD);
    //blend(myMovie,0,0,width,height,0,0,width,height,MULTIPLY);

    noTint();

    imageMode(CENTER);
    image(mask,width/2+random(-1,1),H+random(-1,1));
    imageMode(CORNER);
  }
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
