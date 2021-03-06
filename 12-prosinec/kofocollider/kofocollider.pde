import java.io.*;

Editor editor;

String sketchAbsPath = "/sketchBook/2014/11-listopad/kofocollider";

void init(){

  execute("rm /tmp/lang ; mkfifo /tmp/lang ; chmod 777 /tmp/lang");
  execute("pkill scsynth");
  delay(250);
  execute("(tail -f /tmp/lang | supercollider)");
  //execute("(terminator -x sh "+sketchAbsPath+"/boot.sh &)" );

  //  execute("/home/kof/sketchBook/2014/11-listopad/kofocollider/boot.sh");
  sclang("s.reboot");//"s = Server.local;s.boot;Server.internal=s;Server.default=s;Server.local=s;");
  sclang("Ndef('a').fadeTime = 2.0");
  sclang("Ndef('a').quant = 1.0");

  super.init();
}

void setup(){
  size(800,900);
  editor = new Editor();
}

void draw(){
  background(0);

  //sclang("Ndef('a',{SinOsc.ar([220,220.1]*"+(int)random(1,10)+",mul:0.2)}).play");
  editor.render();
}


class Editor{
  ArrayList lines;

  int currln = 0;
  int carret = 0;

  int rozpal = 14;

  float w =0,wc =0;
  boolean execute = false;
  float fade = 0;

  Editor(){
    lines = new ArrayList();
    //println(PFont.list());
    //textFont(loadFont("SempliceRegular-8.vlw"));
    textFont(loadFont("LiberationMono-12.vlw"));

    lines.add("Ndef('a',{SinOsc.ar([220,220.1],mul:0.2)}).play");
    for(int i = 0 ; i<50;i++)
    lines.add(new String(""));
  }

  void generate(){
    lines.remove(0);
    lines.add("Ndef('a',{SinOsc.ar([22000/"+(pow(2,(int)random(1,6)))+",22000/"+(pow(2,(int)random(1,6)))+"]*"+((1.0 / ((pow(2,((int)random(1,8))))+0.0)) )+",mul:0.2)}).play");
  }

  void render(){

    //carret = constrain(carret,0,((String)lines.get(currln)).length()-1);

    fade += execute?255:-15;
    fade = constrain(fade,0,255);

    pushMatrix();
    translate(0,20);

    noStroke();
    for(int i =0 ; i < lines.size();i++){
      String curr = (String)lines.get(i);
      fill(255);
      text(curr,20,i*rozpal);

      if(i==currln){
        fill(#ffcc00,fade);
        rect(20-2,i*rozpal+2,w+12,-11);

        w = textWidth(curr);
        wc = textWidth(curr.substring(0,carret));

        if(execute){
          sclang((String)lines.get(currln));
          execute = false;
        }

        fill(#ff0000,(sin(millis()/100.0)+1.0)/2*255);
        text("!",wc+20-3,i*rozpal);


      }
    }

    popMatrix();

  }

}

void keyPressed(){

  if(keyCode==ENTER){
    editor.execute = true;
  }

  if(keyCode==LEFT)
    editor.carret--;

  if(keyCode==RIGHT)
    editor.carret++;

  if(keyCode==DOWN){
      editor.currln++;

  //  if(editor.currln>editor.lines.size()-1){
   //   editor.lines.add(new String(""));
    //  editor.carret = 0;
    //  editor.currln++;
    //}else{
   // }


  }

  if(keyCode==UP){
    if(editor.currln>=0)
      editor.currln--;
  }

  if(keyCode==BACKSPACE && editor.carret>0){
    String tmp = (String)editor.lines.get(editor.currln);
    if(tmp.length()>0){
    editor.lines.set(editor.currln,tmp.substring(0,editor.carret-1)+""+tmp.substring(editor.carret,tmp.length()));
    editor.carret--;
    }
  }

  if(keyCode==DELETE){
    String tmp = (String)editor.lines.get(editor.currln);
    if(tmp.length()>0){
    editor.lines.set(editor.currln,tmp.substring(0,editor.carret)+""+tmp.substring(editor.carret+1,tmp.length()));
    editor.carret--;
    }
  } 

  if((int)key>=24 && (int)key <= 126){
    String tmp = (String)editor.lines.get(editor.currln);
    editor.lines.set(editor.currln,tmp.substring(0,editor.carret)+""+key+tmp.substring(editor.carret,tmp.length()));
    editor.carret++;
  }

  editor.carret = constrain(editor.carret,0,((String)editor.lines.get(editor.currln)).length());
  editor.currln = constrain(editor.currln,0,editor.lines.size()-1);
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
      String env[] = {"PATH=/bin/:/usr/bin/:/usr/local/bin/","DISPLAY=:0.0","SHELL=/bin/bash","USER=kof"};

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
  execute("pkill scsynth");
  super.exit();
}
