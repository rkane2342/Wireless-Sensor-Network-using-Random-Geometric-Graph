import processing.video.*;

import java.util.*;

Movie introM;
int num = 1000;
int flag = 1; //SQAURE = 0 , CIRCLE = 1
float r = sqrt(float(128)/float(num));
int stage;
PFont f;

int []minMaxIndex;
Node []smallestLast = new Node[num];
Map<Integer , List<Node>> degreeList;
ArrayList<Colors> plt;
int numOfColor1 , numOfColor2 , numOfColor3 , numOfColor4 , numOfColor5 , numOfColor6;

Node []p = new Node[num];
Node []p2 = new Node[num];
Node []pOfColor1;
Node []pOfColor2;
Node []pOfColor3;
Node []pOfColor4;
Node []pOfColor5;
Node []pOfColor6;

Node []b12;
Node []b13;
Node []b14;
Node []b23;
Node []b24;
Node []b34;


Node [] bB12;
Node [] bB13;
Node [] bB14;
Node [] bB23;
Node [] bB24;
Node [] bB34;

void setup(){
  stage = 1;
  size(1000 , 800);
  background(#000000);
  f = createFont("Arial",16,true);
  introM = new Movie(this, "intro.mov");
  introM.loop();
  plt = new ArrayList<Colors>();
  plt.add(new Colors(int(random(100,255)),int(random(100,255)),int(random(100,255))));
  numOfColor1 = 0;
  numOfColor2 = 0;
  numOfColor3 = 0;
  numOfColor4 = 0;
  numOfColor5 = 0;
  numOfColor6 = 0;
  
// FLAG DECIDING SQUARE/CIRCLE
  switch (flag){
    case 0:
      for(int i1=0 ; i1< num ; i1++){
        p[i1] = new Node(random(0,1) , random(0,1) , i1);
        p2[i1] = new Node(random(0,1) , random(0,1) , i1);
      }
      break;
     
     case 1:
       for(int i2=0 ; i2<num ; i2++){
         float r = random(0 , 1);
         float theta = random(0 , 2*PI);
         float x = sqrt(r)*cos(theta);
         float y = sqrt(r)*sin(theta);
         p[i2] = new Node(x , y , i2);
         p2[i2] = new Node(x , y , i2);
       }
       break;
  }
  
  for(int i3=0 ; i3<num ; i3++){
    measure(p[i3] , p , r , i3);
    measure(p2[i3] , p , r , i3);
  }
  println("Measure has done");
  
  
  minMaxIndex = findMinMax(p);
  println("Min: "+ p[minMaxIndex[0]].nearNode.size()+" Max: " +p[minMaxIndex[1]].nearNode.size());
  degreeList = setDegreeList(p , minMaxIndex[1]);
  println("Set list have done");
  List<Node> l = degreeList.get(p[minMaxIndex[0]].nearNode.size());
  Iterator it = l.iterator();
  while(it.hasNext()){
    Node p = (Node)it.next();
    println("X: "+p.x+"  "+"Y: "+p.y+"  "+"Index: "+p.index);
  }
   smallestLast = smallestLastOrdering(degreeList , p);
   paint(smallestLast);
   println("There are total "+plt.size()+" kind of color being used");
   for(int i=0 ; i<num ; i++){
     if(smallestLast[i].c == plt.get(0)){
       numOfColor1++;
     }
   }
   for(int i=0 ; i<num ; i++){
     if(smallestLast[i].c == plt.get(1)){
       numOfColor2++;
     }
   }
   for(int i=0 ; i<num ; i++){
     if(smallestLast[i].c == plt.get(2)){
       numOfColor3++;
     }
   }
   for(int i=0 ; i<num ; i++){
     if(smallestLast[i].c == plt.get(3)){
       numOfColor4++;
     }
   }
   
   println("Number of color1 = "+numOfColor1+" ; color2 = "+numOfColor2+" ; color3 = "+numOfColor3+" ; color4 = "+numOfColor4);
   pOfColor1 = new Node[numOfColor1];
   pOfColor2 = new Node[numOfColor2];
   pOfColor3 = new Node[numOfColor3];
   pOfColor4 = new Node[numOfColor4];
   
   //no. of colored nodes all 4 of them
   int countOfColor1 = 0;
   for(int i=0 ; i<num ; i++){
     if(smallestLast[i].c == plt.get(0)){
       pOfColor1[countOfColor1] = smallestLast[i];
       pOfColor1[countOfColor1].nearNode.clear();
       countOfColor1++;
     }
   }
   int countOfColor2 = 0;
   for(int i=0 ; i<num ; i++){
     if(smallestLast[i].c == plt.get(1)){
       pOfColor2[countOfColor2] = smallestLast[i];
       pOfColor2[countOfColor2].nearNode.clear();
       countOfColor2++;
     }
   }
   int countOfColor3 = 0;
   for(int i=0 ; i<num ; i++){
     if(smallestLast[i].c == plt.get(2)){
       pOfColor3[countOfColor3] = smallestLast[i];
       pOfColor3[countOfColor3].nearNode.clear();
       countOfColor3++;
     }
   }
   int countOfColor4 = 0;
   for(int i=0 ; i<num ; i++){
     if(smallestLast[i].c == plt.get(3)){
       pOfColor4[countOfColor4] = smallestLast[i];
       pOfColor4[countOfColor4].nearNode.clear();
       countOfColor4++;
     }
   }
   
//BACKBONE PAIRS 12
   b12 = mergeArray(pOfColor1 , pOfColor2);
   for(int i=0 ; i<b12.length ; i++){
     measure(b12[i] , b12 , r , i);
   }
   int edgeOfB12 = calcEdge(b12);
   println("Bipartite 1-2 has "+edgeOfB12+"edges");
   int numOfb12 = findNumOfCp(b12);
   println("b12 after findNumOfCp");
   bB12 = findLargestCp(b12 , numOfb12);
   println("b12 after findLargestCp");
   for(int i=0 ; i<bB12.length ; i++){
     measure(bB12[i] , bB12 , r , i);
   }
   println("bB12 has "+calcFace(bB12)+" faces");
   
//BACKBONE PAIRS 13   

   b13 = mergeArray(pOfColor1 , pOfColor3);
   for(int i=0 ; i<b13.length ; i++){
     measure(b13[i] , b13 , r , i);
   }
   int edgeOfB13 = calcEdge(b13);
   println("Bipartite 1-3 has "+edgeOfB13+"edges");
   int numOfb13 = findNumOfCp(b13);
   println("b13 after findNumOfCp");
   bB13 = findLargestCp(b13 , numOfb13);
   println("b13 after findLargestCp");
   for(int i=0 ; i<bB13.length ; i++){
     measure(bB13[i] , bB13 , r , i);
   }
   println("bB13 has "+calcFace(bB13)+" faces");
   
//BACKBONE PAIRS 14   
   

   b14 = new Node[numOfColor1+numOfColor4];
   b14 = mergeArray(pOfColor1 , pOfColor4);
   for(int i=0 ; i<b14.length ; i++){
     measure(b14[i] , b14 , r , i);
   }
   int edgeOfB14 = calcEdge(b14);
   println("Bipartite 1-4 has "+edgeOfB14+"edges");
   int numOfb14 = findNumOfCp(b14);
   println("b14 after findNumOfCp");
   bB14 = findLargestCp(b14 , numOfb14);
   println("b14 after findLargestCp");
   for(int i=0 ; i<bB14.length ; i++){
     measure(bB14[i] , bB14 , r , i);
   }
   println("bB14 has "+calcFace(bB14)+" faces");
   
//BACKBONE PAIRS 23   
   
   b23 = new Node[numOfColor2+numOfColor3];
   b23 = mergeArray(pOfColor2 , pOfColor3);
   for(int i=0 ; i<b23.length ; i++){
     measure(b23[i] , b23 , r , i);
   }
   int edgeOfB23 = calcEdge(b23);
   println("Bipartite 2-3 has "+edgeOfB23+"edges");
   int numOfb23 = findNumOfCp(b23);
   bB23 = findLargestCp(b23 , numOfb23);
   for(int i=0 ; i<bB23.length ; i++){
     measure(bB23[i] , bB23 , r , i);
   }
   println("bB23 has "+calcFace(bB23)+" faces");
   
   
//BACKBONE PAIRS 24 
   b24 = new Node[numOfColor2+numOfColor4];
   b24 = mergeArray(pOfColor2 , pOfColor4);
   for(int i=0 ; i<b24.length ; i++){
     measure(b24[i] , b24 , r , i);
   }
   int edgeOfB24 = calcEdge(b24);
   println("Bipartite 2-4 has "+edgeOfB24+"edges");
   int numOfb24 = findNumOfCp(b24);
   bB24 = findLargestCp(b24 , numOfb24);
   for(int i=0 ; i<bB24.length ; i++){
     measure(bB24[i] , bB24 , r , i);
   }
   println("bB24 has "+calcFace(bB24)+" faces");
   
   
//BACKBONE PAIRS 34  
   b34 = new Node[numOfColor3+numOfColor4];
   b34 = mergeArray(pOfColor3 , pOfColor4);
   for(int i=0 ; i<b34.length ; i++){
     measure(b34[i] , b34 , r , i);
   }
   int edgeOfB34 = calcEdge(b34);
   println("Bipartite 3-4 has "+edgeOfB34+"edges");
   int numOfb34 = findNumOfCp(b34);
   bB34 = findLargestCp(b34 , numOfb34);
   for(int i=0 ; i<bB34.length ; i++){
     measure(bB34[i] , bB34 , r , i);
   }
   println("bB34 has "+calcFace(bB34)+" faces");
   println("Largest component finding complete");
}


void draw(){
  if (stage == 1) {
  textFont(f);       
  fill(255);
  textAlign(CENTER);
  text("PRESS ANY KEY TO CONTINUE.",width/2,650);
  image(introM,25,100,950,500);
  if(keyPressed == true){
  background(#000000);  
  stage=2;}
  }
  if (stage==2){
  textFont(f);       
  fill(255);
  textAlign(CENTER);
  text("MENU",width/2,100);
  textAlign(LEFT);
  text("COMPLETE GRAPH===================>   PRESS 1",50,200);
  text("MIN-MAX 2 GRAPHS=================>   PRESS 2",50,300);
  text("COLORED POINTS 4 PLOTS===========>   PRESS 3",50,400);
  text("BIPARTITE GRAPHS 6 PLOTS=========>   PRESS 4",50,500);
  text("BACKBONE GRAPHS 6 PLOTS==========>   PRESS 5",50,600);
  text("EXPERIMENTAL MULIPLE PLOTS==========>   PRESS 6",50,700);
  }
  if (stage==3){
    textFont(f);       
  fill(255);
  textAlign(CENTER);
  text("COMPLETE GRAPH",width/2,30);
  text("PRESS Q FOR NODES AND W COMPLETE GRAPH",width/2,50);  
  text("C: CLEAR             B:BACK TO MENU",width/2,750);
  }
  if (stage==4){
    textFont(f);       
  fill(255);
  textAlign(CENTER);
  text("MIN/MAX",width/2,30);
  text("PRESS",width/2,50);  
  text("Q FOR MIN :: W FOR MAX :: E WITH COMPLETE GRAPH",width/2,70);
  text("C: CLEAR             B:BACK TO MENU",width/2,750);
  }
  if (stage==5){
    textFont(f);       
  fill(255);
  textAlign(CENTER);
  text("COLORED NODES",width/2,30);
  text("PRESS",width/2,50);  
  text("Q W E R fOR THE FOUR GRAPHS",width/2,70);  
  text("C: CLEAR             B:BACK TO MENU",width/2,750);
  }
  if (stage==6){
    textFont(f);       
  fill(255);
  textAlign(CENTER);
  text("BIPARTITES",width/2,30);
  text("PRESS",width/2,50);  
  text("Q W E R T Y FOR THE 6 GRAPHS",width/2,70); 
  text("C: CLEAR             B:BACK TO MENU",width/2,750);
  }
  if (stage==7){
    textFont(f);       
  fill(255);
  textAlign(CENTER);
  text("BACKBONES",width/2,30);
  text("PRESS",width/2,50);  
  text("Q W E R T Y FOR THE 6 GRAPHS",width/2,70);  
  text("C: CLEAR             B:BACK TO MENU",width/2,750);
  }
    if (stage==8){
    textFont(f);       
  fill(255);
  textAlign(CENTER);
  text("TESTING PAGE WITH MULIPLE OUTPUTS",width/2,30);
  text("PRESS QWER for COLORS",width/2,50);  
  text("ASDFGH FOR BIPARTI AND JKL;OP FOR BACKBONES",width/2,70);  
  text("C: CLEAR             B:BACK TO MENU",width/2,750);
  }
}

void keyPressed(){
  
  if (stage == 2){
    if(key == '1'){
  background(#000000);  
  stage=3;}
  if(key == '2'){
  background(#000000);  
  stage=4;}
  if(key == '3'){
  background(#000000);  
  stage=5;}
  if(key == '4'){
  background(#000000);  
  stage=6;}
  if(key == '5'){
  background(#000000);  
  stage=7;}
  if(key == '6'){
  background(#000000);  
  stage=8;}
  }
  if (stage == 3) {
    if(key == 'q'){
        stroke(#FA761E);
        strokeWeight(0.005);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<num ; j1++){
               point(p2[j1].x , p2[j1].y);
        } 

    
    }
        if(key == 'w'){
        stroke(#FA761E);
        strokeWeight(0.005);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<num ; j1++){
               point(p2[j1].x , p2[j1].y);
        } 

        stroke(#FFF829);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<num ; j2++){
          connect(p2[j2]);
        }
    
    }
  }
  if (stage == 4) {
    if(key == 'q'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<num ; j1++){
               point(p2[j1].x , p2[j1].y);
        } 
      
        stroke(0);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<num ; j2++){
          connect(p2[j2]);
        }
        stroke(#FF0000);
        strokeWeight(0.003);
        connect(p2[minMaxIndex[0]]);
        }
    if(key == 'w'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<num ; j1++){
               point(p2[j1].x , p2[j1].y);
        } 
      
        stroke(0);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<num ; j2++){
          connect(p2[j2]);
        }
        stroke(#FF0000);
        strokeWeight(0.003);
        connect(p2[minMaxIndex[1]]);
    }
    if(key == 'e'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<num ; j1++){
               point(p2[j1].x , p2[j1].y);
        } 
      
        stroke(#FFF829);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<num ; j2++){
          connect(p2[j2]);
        }
        stroke(#FF0000);
        strokeWeight(0.003);
        connect(p2[minMaxIndex[0]]);
        connect(p2[minMaxIndex[1]]);
    }
  }
  if (stage == 5) {  
    if(key == 'q'){
      stroke(color(plt.get(0).r,plt.get(0).g,plt.get(0).b));
      strokeWeight(0.008);
      if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
      
      for(int j1=0 ; j1<numOfColor1 ; j1++){
             point(pOfColor1[j1].x , pOfColor1[j1].y);
      } 
    }
    
    if(key == 'w'){
      stroke(color(plt.get(1).r,plt.get(1).g,plt.get(1).b));
      strokeWeight(0.008);
      if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
      
      for(int j1=0 ; j1<numOfColor2 ; j1++){
             point(pOfColor2[j1].x , pOfColor2[j1].y);
      } 
    }
    if(key == 'e'){
      stroke(color(plt.get(2).r,plt.get(2).g,plt.get(2).b));
      strokeWeight(0.008);
      if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
      
      for(int j1=0 ; j1<numOfColor3 ; j1++){
             point(pOfColor3[j1].x , pOfColor3[j1].y);
      } 
    }
    if(key == 'r'){
      stroke(color(plt.get(3).r,plt.get(3).g,plt.get(3).b));
      strokeWeight(0.008);
      if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
      
      for(int j1=0 ; j1<numOfColor4 ; j1++){
             point(pOfColor4[j1].x , pOfColor4[j1].y);
      } 
    }
  }
  if (stage == 6) { 
    if(key == 'q'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<b12.length ; j1++){
               point(b12[j1].x , b12[j1].y);
        } 
      
        stroke(#FFFFFF);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<b12.length ; j2++){
          connect(b12[j2]);
        }
    }
    if(key == 'w'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<b13.length ; j1++){
               point(b13[j1].x , b13[j1].y);
        } 
      
        stroke(#FFFFFF);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<b13.length ; j2++){
          connect(b13[j2]);
        }
    }
    if(key == 'e'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<b14.length ; j1++){
               point(b14[j1].x , b14[j1].y);
        } 
      
        stroke(#FFFFFF);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<b14.length ; j2++){
          connect(b14[j2]);
        }
    }
    
    if(key == 'r'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<b23.length ; j1++){
               point(b23[j1].x , b23[j1].y);
        } 
      
        stroke(#FFFFFF);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<b23.length ; j2++){
          connect(b23[j2]);
        }
    }
    if(key == 't'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<b24.length ; j1++){
               point(b24[j1].x , b24[j1].y);
        } 
      
        stroke(#FFFFFF);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<b24.length ; j2++){
          connect(b24[j2]);
        }
    }
  
    if(key == 'y'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<b34.length ; j1++){
               point(b34[j1].x , b34[j1].y);
        } 
      
        stroke(#FFFFFF);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<b34.length ; j2++){
          connect(b34[j2]);
        }
    }
  } 
  
  if (stage == 7){
    if(key == 'q'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<bB12.length ; j1++){
               point(bB12[j1].x , bB12[j1].y);
        } 
      
        stroke(#FF0000);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<bB12.length ; j2++){
          connect(bB12[j2]);
        }
    }
    
    if(key == 'w'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<bB13.length ; j1++){
               point(bB13[j1].x , bB13[j1].y);
        } 
      
        stroke(#FF0000);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<bB13.length ; j2++){
          connect(bB13[j2]);
        }
    }
    
    if(key == 'e'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<bB14.length ; j1++){
               point(bB14[j1].x , bB14[j1].y);
        } 
      
        stroke(#FF0000);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<bB14.length ; j2++){
          connect(bB14[j2]);
        }
    }
    
    if(key == 'r'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<bB23.length ; j1++){
               point(bB23[j1].x , bB23[j1].y);
        } 
      
        stroke(#FF0000);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<bB23.length ; j2++){
          connect(bB23[j2]);
        }
    }
    
    if(key == 't'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<bB24.length ; j1++){
               point(bB24[j1].x , bB24[j1].y);
        } 
      
        stroke(#FF0000);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<bB24.length ; j2++){
          connect(bB24[j2]);
        }
    }
    
    if(key == 'y'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<bB34.length ; j1++){
               point(bB34[j1].x , bB34[j1].y);
        } 
      
        stroke(#FF0000);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<bB34.length ; j2++){
          connect(bB34[j2]);
        }
    }
  } 
  if (stage == 8){
    if(key == 'q'){
      stroke(color(plt.get(0).r,plt.get(0).g,plt.get(0).b));
      strokeWeight(0.01);
      if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
      
      for(int j1=0 ; j1<numOfColor1 ; j1++){
             point(pOfColor1[j1].x , pOfColor1[j1].y);
      } 
    }
    
    if(key == 'w'){
      stroke(color(plt.get(1).r,plt.get(1).g,plt.get(1).b));
      strokeWeight(0.01);
      if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
      
      for(int j1=0 ; j1<numOfColor2 ; j1++){
             point(pOfColor2[j1].x , pOfColor2[j1].y);
      } 
    }
    if(key == 'e'){
      stroke(color(plt.get(2).r,plt.get(2).g,plt.get(2).b));
      strokeWeight(0.01);
      if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
      
      for(int j1=0 ; j1<numOfColor3 ; j1++){
             point(pOfColor3[j1].x , pOfColor3[j1].y);
      } 
    }
    if(key == 'r'){
      stroke(color(plt.get(3).r,plt.get(3).g,plt.get(3).b));
      strokeWeight(0.01);
      if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
      
      for(int j1=0 ; j1<numOfColor4 ; j1++){
             point(pOfColor4[j1].x , pOfColor4[j1].y);
      } 
    }
    if(key == 'a'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<b12.length ; j1++){
               point(b12[j1].x , b12[j1].y);
        } 
      
        stroke(#FFFFFF);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<b12.length ; j2++){
          connect(b12[j2]);
        }
    }
    if(key == 's'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<b13.length ; j1++){
               point(b13[j1].x , b13[j1].y);
        } 
      
        stroke(#FFFFFF);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<b13.length ; j2++){
          connect(b13[j2]);
        }
    }
    if(key == 'd'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<b14.length ; j1++){
               point(b14[j1].x , b14[j1].y);
        } 
      
        stroke(#FFFFFF);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<b14.length ; j2++){
          connect(b14[j2]);
        }
    }
    
    if(key == 'f'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<b23.length ; j1++){
               point(b23[j1].x , b23[j1].y);
        } 
      
        stroke(#FFFFFF);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<b23.length ; j2++){
          connect(b23[j2]);
        }
    }
    if(key == 'g'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<b24.length ; j1++){
               point(b24[j1].x , b24[j1].y);
        } 
      
        stroke(#FFFFFF);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<b24.length ; j2++){
          connect(b24[j2]);
        }
    }
  
    if(key == 'h'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<b34.length ; j1++){
               point(b34[j1].x , b34[j1].y);
        } 
      
        stroke(#FFFFFF);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<b34.length ; j2++){
          connect(b34[j2]);
        }
    }
        if(key == 'j'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<bB12.length ; j1++){
               point(bB12[j1].x , bB12[j1].y);
        } 
      
        stroke(#FF0000);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<bB12.length ; j2++){
          connect(bB12[j2]);
        }
    }
    
    if(key == 'k'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<bB13.length ; j1++){
               point(bB13[j1].x , bB13[j1].y);
        } 
      
        stroke(#FF0000);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<bB13.length ; j2++){
          connect(bB13[j2]);
        }
    }
    
    if(key == 'l'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<bB14.length ; j1++){
               point(bB14[j1].x , bB14[j1].y);
        } 
      
        stroke(#FF0000);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<bB14.length ; j2++){
          connect(bB14[j2]);
        }
    }
    
    if(key == ';'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<bB23.length ; j1++){
               point(bB23[j1].x , bB23[j1].y);
        } 
      
        stroke(#FF0000);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<bB23.length ; j2++){
          connect(bB23[j2]);
        }
    }
    
    if(key == 'o'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<bB24.length ; j1++){
               point(bB24[j1].x , bB24[j1].y);
        } 
      
        stroke(#FF0000);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<bB24.length ; j2++){
          connect(bB24[j2]);
        }
    }
    
    if(key == 'p'){
        stroke(#FFFFFF);
        strokeWeight(0.0001);
        if(flag==1){
          translate(width/2 , height/2);
          scale(300);
        }else{
          translate(width/4 , height/4);
          scale(400);
        }
        
        for(int j1=0 ; j1<bB34.length ; j1++){
               point(bB34[j1].x , bB34[j1].y);
        } 
      
        stroke(#FF0000);
        strokeWeight(0.000001);
        for(int j2=0 ; j2<bB34.length ; j2++){
          connect(bB34[j2]);
        }
    }
  }
    if(key == 'c'){
      clear();
    }
  if(key == 'b'){
      stage = 2;
      background(#000000);
      textFont(f);       
      fill(255);
      textAlign(CENTER);
      text("MENU",width/2,100);
      textAlign(LEFT);
      text("COMPLETE GRAPH===================>   PRESS 1",50,200);
      text("MIN-MAX 2 GRAPHS=================>   PRESS 2",50,300);
      text("COLORED POINTS 4 PLOTS===========>   PRESS 3",50,400);
      text("BIPARTITE GRAPHS 6 PLOTS=========>   PRESS 4",50,500);
      text("BACKBONE GRAPHS 6 PLOTS==========>   PRESS 5",50,600);
      text("EXPERIMENTAL MULIPLE PLOTS==========>   PRESS 6",50,700);
    }
}


void movieEvent(Movie introM){
  introM.read();
}