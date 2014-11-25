// pivo,35,4.5%
// vino,45,12%
// kafe,29,0%
// voda,0,0% 
// fresh,60,0%
// rum,80,52%
// zelena,23,30%

//////////////////////////

int hlavicka = 2;
String nazevSouboru = "data.csv";


//////////////////////////

color barvy[];
String vstupniData[];

String jmena[];
int ceny[];
float procentaAlkoholu[]; 
float objemy[]; 



void setup() {
  size(640, 480);



  vstupniData = loadStrings(nazevSouboru);

  jmena = new String[vstupniData.length-hlavicka];
  ceny = new int[vstupniData.length-hlavicka];
  procentaAlkoholu = new float[vstupniData.length-hlavicka];
  objemy = new float[vstupniData.length-hlavicka];

  barvy = new color[jmena.length];

  textFont(createFont("Arial", 12));

  for (int i = 0; i < jmena.length; i++) {
    barvy[i] = color(random(127, 255), random(127, 255), random(127, 255));
  }

  for (int index = hlavicka; index < vstupniData.length; index++) {
    String temp = vstupniData[index];
    String oddelene[] = splitTokens(temp, "/ ,%");
    jmena[index-hlavicka] = oddelene[0];
    ceny[index-hlavicka] = parseInt(oddelene[1]);
    procentaAlkoholu[index-hlavicka] = parseFloat(oddelene[2]);
    objemy[index-hlavicka] = parseFloat(oddelene[3]);
  }

  println(ceny);

  colorMode(HSB);
  noLoop();
}

void draw() {

  background(0);

  int div = (int)(width / (jmena.length+0.0));


  noStroke();

  textAlign(CENTER);

  float X[], Y[];

  X = new float[jmena.length];
  Y = new float[jmena.length];


  for (int i = 0; i < jmena.length; i ++) {

    float x = map(i, 0, jmena.length, 0, width);
    float cenaH = map(ceny[i], 0, 100, 0, -height);
    float alkoH = map(procentaAlkoholu[i], 0, 52, 0, 255);

    float cenaZaLitr = ceny[i] * (1.0/objemy[i]);
    float objemAlkoholu = objemy[i] * (procentaAlkoholu[i] / 10.0);
    float alkoholuZaCenu = ceny[i] * objemAlkoholu;
    println(jmena[i]+"cena: "+ceny[i]+" cenaZaLitr: "+cenaZaLitr+", objemAlkoholu:"+objemAlkoholu+" cena za ml:"+alkoholuZaCenu);

    pushMatrix();
    translate(width/2, height/2);
    pushMatrix();
    rotate(map(i, 0, jmena.length, 0, radians(360)));

    float efektivita = map(alkoholuZaCenu, 20, 0, 0, 1);
    stroke(0, efektivita*255, 127);

    line(0, 0, 0, efektivita*width/3);
    X[i] = screenX(0, efektivita*width/3);
    Y[i] = screenY(0, efektivita*width/3);

    fill(127, 255, 127);
    text(jmena[i], x+div/2, height-5);
    popMatrix();
    popMatrix();
    //rect(x, height, div, map(procentaAlkoholu[i], 0, 50, 0, -height));
  }

  noFill();
  stroke(255, 55);

  for (int i = 0; i < width*2; i+=20) {

    ellipse(width/2, height/2, i, i);
  }

  beginShape();
  for (int i = 0; i < jmena.length; i++) {

    fill(255, 15);

    vertex(X[i], Y[i]);
    endShape();
  }

    for (int i = 0; i < jmena.length; i++) {
      fill(255);
      text(jmena[i], X[i], Y[i]);
    }
  }
