


String raw[];

ArrayList body;
ArrayList krivky;


float MIN_TIME = 999999, MAX_TIME = 0;
float MIN_FREQ = 999999, MAX_FREQ = 0;

int DATA_OFFSET = 5;

float ZOOM = 30;

void setup(){
  size(1600,900,P3D);


  parse();
  udelejKrivky();


}

void draw(){

  background(0);

  for(Object tmp : krivky){
    Krivka k = (Krivka)tmp;

    stroke(255,200);
    k.draw();


  }


}


void parse(){

  body  = new ArrayList();

  raw = loadStrings("purple_lowres_inve.txt");

  println("nacteno "+raw.length+" radku");

  for(int i = DATA_OFFSET ; i < raw.length;i++){

    String radek[] = splitTokens(raw[i]," ");
    radek[0] = radek[0].replaceAll(",",".");
    float time = parseFloat(radek[0]);

    int pocet = parseInt(radek[1]);


    for(int q = 2 ; q < pocet ;q+=3){
      int id = parseInt(radek[q]);
      float freq = parseFloat(radek[q+1].replaceAll(",","."));
      float vol = parseFloat(radek[q+2].replaceAll(",","."));

      body.add(new Bod(id,freq,vol,time));
    }

  }
}

void udelejKrivky(){

  krivky = new ArrayList();

  for(int i = 0 ; i < body.size();i++){

    Bod tmp = (Bod)body.get(i);

    MIN_FREQ = min(MIN_FREQ,tmp.freq);
    MAX_FREQ = max(MAX_FREQ,tmp.freq);

    MIN_TIME = min(MIN_TIME,tmp.time);
    MAX_TIME = max(MAX_TIME,tmp.time);




    boolean uzMam = false;

    Krivka k = new Krivka(999999);

check:
    for(int q = 0 ; q < krivky.size();q++){
      k = (Krivka)krivky.get(q);
      if(tmp.parent == k.id){
        uzMam = true;
        break check;
      }
    }

    if(uzMam){
      k.pridej(tmp);
    }else{
      krivky.add(new Krivka(tmp.parent,tmp));
    }
  }
}

class Bod{
  int parent;
  float freq, vol, time;

  Bod(int _parent, float _freq , float _vol, float _time){
    freq = _freq;
    vol = _vol;
    parent = _parent;
    time = _time;
  }

}



class Krivka{

  int id;
  float time;
  ArrayList body;

  Krivka(int _id){
    id = _id;
    body = new ArrayList();
  }

  Krivka(int _id, Bod b){
    id = _id;
    body = new ArrayList();
    body.add(b);
    time = b.time;
  }

  void pridej(Bod b){
    body.add(b);
  }

  void draw(){

    noFill();
    beginShape();
    for(Object tmp:body){
      Bod b = (Bod)tmp;
      stroke(255,b.vol*200+55);
      vertex(map(b.time-frameCount/100.0,MIN_TIME,MAX_TIME,0,width*ZOOM),map(b.freq,MIN_FREQ,MAX_FREQ,height/2+300,height/2-300),map(b.vol,0,1,-300,300));
    }
    endShape();

  }
}
