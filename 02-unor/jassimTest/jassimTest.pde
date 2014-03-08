
import jassimp.Jassimp;

Jassimp model;

void setup(){

  try{
  Jassimp.importFile(sketchPath+"/data/head.blend");
  }catch(Exception e){;}
}

