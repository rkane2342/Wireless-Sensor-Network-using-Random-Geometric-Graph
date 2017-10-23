int[] findMinMax(Node []p){
  
  int []minMaxIndex = {0 , 1};
  minMaxIndex[0] = (p[0].nearNode.size() < p[1].nearNode.size()) ? 0 : 1;
  minMaxIndex[1] = (p[0].nearNode.size() >= p[1].nearNode.size()) ? 0 : 1;
  int count = 2;
  
  while(count < num){
    
    if(p[count].nearNode.size()<p[count+1].nearNode.size()){
      if(p[count].nearNode.size()<p[minMaxIndex[0]].nearNode.size()){
        minMaxIndex[0] = count;
      }
      if(p[count+1].nearNode.size()>p[minMaxIndex[1]].nearNode.size()){
        minMaxIndex[1] = count+1;
      }
    }else{
      if(p[count+1].nearNode.size()<p[minMaxIndex[0]].nearNode.size()){
        minMaxIndex[0] = count+1;
      }
      if(p[count+1].nearNode.size()>p[minMaxIndex[1]].nearNode.size()){
        minMaxIndex[1] = count;
      }
    }
    
    count = count+2;
  }

  return minMaxIndex;
}