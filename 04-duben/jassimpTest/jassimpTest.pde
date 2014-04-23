
import jassimp.*;

String filepath;

AiScene scene;

void setup(){

  size(640,480);

  try{
    filepath = sketchPath+"/data/rig_test.blend";
    println("importing "+filepath);
    scene = Jassimp.importFile(filepath);
  }catch(Exception e){
    println("load failed: "+e);
  }

}

void draw(){

  background(255);

}
