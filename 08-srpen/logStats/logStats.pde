
import java.io.*;

Library lib;
ArrayList users;

void setup(){

  size(800,900);

  textFont(createFont("Semplice Regular",9));

  users = new ArrayList();
  lib = new Library();

}

void draw(){

  background(0);

  fill(255);

  int y = 10;
  for(Object o:users)
  {
    User u = (User)o;
    u.plot(y);
    y+=10;

  }

}


class User{
  String username;

  User(String _username){
    username = _username+"";
    println(username);
  }

  int findout(){
    boolean got = false;

    int id = users.indexOf(this);
    int aid = users.indexOf(this);
check:
    for(int i = 0 ; i < users.size();i++){
      User u = (User)users.get(i);

      if(i!=users.indexOf(this) && u.username.equals(username)){
        aid = i;        
        got = true;
        println("hit");
        break check;
      }

    }

    if(got){
      println("removing duplicate "+username);
      users.remove(users.indexOf(aid));
      return aid;
    }

    return id;




  }

  void plot(int _y){
    text(username,10,_y);
  }

}

class Post{
  User author;
  String time;
  String text;

  Post(String _time,String _author,String _msg){
    author = new User(_author);
    author = (User)users.get(author.findout());
    time = _time;
    text = _msg;

  }


}

class Word{
  String text;
  String date;



}


class Library{
  ArrayList rawList,raw;
  ArrayList posts;
  String[] filenames;

  Library(){

    String fns = executeCommand("ls "+sketchPath+"/data");
    filenames = splitTokens(fns," \n");


    rawList = new ArrayList();
    for(int i = 0 ; i < filenames.length;i++){
      rawList.add(loadStrings(filenames[i]));
    }

    raw = new ArrayList();
    for(Object o:rawList){
      String curr[] = (String[])o;
      for(int i = 0; i< curr.length;i++){
        raw.add(curr[i]+"");
      }
    }

    println("got "+rawList.size()+" files /w "+raw.size()+" lines");
    parse();
  }

  void parse(){
    posts = new ArrayList();
    for(int i = 0 ;i < raw.size();i++){
      String ln = (String)raw.get(i);
      if(ln.indexOf("|")>-1){
        String prs[] = splitTokens(ln,"| ");
        String msg = "";
        for(int ii = 2;ii<prs.length;ii++){
          msg+=prs[ii]+" ";
        }
        posts.add(new Post(prs[0],prs[1],msg));
      }
    }

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
