

double l,ll;
double al,all;

void setup(){

  size(800,800,P2D);




}


void draw(){

  float len = 2000;
  pushMatrix();
  translate(width/2,height/2);

  background(0);
  for(int ii = 1 ; ii < width;ii+=ii){
  

  l = ll = 0.1*ii;
  al = all = 1+1.68033778*frameCount/10000000.0;



  for(int i = 1 ; i < len;i++){
  stroke(255,noise((frameCount+i)/100.0)*60);
    rotate((float)al);
    translate((float)l,0);
    line((float)-l,0,0,0);

    l += ll;
    ll = l/((i+i));

    al += all;
    all = al/((i+i));
  }
  }

  popMatrix();



}



