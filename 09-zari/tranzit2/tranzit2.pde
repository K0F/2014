import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;


// IT VE BR SO ZD J

String s[] = {"I.png","T.png","V.png","E.png","B.png","R.png","S.png","O.png","Z.png","D.png","J.png"};
String s2[] = {"2_I.png","2_T.png","2_V.png","2_E.png","2_B.png","2_R.png","2_S.png","2_O.png","2_Z.png","2_D.png","2_J.png"};

// 1V 1B 1R 1S 1O 2D 2J

//String fn1[] = {"1_D.png","1_E.png","1_I.png","1_J.png","1_T.png","1_Z.png","2_B.png","2_E.png","2_I.png","2_O.png","2_R.png","2_S.png","2_T.png", "2_V.png",  "2_Z.png"};

PImage src;

int val = 0;

PImage[] faze1,faze2;

int w = 800*2;
int h= 600;

boolean rcv = false;

void setup(){


  
  size(800*2,600,P2D);
  oscP5 = new OscP5(this,12000);
  faze1 = new PImage[s.length];
  noCursor();

  for(int i = 0 ; i < s.length;i++){
    faze1[i] = loadImage("new/"+s[i]);
    faze1[i].filter(INVERT);
  }
  background(0);
}

void keyPressed(){
  if(keyCode==RIGHT){
    val++;
    if(val>faze1.length)
      val = 0;
  }
  if(keyCode==LEFT){
    val--;
    if(val<0)
      val = faze1.length;
  }
}

void add(){
  val++;
  if(val>faze1.length){
    val = 0;
  }
}

void add(int _i){
  val = constrain(_i,0,faze1.length+1);
}


void init(){
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();

  super.init();
}

void draw(){
  if(frameCount==1)
    frame.setLocation(0,0);


  background(0);

  if(val==0){
  fill(255);
  rect(800,0,800,500);
  }else if(val>s.length){
  fill(255);
  rect(800,0,800,500);
  //rect(0,20,800,460);
  }
  for(int i = 0; i < val;i++){
    float r = (sin((frameCount)/300.0)+1.0)*127.0 ;
    float g = (sin((frameCount*i)/3.0)+1.0)*127.0 ;
    float b = (sin((frameCount*i)/3.0)+1.0)*127.0 ;

    if(val<=s.length){

      float WIDTH = mouseX;

      //L
      image(faze1[i],0,22,w,h-50);

    }
  }
  rcv = false;
}

void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/signal")==true) {
    if(theOscMessage.checkTypetag("i")) {
      int firstValue = theOscMessage.get(0).intValue();
      add(firstValue);
      rcv = true;
      print("### received an osc message /signal with typetag i.");
      println(" values: "+firstValue);
      return;
    }  
  } 
  println(theOscMessage.toString());
    if(theOscMessage.checkTypetag("ssi")) {
  int firstValue = theOscMessage.get(2).intValue();
      add(firstValue);
      rcv = true;
      print("### received an osc message /signal with typetag ssi.");
     
    }
}
