String text[];
String raw;
ArrayList words;
ArrayList nodes;

void setup(){


  getWords();
  castNodes();
  makeConnections();
  printAllConnections();
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
      nodes.add(new Node((String)w));
  }

}

void makeConnections(){

  for(Object w: words){
    String current = (String)w;

    for(Object n: nodes){
      Node tmp = (Node)n;

      if(tmp.word.equals(current)){
        try{
          tmp.addConnection((String)words.get(words.indexOf(current)+1));
        }catch(Exception e){;}
      }
    }
  }

}
void getWords(){


  text = loadStrings("sample.txt");
  words = new ArrayList();
  raw = "";

  for(int i = 0 ;i < text.length;i++){
    String tmp[] = splitTokens(text[i],".,!()/ \t");
    for(int ii = 0 ; ii < tmp.length;ii++){
      raw += tmp[ii]+" ";
      words.add(tmp[ii]+"");

    }
  }
}

void draw(){


}


class Node{
  ArrayList next;
  ArrayList positions;
  int id;
  float weights[];
  String word;

  Node(String _word){

    next = new ArrayList();
    word = _word;

  }

  void addConnection(String _in){
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
