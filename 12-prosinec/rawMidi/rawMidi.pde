import rwmidi.*;

MidiInput input;
MidiOutput output;
int maxNote = 84;
int minNote = 36;
int numNotes = maxNote-minNote;
int notePlayed = (maxNote+minNote)/2;

void setup() {
  size(256, 256);
  println("Midi device list:");
  println(RWMidi.getInputDeviceNames());
  input = RWMidi.getInputDevices()[0].createInput(this);
  output = RWMidi.getOutputDevices()[1].createOutput();
  println("Input: " + input.getName());
  println("Output: " + output.getName());
}


int c = 1;

void draw() {
  //if(frameCount%width==0)
  background(0);


  if (frameCount%60<=1) {
    output.sendController(0, c++, 127);
    rectMode(CENTER);
    rect(width/2, height/2, 200, 200);
  } else {
    output.sendController(0, 1, 0);
 }

 if(c>=8)
 c=1;
}


///////////////////////////////////////////
void noteOnReceived(Note note) {
  notePlayed = note.getPitch();
  println("Note on: " + note.getPitch() + ", velocity: " + note.getVelocity());
}

void noteOffReceived(Note note) {
  println("Note off: " + note.getPitch());
}

void controllerChangeReceived(Controller controller) {
  println("CC: " + controller.getCC() + ", value: " + controller.getValue());
}


