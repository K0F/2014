

void setup(){

  size(1280,720,OPENGL);




}


void draw(){

  background(0);

  //translate(width/2,height/2);

  stroke(255);

  for(int y = 0 ; y < height;y+=2){
    for(int x = 0 ; x < width;x+=2){
      float X = sin(atan2(x,y)/1000.0)*width;
      float Y = atan2((y+x+random(100)/100.0)/2.0,x+frameCount/100.0)*height;
      line(X,Y,X+1,Y);

      }
      }

}
