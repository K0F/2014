
byte buffer[];

void setup(){
  size(32,16);

  textFont(createFont("Semplice Regular",8,false));
  noSmooth();

}



void draw(){

  background(0);

  fill(255);
  textAlign(CENTER);
  text("kof 14",width/2,height/2+4);

  buffer = new byte[width*height+1];
  loadPixels();
  for(int i = 0 ; i < buffer.length;i++){
    if(i>=pixels.length){
    buffer[i] = (byte)0;
    }else{
    buffer[i] = (byte)pixels[i];
}
    }



  saveBytes("render/bf"+nf(frameCount,5)+".dat",buffer);

}
