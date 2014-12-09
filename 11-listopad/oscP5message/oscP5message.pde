/**
 * oscP5message by andreas schlegel
 * example shows how to create osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(200,200);
  frameRate(60);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12000);

  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("10.146.47.255",7777);
  textFont(createFont("SciFly",24,true));
  textAlign(CENTER,CENTER);
}


void draw() {
  background(0);
  noStroke();
  if(frameCount%freq==0 && sending){
    background(255);
    send();
    cntr++;
  }


  if(sending){
  fill(255,0,0);
  rect(0,0,3,3);
  }
  fill(255);

  text("time: "+round(millis()/1000.0)+"\ncount: "+cntr+"\npulse: "+(freq/60.0),width/2,height/2);
}

void keyPressed(){
  if(key==' '){
    sending = !sending;
  }else if(keyCode==DOWN){
    freq++;
  }else if(keyCode==UP){
    freq--;
  }

  freq = constrain(freq,1,100000);
}

boolean sending = false;
int cntr = 0;
int freq = 60;

void send() {
  OscMessage myMessage = new OscMessage("/bang");
  myMessage.add(1); /* add an int to the osc message */
  oscP5.send(myMessage, myRemoteLocation); 

}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}
