
import java.text.NumberFormat;

int phase = 0;
String input = "";

PFont font1,font2;

double years = 1986;
String one[];

void setup(){
  size(512,512);
  one = new String[3];

  one[0] = "";
  one[1] = "";
  one[2] = "";


  font1 = createFont("Semplice Regular",8,false);
  font2 = createFont("Mocha",24,true);
}



void draw(){

  background(0);

      if(phase>=0)
      ask("If the year of my birth is: ",true,-200);

      if(phase>=1)
      ask("... and the month is:",true,-100);

      if(phase>=2)
      ask("... and the day:",true,0);

      if(phase>=3)
      ask("then the parameters of your UNIVERSE are: ",false,100);

}


void carret(int Y){
  pushMatrix();
  fill((sin(millis()/50.0)+1.0)*127 );
  translate(width/2+textWidth(input)/2,height/2+40-8+Y);
  rect(-1,-8,10,18);
  popMatrix();
}

void ask(String que,boolean _in,int Y){
  textFont(font1,8);
  fill(255);
  textAlign(CENTER);
  text(que,width/2,height/2+Y);
 
 textFont(font2,16);
  

  if(_in){

  text(one[phase].equals("")?input:one[phase],width/2,height/2+40+Y);
  carret(Y);
  }else{
  
  
  NumberFormat format = NumberFormat.getInstance();
  format.setMinimumFractionDigits(0);
  format.setMaximumFractionDigits(0);
  double vol = years+(millis()/1000.0/60.0/60.0/24.0/365.0);
  vol = vol * vol * vol * 299792.458;
  double surf = years+(millis()/1000.0/60.0/60.0/24.0/365.0);
  surf = surf * surf * 299792.458;
  double ratio = surf / vol;
  
  //textAlign(RIGHT);
  text("volume = "+format.format(4.0/3.0*PI*vol)+" km\u00B3",width/2,height/2+40+Y);
  text("surface = "+format.format(4.0*PI*surf)+" km\u00B2",width/2,height/2+60+Y);
  format.setMinimumFractionDigits(10);
  text("SA:V = "+format.format(ratio)+"",width/2,height/2+80+Y);
  };
}

void keyPressed(){
  if((key>='0'&&key<='9'))
    input += key+"";

  if(keyCode==ENTER){
    switch(phase){
      case 0:
      years = year()-parseInt(input);
      one[0] = years+"";
      break;
      case 1:
      years += ((month()-parseInt(input))/12.0);
      one[1] = input+"";
      break;
      case 2:
      years += ((day()-parseInt(input))/365.0);
      one[2] = input+"";
      break;
    }
    
    phase ++;
    
    input = "";
  }
}
