/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/57569*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
/**
 *  Tiny IRC chat by kof 2012
 */

IRCBot bot;
PFont font;
Thread thread;
Thread flagThread;
String name = "";
String msg = "";
String connectingMsg = "* CONNECTING *\n(it can take some time)";
String debug = "";
int ln = 0;

ArrayList rawUsers;

boolean connecting = false;
boolean connected = false;


void setup() {


  size(700, 354, P2D);

  frameRate(25);

  font = loadFont("65Amagasaki-8.vlw");
  textFont(font);
  textMode(SCREEN);



  rawUsers = new ArrayList();

}



void connect() {
  bot = new IRCBot("irc.freenode.net", "#kof_taz_radio", name);
  thread = new Thread(bot);
  thread.start();
}

void draw() {
  background(0);

  if (!connecting && !connected) {

    textAlign(CENTER);
    fill(#FFCC00);
    text("please enter your name: ", width/2, height/2);


    textAlign(LEFT);
    if (name!=null)
      text(name,width/2+200,height/2);

    fill(#FFCC00, 127*(sin(frameCount/20.0)+1.0));
    text("_",0,0);
  }
  else if (connecting && !connected) {

    textAlign(LEFT);
    fill(255, 0, 0, 140);
    text(debug, 10, height-20-ln*10, width-20, height-40);

    textAlign(CENTER);
    fill(#FFCC00, 127*(sin(frameCount/20.0)+1.0));
    text(connectingMsg, width/2, height/2);
    textAlign(LEFT);
  }
  else if (connected) {




    textAlign(LEFT);


    for (int i = 0 ;i < bot.texts.size();i++) {
      String line = (String)bot.texts.get(i); 



      if (line.startsWith("~~~")) {

        fill(#00FF00);
        text(name+"> "+line.substring(3), 10, 10*i+30);
      }
      else if (line.startsWith("!!!")) {
        fill(#FF0000);
        text(line.substring(3), 10, 10*i+30);
      }
      else {

        fill(#FFCC00);
        text(line, 10, 10*i+30);
      }
    }

    noStroke();
    fill(#FFCC00);
    rect(0, height-10, width, 10);
    fill(0);
    text("message> ", 10, height-2);
    text(msg,textWidth("message> ")+10,height-2);
    fill(0, 127*(sin(frameCount/20.0)+1.0));
    text("_",textWidth("message> "+msg),height-10);


    fill(#FFCC00);
    rect(0, 0, width, 10);
    fill(0);
    text("Tiny IRC", 10, 8);


    textAlign(RIGHT);
    text(""+nf(hour(), 2)+":"+nf(minute(), 2), width-10, 8);
  }



  drawMap();
}

void drawMap() {



  for (int i = 0 ;i<rawUsers.size();i++) {
    User u = (User)rawUsers.get(i);


    stroke(255, 30);
    for (int q = 0 ;q<rawUsers.size();q++) {

      User u2 = (User)rawUsers.get(q);
      line(u.pos.x, u.pos.y, u2.pos.x, u2.pos.y);
    }


    stroke(255, 90);
    line(u.pos.x, u.pos.y, u.pos.x+20, u.pos.y-20);

    stroke(255, 15);
    line(u.pos.x, u.pos.y-height, u.pos.x, u.pos.y+height);
    line(u.pos.x+width, u.pos.y, u.pos.x-width, u.pos.y);  

    fill(255, 100);
    //text("from "+city.toLowerCase()+"",30,18);
    noFill();
    ellipse(u.pos.x, u.pos.y, sin((frameCount+i)/20.0)*30, sin((frameCount+i)/20.0)*30);

    textAlign(CENTER);

    float w = textWidth("[ "+u.userName+" ]")/2.0;
    text("[ "+u.userName+" ]", u.pos.x+20, u.pos.y-22);
    tint(255, 120); 
    image(u.flag, u.pos.x+w+20-16, u.pos.y-18);
  }

  noTint();
}

void keyPressed() {

  if (!connecting && !connected) {

    if ((key >= 'a' && key <= 'z') ||
        (key >= 'A' && key <= 'Z') ||
        (key >= '0' && key <= '9')) {

      if (name.length()<=20)
        name += (char)key;
    }
    else if (keyCode==BACKSPACE) {
      if (name.length()>0)
        name = name.substring(0, name.length()-1);
    }
    else if (key==' ') {
      if (name.length()<=20)
        name += '_';
    }
    else if (keyCode==ENTER) {

      if (name.length()==0) {

        name = "noName";

        for (int i = 0;i<4;i++)
          name += ""+(int)random(0, 9);
      }

      connecting = true;
      connect();
    }
  }

  if (connected) {
    if ((key >= 'a' && key <= 'z') ||
        (key >= 'A' && key <= 'Z') ||
        (key >= '0' && key <= '9')||
        key == '!'||
        key == '.'||
        key == ','||
        key == '?'||
        key == '+'||
        key == '-'||
        key == '*'||
        key == ';'||
        key == '('||
        key == ')'||
        key == '@'||
        key == '%'||
        key == ':'||
        key == '\''||
        key == '$') {

      if (msg.length()<=140)
        msg += (char)key;
    }
    else if (key==' ') {

      if (msg.length()<=140)
        msg += ' ';
    }
    else if (keyCode==BACKSPACE) {
      if (msg.length()>0)
        msg = msg.substring(0, msg.length()-1);
    }
    else if (keyCode==ENTER) {
      if (msg.length()>0) {
        bot.send(msg);
      }
    }
  }
}

class User {
  String userName;
  String code;
  float lat, lon;
  PVector pos;
  PImage flag;

  User(String _un) {
    userName=_un;
  }
}

void addUser(User novacek) {

  boolean hasAlready = false;
  for (int i = 0 ; i < rawUsers.size();i++) {
    User old = (User)rawUsers.get(i);
    if (novacek.userName.equals(old.userName))
      hasAlready = true;
  }

  if (!hasAlready)
    rawUsers.add(novacek);

}

void rmUser(String _name) {
  println("-------"+_name+"---------");
  for (int i = 0 ; i < rawUsers.size();i++) {
    User old = (User)rawUsers.get(i);
    if (old.userName.equals(_name)) {
      rawUsers.remove(old);
    }
  }
}

