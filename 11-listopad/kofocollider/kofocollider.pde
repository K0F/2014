import java.io.*;

void setup(){

  //    runCmd("sclang "+sketchPath+"/boot.scd");
  //    runCmd("echo -E '{Splay.ar(SinOsc.ar(220))}).play' /tmp/lang | sclang");

  execute("sclang "+sketchPath+"/boot.scd");

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
      Process p = runtime.exec(command);

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

      System.exit(0);
    }
    catch (IOException e) {
      System.out.println("exception happened - here's what I know: ");
      e.printStackTrace();
      System.exit(-1);
    }




  }
}

void execute(String _in){
  Runnable runnable = new Executer(_in);
  Thread thread = new Thread(runnable);
  thread.start();

}


