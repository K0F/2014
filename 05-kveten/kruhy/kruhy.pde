int num = 100;

float rots[];
float speeds[];
float L[];

int MEM_SIZE = 1000;

ArrayList mem;

void setup(){

  size(512,512);
  rots = new float[num];
  L = new float[num];
  speeds = new float[num];

  mem = new ArrayList();

  for(int i = 0 ; i < num;i++){
    speeds[i] = (random(-PI,PI))/100.0;
    L[i] = random(5,20);
    rots[i] = 0;
  }
}




void draw(){

  background(0);


  stroke(255);

  for(int i = 0 ; i < num;i++){
    rots[i] += speeds[i];
  }

  translate(width/2,height/2);

  for(int i = 0 ; i < num;i++){

    rotate(rots[i]);
    line(L[i],0,0,0);
    translate(L[i],0);

    if(i==num-1)
      mem.add(new PVector(screenX(0,0),screenY(0,0)));
  }

  if(mem.size()>MEM_SIZE){
    mem.remove(0);
  }

  noFill();

  resetMatrix();

  beginShape();
  for(int i = 0 ; i < mem.size();i++){
    stroke(255,map(i,0,mem.size(),0,255));
    PVector tmp = (PVector)mem.get(i);

    vertex(tmp.x,tmp.y);
  }

  endShape();



}
