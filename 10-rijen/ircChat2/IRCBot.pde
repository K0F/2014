import java.io.*;
import java.net.*;

class IRCBot implements Runnable {

  BufferedWriter writer;
  BufferedReader reader;



  boolean logged = false;
  ArrayList texts;
  // The server to connect to and our details.
  String server;
  String nick;
  String login;

  // The channel which the bot will join.
  String channel = "#kof_taz_radio";
  String sonar = "#kof_taz_radio_service";

  // Connect directly to the IRC server.

  IRCBot(String _server, String _channel, String _nick) {

    server = _server;
    login = nick = _nick;
    channel = _channel;

    if (nick.length()==0)
      nick = "";

    texts = new ArrayList();
  }


  void run() {

    try {
      Socket socket = new Socket(server, 6667);


      writer = new BufferedWriter(
      new OutputStreamWriter(socket.getOutputStream( )));
      reader = new BufferedReader(
      new InputStreamReader(socket.getInputStream( )));



      // Log on to the server.
      writer.write("NICK " + nick + "\r\n");
      writer.write("USER " + login + " 8 * : Kof irc applet\r\n");
      writer.flush( );

      String line = null;
      while ( (line = reader.readLine ( )) != null) {
        //println(line);

        if (line.toUpperCase( ).startsWith("PING ")) {
          // respond to PINGs to not being disconnected.
          writer.write("PONG " + line.substring(5) + "\r\n");
          writer.flush( );
        }

        if (line.indexOf("004") >= 0) {
          // We are logged in.
          logged = connected = true;
          connecting = false;

          askPosition();
          callPosition();
          texts.add("Connected, Welcome!");
          break;
        }
        else if (line.indexOf("433") >= 0) {
          System.out.println("Nickname is already in use.");
          //texts.add("Nickname is already in use.");
          connectingMsg = "* NICKNAME IS ALREADY IN USE *\n(you can try to reload the page)";
          return;
        }
        else if (line.indexOf("(Ping timeout)") >= 0) {
          connectingMsg = "* CONNECTION TIMEOUT *\n(you can try to reload the page)";
        }



        debug+=line+"\n";
        ln++;
      }

      // Join communication channel.
      writer.write("JOIN " + channel + "\r\n");
      writer.flush( );

      // Join sonar channel.
      writer.write("JOIN " + sonar + "\r\n");
      writer.flush( );

      // add me as first user
      addUser(new User(nick));



      // Keep reading lines from the server.
      while ( (line = reader.readLine ( )) != null) {
        if (line.toUpperCase( ).startsWith("PING ")) {
          // respond to PINGs to not being disconnected.
          writer.write("PONG " + line.substring(5) + "\r\n");
          writer.flush( );
        }
        else {

          String raw = line;
          System.out.println(raw);

          // sonar channel geo positing
          if (raw.indexOf(sonar)>-1) {
            if (raw.indexOf("SONAR???")>-1) {
              callPosition();
            }
            else if (raw.indexOf("SONAR!!!")>-1) {
              String tmp[] = splitTokens(raw, " ");
              String par[] = splitTokens(tmp[4], ",");

              addUser(new User(par[0]));

              println(tmp);
            }
          }
          //communication layer channel
          else {

            if (raw.indexOf("PRIVMSG")>-1 && raw.indexOf("PING")==-1 && raw.indexOf("STEALTHCOMM")==-1) {
              texts.add(raw.substring(1, raw.indexOf("!"))+"> "+raw.substring(raw.indexOf(channel+" :")+channel.length()+2, raw.length()));
            }

            if (line.indexOf("265") > -1) {
              texts.add("!!!"+line.substring(20+name.length()));
            }

            if (raw.indexOf("JOIN")>-1) {
              // some weird character for our parsing
              texts.add("!!!"+raw.substring(1, raw.indexOf("!"))+" has joined conversation");
            }


            if (raw.indexOf("PART")>-1 || raw.indexOf("QUIT")>-1) {
              // some weird character for our parsing
              rmUser(raw.substring(1, raw.indexOf("!")));
              println(raw.substring(1, raw.indexOf("!")));
              texts.add("!!!"+raw.substring(1, raw.indexOf("!"))+" has left");
            }
          }

          if (texts.size()*10+50>height) {
            texts.remove(0);
          }
        }
      }
    }
    catch(Exception e) {
    }
  }

  void send(String _msg) {

    println("bang!");

    try {
      writer.write("PRIVMSG " + channel + " :"+_msg+"\r\n");
      // some weird character for our parsing
      texts.add("~~~"+msg);
      writer.flush( );
      msg = "";
    }
    catch(Exception e) {
      println(e);
    }
  }

  void callPosition() {
    try {
      writer.write("PRIVMSG "+sonar+" SONAR!!! "+name+"\r\n");
      writer.flush();
    }       
    catch(Exception e) {
      println(e);
    }
  }

  void askPosition() {

    try {
      writer.write("PRIVMSG "+sonar+" SONAR???\r\n");
      writer.flush();
    }       
    catch(Exception e) {
      println(e);
    }
  }
}

