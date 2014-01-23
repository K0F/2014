
boolean DEBUG = false;

String text[];
String raw;
ArrayList words;
ArrayList nodes;



void setup(){

  size(480,320);

  textFont(loadFont("04b24-8.vlw"));

  getWords();
  castNodes();
  makeConnections();
  printAllConnections();
}

void draw(){

  background(0);



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
    print(word+" -> ");
    for(Object tmp: next){
      Node n = (Node)tmp;
      print(n.word+", ");

    }
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
    String tmp[] = splitTokens(text[i],"?.,!()/ \t");
    for(int ii = 0 ; ii < tmp.length;ii++){
      raw += tmp[ii]+" ";
      words.add(tmp[ii]+"");

    }
  }
}


