import java.io.*;

Editor editor;

void setup(){
  size(800,600);

  editor = new Editor();

  //  execute("/home/kof/sketchBook/2014/11-listopad/kofocollider/boot.sh");
  sclang("s.reboot");//"s = Server.local;s.boot;Server.internal=s;Server.default=s;Server.local=s;");
  sclang("Ndef('a').fadeTime = 0.02");
  sclang("Ndef('a').quant = 0.0");

}

void mousePressed(){
}

void draw(){
  background(0);



  //sclang("Ndef('a',{SinOsc.ar([220,220.1]*"+(int)random(1,10)+",mul:0.2)}).play");
  editor.render();
}


class Editor{
  ArrayList lines;
  int current = 0;
  float w =0;
  boolean execute = false;
  float fade = 0;

  Editor(){
    lines = new ArrayList();
    //println(PFont.list());
    textFont(loadFont("SempliceRegular-8.vlw"));

    lines.add("Ndef('a',{SinOsc.ar([220,220.1],mul:0.2)}).play");
  }

  void generate(){
    lines.remove(0);
    lines.add("Ndef('a',{SinOsc.ar([22000,22000]*"+((1.0 / ((pow(2,((int)random(1,8))))+0.0)) )+",mul:0.2)}).play");
  }

  void render(){

    fade += execute?255:-5;
    fade = constrain(fade,0,255);
    
    pushMatrix();
    translate(0,20);

    noStroke();
    for(int i =0 ; i < lines.size();i++){
      String curr = (String)lines.get(i);
      fill(255);
      text(curr,20,i*8);

      if(i==current){
     fill(#ffcc00,fade);
         rect(20-2,i*8+2,w+12,-11);
     
        w = textWidth(curr);
        
        if(execute){
         generate();
         sclang((String)lines.get(current));
         execute = false;
       }
        
        fill((sin(millis()/100.0)+1.0)/2*255);
        text("#",w+20,i*8);


      }
    }

    popMatrix();

  }

}

void keyPressed(){

  if(keyCode==ENTER){
    editor.execute = true;
  }

}


class Executer implements Runnable{
  String command;

  Executer(String _command){
    command = _command;
  }

  void run(){

    String s = null;

    try{

      Runtime runtime = Runtime.getRuntime();

      String cmd[] = {"/bin/sh","-c",command};

      Process p = runtime.exec(cmd);

      BufferedReader stdInput = new BufferedReader(new
          InputStreamReader(p.getInputStream()));

      BufferedReader stdError = new BufferedReader(new
          InputStreamReader(p.getErrorStream()));

      // read the output from the command
      //System.out.println("Here is the standard output of the command:\n");
      while ((s = stdInput.readLine()) != null) {
        System.out.println(s);
      }

      // read any errors from the attempted command
      //System.out.println("Here is the standard error of the command (if any):\n");
      while ((s = stdError.readLine()) != null) {
        System.out.println(s);
      }

    }
    catch (IOException e) {
      System.out.println("exception happened - here's what I know: ");
      e.printStackTrace();
    }
  }
}

void execute(String _in){
  Runnable runnable = new Executer(_in);
  Thread thread = new Thread(runnable);
  thread.start();
}

void sclang(String _in){
  execute("echo \""+_in+";\" > /tmp/lang");
}


void exit(){
  sclang("s.freeAll");
  super.exit();
}
