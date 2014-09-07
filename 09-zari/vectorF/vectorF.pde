import processing.pdf.*;

boolean record = false;

void setup() {
  size(600, 800,P3D);
}


void draw() {
  background(255);
  
  if (record) {
    beginRaw(PDF, "output.pdf");
  }

  float step = 10;
  for (float i = 0 ; i < height;i+=step) {
    for (float ii = 0 ; ii < width;ii+=step) {
      float r = noise(i/200.0+frameCount/100.0, ii/200.0+frameCount/100.0);
       pushMatrix();
      translate(ii, i);
    
      pushMatrix();
      rotate(radians(r*360.0*2.0));
      stroke(0,95);
      
      line(0, 0, 0, step/3.0*2);
      noStroke();
      fill(0,95);
      triangle(0,step/3.0*2,-1,step/3.0*2.0-2,1,step/3.0*2.0-2);
      popMatrix();
      popMatrix();
    }
  }
  
  if (record) {
    endRaw();
    record = false;
  }
}

// Hit 'r' to record a single frame
void keyPressed() {
  if (key == 'r') {
    record = true;
  }
}

