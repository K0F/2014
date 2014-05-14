

import ddf.minim.*;
import ddf.minim.ugens.*;

int BUFFER_SIZE = 1024;

Minim minim;
MultiChannelBuffer buffer;

AudioOutput output;
Sampler sampler;



int num = 10;

float rots[];
float speeds[];
float L[];

int MEM_SIZE = BUFFER_SIZE;

ArrayList mem;
ArrayList graph1, graph2;


float freq = 512;



void setup(){

  size(1024,512,P2D);

  smooth();

  rots = new float[num];
  L = new float[num];
  speeds = new float[num];

  mem = new ArrayList();
  graph1 = new ArrayList();
  graph2 = new ArrayList();

  for(int i = 0 ; i < num;i++){
    speeds[i] = (random(-PI,PI))/100.0;
    L[i] = random(10,80);
    rots[i] = 0;
  }


  minim = new Minim(this);
  output = minim.getLineOut();

  buffer = new MultiChannelBuffer(1,BUFFER_SIZE);
  buffer.setBufferSize(BUFFER_SIZE*2);
  for(int i = 0 ; i < BUFFER_SIZE*2;i++){
    buffer.setSample(0,i,sin(i/2.0));
  }

  sampler = new Sampler(buffer,44100,1);
  sampler.patch( output );
  sampler.looping = true;
  sampler.trigger(); 


}


void draw(){

  background(0);

        //
                freq = mouseX + 1;
        //

  stroke(255);

  for(int i = 0 ; i < num;i++){
    rots[i] += speeds[i];
  }

  pushMatrix();

  translate(width/2,height/2);

  for(int i = 0 ; i < num;i++){

    rotate(rots[i]);
    line(L[i],0,0,0);
    translate(L[i],0);

    if(i==num-1){
      mem.add(new PVector(screenX(0,0),screenY(0,0)));
      graph1.add(new PVector(frameCount%width,screenY(0,0)));
      graph2.add(new PVector(frameCount%width,screenX(0,0)/(width/(height+0.0))));
    }
  }

  if(mem.size()>MEM_SIZE){
    mem.remove(0);
    graph1.remove(0);
    graph2.remove(0);
  }

  noFill();

  popMatrix();

  for(int i = 1 ; i < mem.size();i++){
    stroke(#ffffff,map(i,0,mem.size(),0,120));
    PVector tmp = (PVector)mem.get(i);
    PVector tmpp = (PVector)mem.get(i-1);

    line(tmp.x,tmp.y,tmpp.x,tmpp.y);
  }

  for(int i = 1 ; i < mem.size();i++){
    stroke(#ffcc00,map(i,0,mem.size(),0,90));
    PVector tmp = (PVector)graph1.get(i);
    PVector tmpp = (PVector)graph1.get(i-1);

    float d = dist(tmp.x,tmp.y,tmpp.x,tmpp.y);

    if(d<50) 
      line(tmp.x,tmp.y,tmpp.x,tmpp.y);
  }

  for(int i = 1 ; i < mem.size();i++){
    stroke(#ff0000,map(i,0,mem.size(),0,90));
    PVector tmp = (PVector)graph2.get(i);
    PVector tmpp = (PVector)graph2.get(i-1);

    float d = dist(tmp.x,tmp.y,tmpp.x,tmpp.y);

    if(d<50) 
      line(tmp.x,tmp.y,tmpp.x,tmpp.y);
  }

  stroke(255,120);

  // buffer write
  for(int i = 1 ; i < BUFFER_SIZE * 2;i++){
    PVector pg1 = (PVector)graph1.get( round(((sin( (i-1)/freq )+1.0)/2.0)*(mem.size()-1.0)) );
    PVector pg2 = (PVector)graph2.get( round(((sin( (i-1)/freq )+1.0)/2.0)*(mem.size()-1.0)) ) ;

    PVector g1 = (PVector)graph1.get( round(((sin( (i)/freq )+1.0)/2.0)*(mem.size()-1.0)) );
    PVector g2 = (PVector)graph2.get( round(((sin( (i)/freq )+1.0)/2.0)*(mem.size()-1.0)) ) ;
    float y = 2.0 *  map(g1.y,0,height,-1,1) * map(g2.y,0,height,-1,1);
    float py = 2.0 *  map(pg1.y,0,height,-1,1) * map(pg2.y,0,height,-1,1);

    buffer.setSample(0,i,y);

    line(
        map(i-1,0,BUFFER_SIZE*2,0,width),
        map(py,-1,1,height,0),
        map(i,0,BUFFER_SIZE*2,0,width),
        map(y,-1,1,height,0)
        );
  }

}
