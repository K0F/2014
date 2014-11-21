import processing.video.*;
Movie myMovie;

String name = "VTS_03_3.VOB";
float duration = 0;

boolean flick = false;

int seek = 5;

void setup() {
  size(720,576,P2D);
  myMovie = new Movie(this, "/home/kof/render/mesner_predstaveni/"+name);
  myMovie.loop();
  println(name+" : "+duration);
}

void draw() {
  tint(255,120);
  if(flick){
  if(frameCount%25==0)
    myMovie.jump(random(seek-5,seek));
    }
/*
    if(frameCount%2==0){
    translate(width,0);
    scale(-1,1);
    }
    */
  image(myMovie, random(-2,2),random(-2,2));
}
// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
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
