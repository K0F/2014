

float seek= 0;


void setup(){

  size(512,400);

  frameRate(30);
  speed_set(1.0);


}

int cnt =0;

void draw(){

  background(0);

  if(frameCount%50==0){

    //    speed_set(random(-1.0,1.0));

    float pos = noise(frameCount)>0.5?2.0:-2.0;
    seek(pos);

    cnt++;
  }

  if(frameCount%100==0){
    seek = random(0,100);


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

  String a = "seek "+_in+" 0";
  String b[] = new String[1];
  b[0] = a;
  saveStrings("/tmp/mplayercontrol",b);
}

void osd(String _in,int _dur){
  String a = "osd_show_property_text "+_in+" "+_dur+" 0";
  String b[] = new String[1];
  b[0] = a;
  saveStrings("/tmp/mplayercontrol",b);


  //    speed_set(random(-1.0,1.0));
}

void keyPressed(){

  if(key>0 && key <=9){

  }

}
