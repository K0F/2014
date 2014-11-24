import supercollider.*;
import oscP5.*;
import netP5.*;

Synth synth;



float seek = 1;
int seekMode = 0;

boolean flicker = false;
int rate = 2;

void setup(){

  size(320,240,P2D);

  frameRate(60);
  speed_set(1.0);

  synth = new Synth("sine");

}

void keyPressed(){
  if(key == ' '){
  flicker = !flicker;
  }else if(keyCode==LEFT){
    rate--;
  }else if(keyCode==RIGHT){
    rate++;
  }else if(key>0 && key <=9){
    speed_set((int)key/5.0);
  }else if(key>'a'&&key<'z'){
    seekAbs((((int)(key))-61)/24.0*100);
  }

  rate = constrain(rate,1,1000);
}

int cnt =0;

void draw(){

  background(0);

  if(flicker && frameCount%rate==0){
    background(255);
    float pos = noise(frameCount)>0.5?2.0:-2.0;
    //send();
    seek(pos);
    cnt++;
  }


}

void speed_set(float _in){

  _in = constrain(_in,0,5);
  String a = "speed_set "+_in;
  String b[] = new String[1];
  b[0] = a;
  saveStrings("/tmp/mplayercontrol",b);

}

void seek(){

  String a = "seek "+(random(0,100))+" 1";
  String b[] = new String[1];
  b[0] = a;
  saveStrings("/tmp/mplayercontrol",b);
}

void seek(float _in){

  String a = "seek "+_in+" "+seekMode;
  String b[] = new String[1];
  b[0] = a;
  saveStrings("/tmp/mplayercontrol",b);
}

void seekAbs(float _in){

  String a = "seek "+_in+" 1";
  String b[] = new String[1];
  b[0] = a;
  saveStrings("/tmp/mplayercontrol",b);
}

void send(){


    synth.set("amp",random(10,20)/100.0);
    synth.set("val",(int)63);
    synth.set("freq",110);
    synth.set("freq2",110);
    synth.create();


}

void osd(String _in,int _dur){
  String a = "osd_show_property_text "+_in+" "+_dur+" 0";
  String b[] = new String[1];
  b[0] = a;
  saveStrings("/tmp/mplayercontrol",b);


  //    speed_set(random(-1.0,1.0));
}


