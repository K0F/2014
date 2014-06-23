
ArrayList fibonacci;
int num = 24;
String [] out;

void setup(){


  fibonacci = new ArrayList();

  fibonacci.add((double)0);
  fibonacci.add((double)1);

  out = new String[num];
  out[0] = "";

  int cnt = 0 ;
  
  for(int i = 2 ;i < num * 24;i++){

    double last1 = (Double)fibonacci.get(i-2);
    double last2 = (Double)fibonacci.get(i-1);

    fibonacci.add(last1+last2);
    out[cnt] += ((last1+last2)+" ");
    

    if(i%24==0){
    cnt++;
    out[cnt] = "";
    }
  }

  saveStrings("fibonacci.txt",out);


  println(out);






}



void draw(){




}


