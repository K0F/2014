/*
   (
   SynthDef(\sine, { |outbus = 0, amp = 0.5, freq = 440, freq2 = 440, val = 63, pan = 0|
   var data,env,efx;
   env = EnvGen.ar(Env([0,1,0],[0.03,1.133],[3,-3,3]),doneAction:2);
   freq = Lag.kr(freq, 0.01);
   data = SinOsc.ar((freq*freq2/1pi)*env, {ExpRand()}!2, amp) * 
   SinOsc.ar((val-63)*0.125pi) * env;
   efx = GVerb.ar(data,2,2,mul:0.15,add:data);
   Out.ar(outbus, Pan2.ar(efx, pan));
   }).store;
   )
 */






import supercollider.*;
import oscP5.*;
import netP5.*;

Synth synth;

Graph graph;
PFont font;

int NUM_NODES = 24;
int KADENCE = 10;
int FADEOUT = 60;

String result = "";

boolean RENDER = false;

void setup(){

  
  size(1280,720,RENDER?JAVA2D:P2D);

  randomSeed(19);

  font = createFont("Semplice Regular",8,false);
  textFont(font);
  textLeading(8);


  graph = new Graph(NUM_NODES);
  synth = new Synth("sine");

  
}


void draw(){


  background(0);

  fill(88);
  textAlign(LEFT);
  text(result,10,10,width-20,height-10);

  fill(15);
  stroke(255,50);
  graph.organize();
  graph.plot();
  graph.update();

  if(result.length()>200)
    result = result.substring(1,result.length());

  if(RENDER)
    saveFrame("/home/kof/render/markovSystem/fr#####.png");

  if(frameCount>=5000){
    exit();
  }
}

void mousePressed(){
  result = "";
  graph = new Graph(NUM_NODES);
  synth = new Synth("sine");
}


class Node{
  Graph parent;
  PVector pos;
  int val;
  String name;
  ArrayList cons,ws;
  boolean active = false, activate = false;
  float fl = 15;
  int choice = 0;
  Node nextOne;

  String information;

  Node(Graph _parent){


    parent = _parent;
    nextOne = this;

    if(parent.nodes.size()==0){
      active = true; 
      activate = true;
    }

    val = round(random(0,4));
    name = val+"";

    cons = new ArrayList();
    ws = new ArrayList();

    pos = new PVector(random(-100,100),random(-100,100));

    information = (char)(parent.nodes.size()+65)+"";
  }

  void connect(){
    float mx = 0;
    for(Object o: parent.nodes){
      Node n = (Node)o;
      cons.add(n);
      float w = random(0.0,100)/100.0;
      ws.add(w);
      mx = max(mx,w);
    }

    int i = 0;
    for(Object o: ws){
      float n = (Float)o;
      n /= mx;
      ws.set(i,n);
      i++;
    }

  }

  void organize(){
    int i = 0 ; 
    for(Object o: parent.nodes){
      Node n = (Node)o;
      float w = (Float)ws.get(i);
      float dist = dist(pos.x,pos.y,n.pos.x,n.pos.y);
      if(dist<100*(1.5-w)){
        pos.x -= (n.pos.x-pos.x)/100.0;
        pos.y -= (n.pos.y-pos.y)/100.0;
      }

      if(dist>200*(1.5-w)){
        pos.x += (n.pos.x-pos.x)/1000000.0;
        pos.y += (n.pos.y-pos.y)/1000000.0;
      }
      i++;
    }

  }

  void plotCons(){
    noFill();
    int i = 0;

    for(Object o: cons){
      float f = (Float)ws.get(i);
      stroke(255,(active&&i==choice)?255*f:35*f);
      Node n = (Node)o;
      beginShape();
      vertex(pos.x,pos.y);

      float x1 = pos.x;
      float x2 = n.pos.x;

      float y1 = pos.y;
      float y2 = n.pos.y;

      float dx = x2 - x1;
      float dy = y2 - y1;
      float mag = sqrt(dx*dx + dy*dy);
      dx /= mag;
      dy /= mag;

      float lambda = (dx * (lerp(pos.x,n.pos.x,0.5) - x1)) + (dy * (lerp(pos.y,n.pos.y,0.5) - y1));
      float x4 = (dx * lambda) + x1 ;
      float y4 = (dy * lambda) + y1 ;


      bezierVertex(x1,y1,lerp(0,dx,0.5),lerp(0,dy,0.5),x2,y2);
      vertex(n.pos.x,n.pos.y);
      endShape();
      i++;
    }
  }

  void sendSignal(Node n){
    result += information;

    KADENCE = (int)map((int)((char)information.charAt(0)),65,90,2,30);

    synth.set("amp",random(10,20)/100.0);
    synth.set("val",(int)((char)information.charAt(0)));
    synth.set("freq",screenX(n.pos.x,n.pos.y));
    synth.set("freq2",screenY(n.pos.x,n.pos.y));
    synth.create();

    active = false;
    activate = false;
    n.activate = true;
  }

  void inactivate(){
    active = false;
    activate = false;
  }

  void update(){

    if(active && frameCount%KADENCE==0)
      sendSignal(nextOne);


    active = activate;

    if(active && frameCount%KADENCE==0)
      nextOne = getNextNode();
  }

  Node getNextNode(){
    int choose = 0;
    float mx = 0;

    for(int i = 0 ; i < ws.size();i++){
      float f = (Float)ws.get(i);
      float ran = random(f*100.0);
      if(ran>=mx){
        mx = ran;
        choose = i;
      }
    }

    choice = choose;
    return (Node)parent.nodes.get(choose);

  }

  void plotCenters(){
    fl = active?255:constrain(fl-FADEOUT,15,255);
    fill(fl);
    pushMatrix();
    translate(pos.x,pos.y);

    stroke(255,55);
    ellipse(0,0,25,25);
    fill(active?0:200);
    textAlign(CENTER);
    text(information,-1,4);
    popMatrix();


  }
}

class Graph{
  ArrayList nodes;

  Graph(int _NUM){
    nodes = new ArrayList();
    for(int i = 0 ; i < _NUM;i++){
      nodes.add(new Node(this));
    }
    connectAll();
  }

  void connectAll(){
    for(Object o: nodes){
      Node n = (Node)o;
      n.connect();
    }
  }

  void organize(){
    for(Object o: nodes){
      Node n = (Node)o;
      n.organize();
    }
  }

  void update(){
    for(Object o: nodes){
      Node n = (Node)o;
      n.update();
    }
  }

  void plot(){
    pushMatrix();
    translate(width/2,height/2);
    for(Object o: nodes){
      Node n = (Node)o;
      n.plotCons();
    }
    for(Object o: nodes){
      Node n = (Node)o;
      n.plotCenters();
    }
    popMatrix();
  }
}

void exit ()
{
  synth.free();
  super.exit();
}

