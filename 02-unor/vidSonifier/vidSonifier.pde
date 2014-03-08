import codeanticode.gsvideo.*;

GSMovie movie;
int newFrame = 0;
PFont font;

void setup() {
  size(1280,720,P2D);
  background(0);

  movie = new GSMovie(this, "/home/kof/render/petriDish/title.mp4");
 
  movie.play();
  movie.goToBeginning();
  movie.pause();
}

void movieEvent(GSMovie movie) {
  movie.read();
}

void draw() {
  image(movie, 0, 0, width, height);
  fill(240, 20, 30);

}

void keyPressed() {
  
  if (key == CODED) {
    if (keyCode == LEFT) {
      if (0 < newFrame) newFrame--; 
    } else if (keyCode == RIGHT) {
      if (newFrame < movie.length() - 1) newFrame++;
    }
  } 
  
  movie.play();
  movie.jump(newFrame);
  movie.pause();  
}
