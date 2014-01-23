
import com.sun.speech.freetts.Voice;
import com.sun.speech.freetts.VoiceManager;
import com.sun.speech.freetts.audio.JavaClipAudioPlayer;


Basnik verlaine;


boolean DEBUG = false;

String text[];
String raw;
ArrayList words;
ArrayList nodes;

Node walker;
String result = "";
ArrayList output;

int pause = 100;
int speed = 2;

void setup(){

  size(480,320);

  verlaine = new Basnik("kevin16");

  textFont(loadFont("SempliceRegular-8.vlw"));

  getWords();
  castNodes();
  makeConnections();
  printAllConnections();

  walker = (Node)nodes.get((int)random(nodes.size()));
  output = new ArrayList();
  output.add(walker.word);
}

void draw(){

  background(0);

  if(frameCount%pause==0){
    walker = walker.pickNext();
    pause =  walker.word.length() * speed;
    result += walker.word+" ";
    output.add(walker.word);
  }


  int x = 10, y = 10;
  int first = 0;
  int c = 0;

  for(Object a: output){
    text((String)a,x,y);

    float off = textWidth((String)a+" ");
    x += (int)off;


    if(x>=width-20-off){
      if(y==10)
        first = c;


      x=10;
      y+=10;

    }
    c++;
  }

  if(y>=20){
    String tmp = "";
    for(int i = 0;i<first;i++){
      tmp+=(String)output.get(i)+" ";
    }

    verlaine.mluv(tmp);

    for(int i = first ; i >= 0;i--){
      output.remove(i);
    }
  }


}


class Node{
  ArrayList next;
  ArrayList positions;
  ArrayList choices;
  int id;
  float weights[];
  String word;

  Node(String _word){
    choices = new ArrayList();
    next = new ArrayList();
    word = _word;
  }

  Node pickNext(){
    try{
      Node tmp = (Node)next.get((int)random(next.size()));

      while(tmp==null){
        tmp = (Node)next.get((int)random(next.size()));
      }

      return tmp;
    }catch(Exception e){
      return this;
    }
  }

  void addConnection(Node _n){
    if(DEBUG)
      println(word+ " is searching for: "+_n.word);
    next.add(_n);
  }




  void addConnection(String _in){
    if(DEBUG)
      println(word+ " is searching for: "+_in);
    int test = 0;
search:
    for(Object tmp: nodes){
      Node n = (Node)tmp; 
      if(n.word.equals(_in)){
        test = nodes.indexOf(n);
        Node newNode = (Node)nodes.get(test);
        next.add(newNode);
        break search;
      }
    }
  }

  void printConnections(){
    if(DEBUG)
      print(word+" -> ");
    for(Object tmp: next){
      Node n = (Node)tmp;
      if(DEBUG)
        print(n.word+", ");

    }
    if(DEBUG)
      println(next.size());
  }
}

void printAllConnections(){

  for(Object tmp: nodes){
    Node n = (Node)tmp;
    n.printConnections();
  }
}


void castNodes(){
  nodes = new ArrayList();
  for(Object w: words){
    String wtmp = (String)w;
    boolean has = false;

check:
    for(Object n: nodes){
      Node ntmp = (Node)n;
      if(wtmp.equals(ntmp.word)){
        has=true;
        break check;
      }
    }

    if(!has)
      nodes.add(new Node(wtmp));
  }

}

void makeConnections(){
  for(int i = 0 ; i < words.size()-1;i++){
    String current = (String)words.get(i);
    String next = (String)words.get(i+1);

    Node curr = getNode(current);
    Node nxt = getNode(next);

    curr.addConnection(nxt);

  }
}

Node getNode(String _in){
  Node out = null;
  for(Object n: nodes){
    Node tmp = (Node)n;  
    if(tmp.word.equals(_in)){
      out = tmp;
    }
  }
  return out;

}

void getWords(){


  text = loadStrings("sample.txt");
  words = new ArrayList();
  raw = "";

  for(int i = 0 ;i < text.length;i++){
    String tmp[] = splitTokens(text[i]," ");
    for(int ii = 0 ; ii < tmp.length;ii++){
      raw += tmp[ii]+" ";
      words.add(tmp[ii]+"");

    }
  }
}
public class Basnik {
  String voiceName = "alan";
  VoiceManager voiceManager;
  Voice voice; 

  Basnik(String name){
    voiceName = name;     
    this.setup(); 
  }

  void listAllVoices() {
    System.out.println();
    System.out.println("All voices available:");    
    VoiceManager voiceManager = VoiceManager.getInstance();
    Voice[] voices = voiceManager.getVoices();
    for (int i = 0; i < voices.length; i++) {
      System.out.println("    " + voices[i].getName()
          + " (" + voices[i].getDomain() + " domain)");
    }
  }

  void setup() {
    listAllVoices();
    System.out.println();
    System.out.println("Using voice: " + voiceName);

    voiceManager = VoiceManager.getInstance();
    voice = voiceManager.getVoice(voiceName); 

    voice.setPitch(2.75);
    voice.setPitchShift(0.75);
    // voice.setPitchRange(10.1); //mutace
    voice.setStyle("breathy");  //"business", "casual", "robotic", "breathy"

    if (voice == null) {
      System.err.println(
          "Cannot find a voice named "
          + voiceName + ".  Please specify a different voice.");
      System.exit(1);
    } 
    voice.allocate();
  }

  void mluv(String _a){     

    if(_a==null){
      _a= "nothing"; 
    }
    voice.speak(_a);

  }

  void exit(){
    voice.deallocate();  
  }
} 
