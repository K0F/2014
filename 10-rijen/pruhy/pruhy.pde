
void init(){
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();

  super.init();

}

void setup(){

  size(1024,768);


}


void draw(){

  frame.setLocation(0,0);
  background(255);
  noStroke();
  fill(0);

  float r = (sin(frameCount/1000.0)+1.0)*30+2;
  int c = 0;



  for(int i = 0 ; i < width; i += 10){
   
   if(c%2==0)
   rect(i,0,r,height);
  c++; 
  }


}
