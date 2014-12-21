import rwmidi.*;

MidiInput input;
MidiOutput output;
int maxNote = 84;
int minNote = 36;
int numNotes = maxNote-minNote;
int notePlayed = (maxNote+minNote)/2;

boolean bang[];
float fade[];
color colors[];

void setup() {
  size(256, 256);
  //println("Midi device list:");
  //println(RWMidi.getInputDeviceNames());
  input = RWMidi.getInputDevices()[0].createInput(this);
  //output = RWMidi.getOutputDevices()[1].createOutput();
  //println("Input: " + input.getName());
  //println("Output: " + output.getName());

  bang = new boolean[128];
  fade = new float[128];
  colors = new color[128];

  for(int i = 0 ; i < bang.length;i++)
  {
    bang[i] = false;
    fade[i] = 255;
    colors[i] = color(random(12,255),random(12,255),random(12,255));
  }
}



void draw() {
  background(0);
  rectMode(CENTER);

  noStroke();
  fill(255);

  for(int i = 0 ; i < bang.length;i++){
    if(bang[i]){
      fill(colors[i],fade[i]);
      rect(width/2,height/2,100,100);

    }

    if(fade[i]>=0)
      fade[i] -= 100.0;

      fade[i] = constrain(fade[i],0,255);
  }

}


///////////////////////////////////////////
void noteOnReceived(Note note) {
  notePlayed = note.getPitch();
  if(frameCount>10){
    bang[notePlayed] = true;
    fade[notePlayed] = 255;
  }
  // println("Note on: " + note.getPitch() + ", velocity: " + note.getVelocity());
}

void noteOffReceived(Note note) {

  if(frameCount>10){
    bang[note.getPitch()] = false;
    fade[note.getPitch()] = 0;
  }
  // println("Note off: " + note.getPitch());
}

void controllerChangeReceived(Controller controller) {
  //  println("CC: " + controller.getCC() + ", value: " + controller.getValue());
}
