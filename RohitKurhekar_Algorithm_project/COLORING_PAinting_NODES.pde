void paint(Node []p1){
  
  for(int i=0 ; i<num ; i++){
    int flag = 0;
    if(p1[i].nearNode.size()==0 || i==0){
       p1[i].c = plt.get(0);
    }else{
        ArrayList<Colors> nearColor = new ArrayList<Colors>();
        Iterator it = p1[i].nearNode.iterator();
        while(it.hasNext()){
          Node nearNode = (Node)it.next();
          nearColor.add(nearNode.c);
        }
        for(int j=0 ; j<plt.size() ; j++){
          boolean b = false;
          Iterator it2 = nearColor.iterator();
          while(it2.hasNext()){
             Colors nc = (Colors)it2.next();
             b = b || (nc.r==plt.get(j).r&&nc.g==plt.get(j).g&&nc.b==plt.get(j).b);
          }
          if(!b){
            p1[i].c = plt.get(j);
            flag = 1;
            break;
          }
        }
        if(flag == 0){
          Colors temp = insertColor();
          p1[i].c = temp;
          plt.add(temp);
        }
    }
  }
}

Colors insertColor(){
  Colors c;
  while(true){
    c = new Colors(int(random(100,255)),int(random(100,255)),int(random(100,255)));
    boolean test = plt.contains(c);
    if(!test){
      break;
    }
  }
  return c;
}