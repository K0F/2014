
import java.io.*;

Library lib;
ArrayList users;

void setup(){

  size(800,900);

  textFont(createFont("Semplice Regular",8));

  users = new ArrayList();
  lib = new Library();


  try{
  for(Object o:users)
  {
    User u = (User)o;
    u.findout();

  }
  }catch(Exception e){
  println(e);}

 

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
  Post parent;

  User(String _username,Post _parent){
    username = _username+"";
    parent = _parent;
  }

  void findout(){
    boolean got = false;
    int who = 0;

check:
    for(int i = 0 ; i < users.size();i++){
      User u = (User)users.get(i);
      
      if(u.username.indexOf(username)>-1 && users.indexOf(this)!=i){
        got = true;
        parent.author = u;
        break check;
      }
    }

    if(got){
      users.remove(this);
    }
  }

  void plot(int _y){
    text(username+" "+users.indexOf(this),10,_y);
  }

}

class Post{
  User author;
  String time;
  String text;

  Post(String _time,String _author,String _msg){
    author = new User(_author,this);
    users.add((User)author);
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
        String prs[] = splitTokens(ln,"| \t");
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
