/*
Coded by Kof @ 
Tue Jan 14 21:20:45 CET 2014



   ,dPYb,                  ,dPYb,
   IP'`Yb                  IP'`Yb
   I8  8I                  I8  8I
   I8  8bgg,               I8  8'
   I8 dP" "8    ,ggggg,    I8 dP
   I8d8bggP"   dP"  "Y8ggg I8dP
   I8P' "Yb,  i8'    ,8I   I8P
  ,d8    `Yb,,d8,   ,d8'  ,d8b,_
  88P      Y8P"Y8888P"    PI8"8888
                           I8 `8,
                           I8  `8,
                           I8   8I
                           I8   8I
                           I8, ,8'
                            "Y8P'
*/
int speedup = 20;

boolean[][] mem;

float x, y;
boolean primes[];

float res = 0.1;
float R = 1;
float zavit = 100.0;

void setup(){
  size(720,720);
  primes = new boolean[1];
  primes[0] = true;
  background(0);


  textFont(loadFont("04b24-8.vlw"));
  mem = new boolean[width][height];
}

int X = 0;

void draw(){
  fill(0,127);
  rect(0,0,width,height);

  for(int i = 0;  i < speedup;i++){
    primes = expand(primes,primes.length+1);
    primes[primes.length-1] = prime(primes.length-1);
  }

  float r = 1.0;
  int cnt = 0;
  R = 1.0/(primes.length)*(height/2.0-20.0);

  zavit *= 0.998;// PI/R/(310.45);//noise(frameCount/1000.0)*10.0;
  int ccnt = 0;

  X++;
  if(X>=width)
    X=0;

  int xx = 0, yy = 0;

rewrite:
  for(int i =0 ; i < primes.length;i++){
   
    mem[xx][yy] = primes[i];

    yy++;
    if(yy>=mouseY){
      xx++;
      yy=0;
    }

    if(xx>=width)
      break rewrite;
  }

loop:
  for(float f = 0 ;f < 1000000.0;f+=res){
    x = cos(f/zavit)*r;
    y = sin(f/zavit)*r;

    //float shift = sin((frameCount/r*zavit)*(((int)x^(int)y)+0.0));

    if(primes[cnt])
      set((int)x+(int)(width/2),(int)y+height/2,color(#ffffff,64));

    if(cnt>=primes.length-height){
      fill(primes[cnt]?#ff0000:#ffffff);
      text(cnt,0,ccnt*8+8);
      ccnt++;
    }

    cnt++;

    r += R;


    if(cnt>=primes.length)
      break loop;
  }

  for(int i = 0;i<width;i++){
    for(int ii = 0 ; ii<mem[i].length;ii++){
    if(mem[i][ii])
      set(i,ii,color(#ff0000));
    }
  }


  updatePixels();


}

boolean primes(int n)[] {
  boolean tmp[] = new boolean[n+1];
  for (int i = 1; i <= n; i++) {
    int c = 0;
test:
    for (int j = 1 ; j <= i; j++) {
      if (i%j==0)
        c++;

      if (c>2)
        break test;
    }

    tmp[i] = (c==2) ? true : false;
  }
  return tmp;
}


boolean prime(int n) {
  boolean tmp = false;

  int c = 0;

test:
  for (int j = 1 ; j <= n; j++) {
    if (n%j==0)
      c++;

    if (c>2)
      break test;
  }

  tmp = (c==2) ? true : false;



  return tmp;
}

