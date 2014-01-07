int dx[] = {1,0,-1,0}; 
int dy[] = {0,-1,0,1};
int num = 720*5;

int x,y;
boolean primes[];

void setup(){

  size(1280,720);

  background(0);

  loadPixels();
  primes = primes(10);
}


void draw(){

  primes = new boolean[primes.length+1];
  primes = primes(primes.length);

  background(0);
  loadPixels();

  x = width/2;
  y = height/2;

  float seg = 1;
  int cnt = 0;
 
  for(int i = 1; i < primes.length / 5.0; i+= 1){
    for(int q = 0 ; q < seg ;q++){
      color c = color(primes[(cnt+frameCount)%primes.length ]?#ffffff:#000000);
      x += dx[ (int)(i) % (dx.length) ];
      y += dy[ (int)(i) % (dy.length) ];

      set(x,y,c);
      cnt++;
    }

    if(i%3==0)
      seg+=1;
  }
}


boolean primes(int n)[]{
  boolean tmp[] = new boolean[n+1];
  for(int i = 1; i <= n; i++){
    int c = 0;
test:
    for(int j = 1 ; j <= i; j++){
      if(i%j==0)
        c++;

      if(c>2)
        break test;
    }

    tmp[i] = (c==2) ? true : false;


  }
  return tmp;
}
