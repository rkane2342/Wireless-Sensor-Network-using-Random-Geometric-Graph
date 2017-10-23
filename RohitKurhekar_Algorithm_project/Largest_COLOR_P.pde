void dfs(Node p1 , int cp){
  
  Iterator it = p1.nearNode.iterator();
  while(it.hasNext()){
    Node temp = (Node)it.next();
    if(temp.component==0){  
        temp.component = cp;
        dfs(temp , cp);
    }
  }
}

int findNumOfCp(Node []bptt){
    int cc = 1;
    while(true){
       for(int i=0 ; i<bptt.length ; i++){
         if(bptt[i].component==0){
             bptt[i].component = cc;
             dfs(bptt[i] , cc);
             cc++;
         }  
       }
       
       boolean test = true;
       for(int i=0 ; i<bptt.length ; i++){
           test = test && (bptt[i].component!=0);
       }
       if(test) break;
   }
   return cc-1;
}

Node[] findLargestCp(Node []bptt , int numOfCp){
    ArrayList<Node> largestCpList = new ArrayList<Node>();
    for(int i=numOfCp ; i>0 ; i--){
        largestCpList.clear();
        for(int j=0 ; j<bptt.length ; j++){
            if(bptt[j].component == i){
                Node temp = new Node(bptt[j].x , bptt[j].y , bptt[j].index);
                temp.component = bptt[j].component;
                temp.nearNode.clear();
                largestCpList.add(temp);
            }
        }
        if(largestCpList.size()>(bptt.length)/2) break;
    }
    
    Node []largestCpArray = new Node[largestCpList.size()];
    int count=0;
    Iterator it = largestCpList.iterator();
    while(it.hasNext()){
      largestCpArray[count] = (Node)it.next();
      count++;
    }
    return largestCpArray;
}