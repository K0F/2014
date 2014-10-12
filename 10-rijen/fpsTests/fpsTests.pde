void setup(){
  size(320,240,P2D);
  frameRate(48);
}

void draw(){

  boolean third = false;//frameCount%3==0?true:false;
  background(0);
  smooth();
  strokeWeight(2);
  noFill();
 

 if(!third){
  translate(width/2+random(-10,10)/60.0,height/2+random(-10,10)/60.0);

  stroke(255);

  pushMatrix();
  rotate(frameCount/((cos(frameCount/1201.0)+1.0)*60.0+0.0001));
  ellipse(0,0,100,100);
  stroke(255);
  line(-50,0,50,0);
  stroke(#ff0000);
  line(0,-50,0,50);
  popMatrix();
}



}
