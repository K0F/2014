
import codeanticode.gsvideo.*;

GSPipeline pipeline;


void setup(){


  size(320,240);

  pipeline = new GSPipeline(this, "playbin2 uri=https://www.youtube.com/watch?v=IpbDHxCV29A");

  // The pipeline starts in paused state, so a call to the play()
  //   // method is needed to get thins rolling.
  pipeline.play();

}







void draw(){
  if (pipeline.available()) {
    pipeline.read();
    image(pipeline, 0, 0);
  }


}
