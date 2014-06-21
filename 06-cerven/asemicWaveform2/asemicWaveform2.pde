
import ddf.minim.*;
import ddf.minim.ugens.*;

int BUFFER_SIZE = 1024*4;

Minim minim;
MultiChannelBuffer buffer;

AudioOutput output;
Sampler sampler;

int num = 20;

float rots[];
float speeds[];
float L[];


ArrayList mem;
float graph1[], graph2[];


float freq = 1024;

void setup(){

  size(1600,512,P2D);

  frameRate(120);

  noSmooth();

  graph1 = new float[BUFFER_SIZE];
  graph2 = new float[BUFFER_SIZE];



  minim = new Minim(this);
  output = minim.getLineOut();

  buffer = new MultiChannelBuffer(1,BUFFER_SIZE);
  buffer.setBufferSize(BUFFER_SIZE);



  for(int i = 0 ; i < BUFFER_SIZE;i++){
    buffer.setSample(0,i,0);
    buffer.setSample(1,i,0);
    graph1[i] = 0;
    graph2[i] = 0;
  }

  sampler = new Sampler(buffer,44100,2);
  sampler.patch( output );
  sampler.looping = true;
  sampler.trigger();
}

int cntr =0 ;

void draw(){

  background(0);

  float f = noise(millis()/10000.0) * noise(millis()/1000.0) * 80.0;


  for(int i = 0 ; i < BUFFER_SIZE ; i++){
    graph1[i] *= 0.999;
    graph2[i] *= 0.999;


    graph1[i] = constrain(graph1[i],-1,1);
    graph2[i] = constrain(graph1[i],-1,1);

    graph1[i] += (sin(((i+frameCount)%BUFFER_SIZE)/(f))-graph1[i])/(noise(millis()/101.0+millis()/10001.0)*(mouseX+1.0));
    buffer.setSample(0,i,graph1[i]);

    graph2[i] += (cos(((i+frameCount)%BUFFER_SIZE)/(f))-graph2[i])/(noise(millis()/101.0+millis()/10021.0)*(mouseY+1.0));
    buffer.setSample(1,i,graph2[i]);

  }


  stroke(255);

  for(int i = 1 ; i < width ; i++){
    float a = map(graph1[i],-1,1,height,0);
    float aa = map(graph1[i-1],-1,1,height,0);

    float b = map(graph2[i],-1,1,height,0);
    float bb = map(graph2[i-1],-1,1,height,0);


    line(i-1,aa,i,a);
    line(i-1,bb,i,b);
  }


}
