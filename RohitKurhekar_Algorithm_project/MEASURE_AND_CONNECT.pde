
//Function used to measure distance between two points and then placeing it in ADJACENCY LIST
void measure(Node p1 , Node []p2 , float r , int index){
  
  for(int j=0 ; j<p2.length ; j++){
    
    if(j != index){
      float disX = abs(p1.x - p2[j].x)*abs(p1.x - p2[j].x);
      float disY = abs(p1.y - p2[j].y)*abs(p1.y - p2[j].y);
      float dis = sqrt(disX+disY);
      if(dis <= r){
      p1.nearNode.add(p2[j]);//Placed in ADJACENCY 
      }
    }
  }
}


//Function used to connect points given to it 
void connect(Node p){
  Iterator<Node> it = p.nearNode.iterator();
  while(it.hasNext()){
    Node p2 = it.next();
    line(p.x , p.y , p2.x , p2.y);
  }
}