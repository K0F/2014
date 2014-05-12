import promidi.*;

MidiIO midiIO;


color[] cc = new color[9];

float ctl[] = new float[9];
boolean bang[] = new boolean[9];
float velo[] = new float[9];

void setup(){
  size(1280,720,P2D);
  smooth();
  background(0);
  
  midiIO = MidiIO.getInstance(this);
  println("printPorts of midiIO");
  midiIO.printInputDevices();

  midiIO.openInput(0,0);


  for(int i = 0 ; i < 9;i++){
    cc[i] = color(random(127,255),random(127,255),random(127,255));
  }
}

void draw(){

  background(0);
  noStroke();
  fill(255);
  
  int c =0;
  for(int i = 0 ;i < width;i+=width/8){
    rect(i,(0.5*(sin(frameCount/(ctl[c]+1.0))+1.0))*height ,width/8,10);
    c++;
  }

  for(int i = 0 ;i < 8;i++){
    if(bang[i]){
    fill(cc[i],velo[i]*2);
      ellipse(width/2,height/2,300,300);
    }
  }

}

void noteOn(
  Note note,
  int deviceNumber,
  int midiChannel
){
  int vel = note.getVelocity();
  int pit = note.getPitch();
  bang[pit-36] = true;
  velo[pit-36] = vel;
}


void noteOff(
  Note note,
  int deviceNumber,
  int midiChannel
){

  int pit = note.getPitch();
  bang[pit-36] = false;
}



void controllerIn(
  Controller controller,
  int deviceNumber,
  int midiChannel
){
  int num = controller.getNumber();
  int val = controller.getValue();
 
  ctl[num-1] = val;
}

void programChange(
  ProgramChange programChange,
  int deviceNumber,
  int midiChannel
){
  int num = programChange.getNumber();
  
  fill(255,num*2,num*2,num*2);
  stroke(255,num);
  ellipse(num*5,num*5,30,30);
}
