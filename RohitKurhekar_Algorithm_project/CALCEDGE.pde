
Node [] mergeArray(Node []p1 , Node []p2){
  Node []mArray = new Node[p1.length+p2.length];
  for(int i=0 ; i<p1.length ; i++){
    mArray[i] = new Node(p1[i].x , p1[i].y , p1[i].index);
    mArray[i].c.r = p1[i].c.r;
    mArray[i].c.g = p1[i].c.g;
    mArray[i].c.b = p1[i].c.b;
    mArray[i].nearNode.clear();
  }
  for(int i=0 ; i<p2.length ; i++){
    mArray[p1.length+i] = new Node(p2[i].x , p2[i].y , p2[i].index);
    mArray[p1.length+i].c.r = p2[i].c.r;
    mArray[p1.length+i].c.g = p2[i].c.g;
    mArray[p1.length+i].c.b = p2[i].c.b;
    mArray[p1.length+i].nearNode.clear();
  }
  return mArray;
}

int calcEdge(Node []bB){
  int edg = 0;
  List<VertexPair> vertexPair = new ArrayList<VertexPair>();
  for(int i=0 ; i<bB.length ; i++){
    Iterator it = bB[i].nearNode.iterator();
    while(it.hasNext()){
      Node temp = (Node)it.next();
      VertexPair pair = new VertexPair(bB[i].index , temp.index);
      if(vertexPair.size()==0){
        vertexPair.add(pair);
      }else{
        int flag = 0;
        for(int j=0 ; j<vertexPair.size() ; j++){
          boolean test = (vertexPair.get(j).index1==pair.index1 && vertexPair.get(j).index2==pair.index2) || (vertexPair.get(j).index1==pair.index2 && vertexPair.get(j).index2==pair.index1);
          if(test){
            flag = 1;
            break;
          }
        }
        
        if(flag == 0){
          vertexPair.add(pair);
        }
      }  
    }  
  }   
  edg = vertexPair.size();
  return edg;  
}


int calcFace(Node []bB){
  int vertex = bB.length;
  int edge   = calcEdge(bB);
  int face   = 2-vertex+edge;
  return face;
}