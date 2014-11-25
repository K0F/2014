
String [] txt;
ArrayList slova,vsechna;

float r = 7;

int s = 48;

PFont [] fonts;

void setup(){
  size(1280,720,P2D);

  slova = new ArrayList();
  vsechna = new ArrayList();

  txt = loadStrings("texty_n.txt");
  for(int i = 0 ; i < txt.length;i++){
    String [] tmp = splitTokens(txt[i]," .,");
    for(int ii = 0 ; ii < tmp.length;ii++){
      vsechna.add(((String)tmp[ii]));
    }
  }

  fonts = new PFont[150];
  for(int i = 0; i < 150;i++){
    fonts[i] = createFont(PFont.list()[i],s);
  }

}
void draw(){

  background(0);

  if(frameCount%10==0){    
    slova.add(new Slovo());
  }

  //if(slova.size()>10)
   // slova.remove(0);

  for(int i = 0 ; i < slova.size();i++){
    Slovo tmp = (Slovo)slova.get(i);
    tmp.draw();
  }


}

class Slovo{

  String now = "";
  float x,y;
  float dim = 255;
  float fade;
  PFont font;

  Slovo(){
    now =  (String)vsechna.get((int)random(vsechna.size()));
    font = fonts[(int)random(fonts.length)];
    fade = random(3,10);
    x = random(200,width-200);
    y = random(200,height-200); 
    float dim = 255;
  }

  void draw(){

    textAlign(CENTER);

    if(dim<10){
      slova.remove(slova.indexOf(this));
      //now = (String)vsechna.get((int)random(vsechna.size()));
      //x = random(200,width-200);
      //y = random(200,height-200); 
      //dim = 255;
    }
    textFont(font);

    fill(255,dim);
    text(now,x,y);

    dim -= fade;
  }
}
