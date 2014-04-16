NoiseBaker nb;


void setup(){

  size(800,600);
  nb = new NoiseBaker("Lenna.png");

  nb.analyze();


}

void draw(){

  background(0);
  nb.draw();
}



class NoiseBaker{

  PImage src;
  float [] vals;
  int seed;
  int w,h,len;
  float accuracy = 23.0;
  float step = 1.0;
  float maxSeek = 1000.0;
  float offset = 10000.0;


  NoiseBaker(String _filename){
    src = loadImage(_filename);

    noiseSeed(19);
    w = src.width;
    h = src.height;

    analyze();

  }

  void analyze(){
    vals = new float[w*h];
    src.loadPixels();

    float c = 0.0;

    for(int i = 0 ; i < src.pixels.length;i++){


      while(
          (abs(red(src.pixels[i]) - map(noise(c),0,1,-127,256+127) )) > accuracy ||
          (abs(green(src.pixels[i]) - map(noise(c+offset),0,1,-127,256+127) )) > accuracy ||
          (abs(blue(src.pixels[i]) - map(noise(c+offset*2),0,1,-127,256+127) )) > accuracy
          ){
        c+=step;
      }
      vals[i] = c;

    }

    println("solution gets"+ c);

  }

  void draw(){

    float s = frameCount;
    offset = noise(s)*1000;

    for(int y = 0 ; y < h;y++){
      for(int x = 0 ; x < w;x++){
        set(x-w/2+width/2,y-h/2+height/2,color(
              map(noise(s+vals[y*w+x]),0,1,0,255),
              map(noise(s+vals[y*w+x]+offset),0,1,0,255),
              map(noise(s+vals[y*w+x]+offset*2),0,1,0,255)
              ));
      }
    }

  }

}
