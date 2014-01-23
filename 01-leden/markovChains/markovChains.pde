//import java.util.regex.Matcher;
//import java.util.regex.Pattern;


String text[];
String raw;
ArrayList words;
ArrayList nodes;

void setup(){


  getWords();

  castNodes2();
  printAllConnections();
}

void printAllConnections(){

  for(Object tmp: nodes){
    Node n = (Node)tmp;
    n.printConnections();
  }
}


void castNodes2(){
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

    if(!check)
      nodes.add(new Node((String)w));
  }

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
    String tmp[] = splitTokens(text[i]," \t");
    for(int ii = 0 ; ii < tmp.length;ii++){
      raw += tmp[ii]+" ";
      /*
         boolean has = false;

check:
for(int iii = 0 ; iii < words.size(); iii++){
String w = (String)words.get(iii);
if(w.equals(tmp[ii])){
has = true;
break check;
}
}

if(!has){
       */
      words.add(tmp[ii]+"");
      //  }

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
    for(Object tmp: nodes){
      Node n = (Node)tmp; 
      if(n.word.equals(_in)){
        next.add(n);
        println(word+" -> "+n.word);
      }
    }
  }

  void printConnections(){
    print(word+" -> ");
    for(Object tmp: next){
      Node n = (Node)tmp;
      print(n.word+", ");

    }
    println();
  }
}
