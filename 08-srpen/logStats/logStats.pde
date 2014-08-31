
import java.io.*;

Library lib;


void setup(){

        lib = new Library();

}


class User{
  String username;


}

class Post{
  String time;
  String text;


}

class Word{
  String text;



}


class Library{
  String raw[];
  String[] filenames;

  Library(){

        String fns = executeCommand("ls "+sketchPath+"/data");
        filenames = splitTokens(" ",fns);
        println(filenames[0]);
  }

}


  String executeCommand(String command) {
    StringBuffer output = new StringBuffer();

    Process p;
    try {
      p = Runtime.getRuntime().exec(command);
      p.waitFor();
      BufferedReader reader = 
        new BufferedReader(new InputStreamReader(p.getInputStream()));

      String line = "";                       
      while ((line = reader.readLine())!= null) {
        output.append(line + "\n");
      }

    } catch (Exception e) {
      e.printStackTrace();
    }

    return output.toString();

}
