

void setup(){
  size(256,512,P2D);

  colorMode(HSB);
  noStroke();
  rectMode(CENTER);

  background(0);
}


void draw(){
  
  fill(noise(frameCount/100.0)*255,155,155,100);
  pushMatrix();
  translate(width/2,height/2);
  rotate(frameCount/PI/100.0);
  rect(0,0,20,width);
  popMatrix();

  loadPixels();
  for(int i  = 0;i<height;i++){
    for(int ii  = 0;ii<width;ii++){
      pixels[(i+height-1)%height * width + ii] = color(
          hue(pixels[ii+width*i])-random(10)/10.0,
          saturation(pixels[ii+width*i])-random(10)/10.0,
          brightness(pixels[ii+width*i])-random(10)/10.0+0.7
          );
      }
    }




  updatePixels();

  tint(-1,90);
  image(g,random(-1,1),random(-1,1));
}
