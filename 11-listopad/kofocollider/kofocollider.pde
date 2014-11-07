import java.io.*;

void setup(){

 
  execute(sketchPath+"/boot.sh");
  delay(7000);
  sclang("s = Server.local;s.boot;Server.internal=s;Server.default=s;Server.local=s;");
}

void mousePressed(){
  sclang("Ndef(\"a\",{SinOsc.ar([220,220.1])}).play;");
}

void draw(){


}


class Editor{


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
      System.out.println("Here is the standard output of the command:\n");
      while ((s = stdInput.readLine()) != null) {
        System.out.println(s);
      }

      // read any errors from the attempted command
      System.out.println("Here is the standard error of the command (if any):\n");
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
 execute("echo '"+_in+"' > /tmp/lang");
}

