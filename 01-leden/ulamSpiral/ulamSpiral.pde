int dx[] = {1,0,-1,0}; 
int dy[] = {0,-1,0,1};

int x,y;

void setup(){

  size(320,320);

  background(0);
}


void draw(){

  loadPixels();
  int c1 = 0, c2 = 0;
  int seg = 1;

  x = width/2;
  y = height/2;

  for(int i = 0; i < 200;i+=1){

    for(int q = 0 ;q <= seg;q++){

      x += dx[ (seg) % dx.length ];
      y += dy[ (seg) % dy.length ];

      set(x,y,color(255)); 
    }

    seg++;


  }


}


boolean primes(int n)[]{
  boolean tmp[] = new boolean[n];
  for(int i = 1; i <= n; i++){
    int c = 0;
    for(int j = 1 ; j <= i; j++){
      c++;
    }

    tmp[i] = (c==2) ? true : false;


  }
  return tmp;
}
