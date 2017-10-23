Node[] smallestLastOrdering(Map<Integer , List<Node>> a , Node[] b){
  Node []smallLastOrder = new Node[num];

  
  int i=num-1;
  while(i>=0){
    int degree = findMinKey(a);
    if(a.get(degree).size()>0){
      Node smallest = a.get(degree).get(0);    //find smallest degree vertex
      smallLastOrder[i] = smallest;

      a.get(degree).remove(smallest);
      Iterator it = smallest.nearNode.iterator();    
      while(it.hasNext()){
        Node c = (Node)it.next();
        if(c==null){
            c = (Node)it.next();
        }
        int index = b[c.index].nearNode.size();

        List<Node> pArray1 = a.get(index);
        if(pArray1==null||pArray1.isEmpty()){
            pArray1 = a.get(index);
        }
        
        pArray1.remove(c); //Tried INITIALIZING to SOLVE NULL EXCEPTION,JUST RETRY IF ERROR POPS UP,USING A HASHMAP SOMETIMES FINDS A NULL WHILE REMOVING FOR SOMEREASON
        List<Node> pArray2 = a.get(index-1);
        if(pArray2==null || pArray2.isEmpty()){
            pArray2 = a.get(index-1);
        }
        
        pArray2.add(c);
        b[c.index].nearNode.remove(smallest);
       
      }
      smallLastOrder[i].nearNode = b[smallLastOrder[i].index].nearNode;
      i--;
    }
  }
  return smallLastOrder;
}

int findMinKey(Map<Integer , List<Node>> a){
  int key = 0;
  while(a.get(key).size()==0){
    key++;
  }
  return key;
}