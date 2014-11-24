import processing.video.*;
import codeanticode.gsvideo.*;

Movie myMovie[];
GSCapture input;

PImage mask;



//String name[] = {"VTS_03_1.VOB","VTS_03_2.VOB","VTS_03_3.VOB"};
//String name[] = {"1.vob","2.vob","8.vob","4.vob","5.vob","6.vob","sen.mpg"};
String name[] = {"1.vob","tydenik.mpg","tydenik2.mpg","sen.mpg"};

int sel = 0;

float duration = 0;

boolean flick = true;
boolean fade = false;
float tnt = 255;

int seek = 5;

void init(){
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();
  super.init();

}

void setup() {
  size(768,1024);

  myMovie = new Movie[name.length];

  for(int i = 0 ; i < name.length;i++){
    myMovie[i] = new Movie(this, "/home/kof/render/mesner_predstaveni/new/"+name[i]);
    myMovie[i].loop(); 
  }

  noiseSeed(19);

  mask = loadImage("mask.png");
  println(name+" : "+duration);
  input = new GSCapture(this, 640,480,"/dev/video1");

  input.start();
}

float H = -50;

void draw() {



  imageMode(CENTER);

  if(frameCount<5)
    frame.setLocation(0,0);
  background(0);

  float am = (noise(millis()/10000.0))*255;
  float am2 = (noise(100000+millis()/10000.0))*255;

  //tint(255,255);

  /*
     if(fade){
     tnt-=5;
     }else if(fade && tnt<=5){
     tnt+=5;
     }
   */

  if(flick){
    pushMatrix();
    translate(width/2+20, height/2+sin(millis()/am*1000.0)*am/90.0-10+H);
    rotate(-HALF_PI);


    // if(tnt<255)
    // tint(255,tnt);

    image(input,0,0,1200,768);
    popMatrix();
    //blend(a,0,0,width,height,(int)random(-5,5),(int)random(-5,5),width,height,ADD);
  }else{
    //   if(fade)
    //   tint(255,255-tnt);      


    image(myMovie[sel], width/2,height/2+sin(millis()/am*1000.0)*am/90.0-10+H);
    image(mask,width/2+random(-1,1),height/2+random(-1,1)+H);
  }

  // noTint();

  noStroke();
  fill(0);
  rect(0,700,0,width);
  strokeWeight(10);
  stroke(255);
  noFill();

  //image(myMovie2, width/2,height/2+sin(millis()/am2*1000.0)*am2/60.0-10+H+450,620,430);
  // rect(1,1,width-2,height-2);
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
    {
  for(int i = 0 ; i < myMovie.length;i++){
myMovie[i].jump(0);
}
    }



  println((int)key);
  if(key > '0' && key <= '9')
  {
    sel = (int)key-49;
  }
  seek = constrain(sel,0,name.length-1);

  if(key=='q')
    flick = false;

  if(key=='f')
    fade = !fade;

  println(sel);
}
