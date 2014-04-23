
import processing.net.*;

Server s;
Client c;



String HTTP_GET_REQUEST = "GET /";
String HTTP_IMG_REQUEST = "GET /test.png";
String HTTP_HEADER = "HTTP/1.0 200 OK\r\nContent-Type: text/html\r\n\r\n";
String IMG_HEADER = "HTTP/1.0 200 OK\r\nContent-Type: application/octet-stream\r\n\r\n";


void setup(){


  size(640,480);

  s = new Server(this,8080);

  textFont(createFont("Semplice Regular",8,false));
  textAlign(CENTER);
}

void draw() 
{
  background(0);
  noStroke();
  fill(255);

  rectMode(CENTER);
  pushMatrix();
  translate(width/2,height/2);
  rotate(frameCount/10.0);
  rect(0,0,100,100);
  popMatrix();
  fill(0);
  text(frameCount,width/2,height/2+3);

  // Receive data from client
  c = s.available();
  if (c != null) {
    String input = c.readString();
    try{
      input = input.substring(0, input.indexOf("\n")); // Only up to the newline
    }catch(Exception e){;}
    if (input.indexOf(HTTP_IMG_REQUEST) == 0) // starts with ...
    {
      c.write(IMG_HEADER);  // answer that we're ok with the request and are gonna send html

      save("test.png");
      byte[] data = loadBytes("test.png");      

      for(int i = 0; i < data.length;i++)
        c.write(data[i]);

      c.stop();
    }else if (input.indexOf(HTTP_GET_REQUEST) == 0) // starts with ...
    {

      c.write(HTTP_HEADER);  // answer that we're ok with the request and are gonna send html

      String [] page = loadStrings("page.txt");


      for(int i = 0 ; i < page.length;i++)
        c.write(page[i]);

      // close connection to client, otherwise it's gonna wait forever
      c.stop();
    }
  }
}

