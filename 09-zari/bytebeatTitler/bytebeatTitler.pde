
byte buffer[];

void setup(){
  size(32,16);

  textFont(createFont("Smeplice Regular",8));
  noSmooth();

}



void draw(){

  background(0);

  fill(255);
  textAlign(CENTER);
  text("kof 14",width/2,height/2);

  buffer = new byte[width*height];
  loadPixels();
  for(int i = 0 ; i < pixels.length;i++)
    buffer[i] = (byte)pixels[i];



  saveBytes("render/bf"+nf(frameCount,5)+".dat",buffer);

}
