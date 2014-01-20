boolean hit;

void setup(){

  size(1280,720);

}


void draw(){
  hit = false;

  if(isPrime(frameCount))
    hit = true;

  background(0);
  noStroke();
  fill(255);

  if(hit){
    ellipse(width/2,height/2,720/2,720/2);
  }

  saveFrame("/home/kof/render/visualPrimer/#####.png");


}

boolean isPrime(int num){
  if(num%2==0 && num!=2)
    return false;

  boolean prime = false;

  int c = 0;

test:
  for(int i = 1;i<=num;i+=2){
    if(num%i==0)
      c++;

    if(c>2)
      break test;

  }

  prime = c==2 ? true : false;

  return prime;
}
