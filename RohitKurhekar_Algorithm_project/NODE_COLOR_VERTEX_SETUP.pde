
class Colors{
  int r,g,b;
  Colors(int r , int g , int b){
    this.r = r;
    this.g = g;
    this.b = b;
  }
}

class Node{
  float x , y;
  int index;
  int component = 0;
  ArrayList<Node> nearNode = new ArrayList<Node>();
  Colors c = new Colors(0,0,0);
  Node(float x , float y , int index){
    this.x = x;
    this.y = y;
    this.index = index;
  }
}

class VertexPair{
  int index1 , index2;
  VertexPair(int index1 , int index2){
    this.index1 = index1;
    this.index2 = index2;
  }
}