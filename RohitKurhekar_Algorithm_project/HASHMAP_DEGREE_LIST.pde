Map<Integer , List<Node>> setDegreeList(Node []point , int max){
 
  Map<Integer , List<Node>> degreeList = new HashMap<Integer , List<Node>>();
  for(int j=0 ; j<=point[max].nearNode.size() ; j++){
      ArrayList<Node> degree = new ArrayList<Node>();
      for(int i=0 ; i<num ; i++){
        if(point[i].nearNode.size() == j){
          degree.add(point[i]);
        }
      }
      degreeList.put(j , degree);
    }
    return degreeList;
}