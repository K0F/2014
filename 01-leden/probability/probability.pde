
float [][] val;
float MIN = 10.0,MAX = 0.0;

void setup(){
  size(256,512,P2D);


  val = new float[height][width];
}


void draw(){
  for(int i  = 0;i<val.length;i++){
    for(int ii  = 0;ii<val[i].length;ii++){
      val[i][ii] += random(10)/10.0-0.5;
      val[i][ii] += (-val[i][ii])/1000.0;

      float d = dist(ii,i,mouseX,mouseY);
      if(d>width/4){
      val[i][ii] += (val[(i+1+height)%height][ii]-val[(i-1+height)%height][ii])/3.14;
      }else{
      val[i][ii] += sin(frameCount/4.0)*((d/100.0+1.0));
      }
    }
  }

  MIN = 100000.0;
  MAX = -100000.0;

  for(int i  = 0;i<val.length;i++){
    for(int ii  = 0;ii<val[i].length;ii++){

      MIN = min(val[i][ii],MIN);
      MAX = max(val[i][ii],MAX);
    }
  }

  loadPixels();
  for(int i  = 0;i<val.length;i++){
    for(int ii  = 0;ii<val[i].length;ii++){
      pixels[i*width+ii] = color(map(val[i][ii],MIN,MAX,0,255));
    }
  }
  updatePixels();

}
