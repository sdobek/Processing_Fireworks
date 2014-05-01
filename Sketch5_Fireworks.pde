ArrayList rList;
ArrayList wList;

void setup(){
  size(800, 600);
  rList = new ArrayList();
  wList = new ArrayList();
  noStroke();
}

void draw(){
  background(0);
  fill(255);
  float newR = random(0, 32);
  if (newR > 31){ 
    Rocket r = new Rocket(random(20, width-20), height*.75, 20, random(-20, 20), 
                            random(-1, 1), random(-5, -8));
    rList.add(r);
  }
 
  for (int i = 0; i < rList.size(); i++){
    Rocket r1 = (Rocket)rList.get(i);
    if (r1.dy < -1){
      r1.update();
      r1.display();
    }
    else if (r1.dy <= 0 && r1.dy >= -.5){
      float rx = r1.x;
      float ry = r1.y;
      rList.remove(r1);
      float vX, vY;
       float rd, grn, bl;
       rd = random(100, 255);
       grn = random(100, 255);
       bl = random(100, 255);
       float angle;
       for (int j = 0; j < 500; j++){
           angle=random(0, 2*PI);
           vX = random(1, 10)*cos(angle);
           vY = random(1, 10)*sin(angle);
           Work w = new Work(rx, ry, vX, vY,rd, grn, bl);
           wList.add(w); 
       }
      
    }
    else{
      r1.update2();
      r1.display2();
    }
  }
  
  for (int j = 0; j < wList.size(); j++){
     Work w = (Work)wList.get(j);
     if (w.trans <= 4){
        wList.remove(w);
     }
     else {
       w.update();
       w.display();
     }    
  }
  
}

class Rocket{
  float x,y,r;
  float theta;
  float dx,dy;
  ArrayList sList;
  
  Rocket(float x, float y, float r, float t, float dx, float dy){
    this.x = x;
    this.y = y;
    this.r = r;
    theta = t;
    this.dx = dx;
    this.dy = dy;
     sList = new ArrayList();
  }
  
  void update(){
     x+= dx;
     y+= dy;
     dy *= .98;
     Spark s = new Spark(0, r/2, 255, random(-10, 10));
     sList.add(s);
     
  }
  
  void update2(){
     x+= dx;
     y+= dy;
     dy *= .99;     
     dx *= .9;
  }
  
  void display(){
    fill(255);
    pushMatrix();
    translate(x, y);
    rotate(radians(theta)); //rotate clockwise;
    ellipse(0, 0, r, r);
    //popMatrix();
    
    if (dy != 0){
     for (int i = 0; i < sList.size(); i++){
       Spark s1 = (Spark)sList.get(i);
       if (s1.trans >= 0){
         s1.update();
         s1.display();
       }
       else{
         sList.remove(s1);
         
       }
     } 
    }
    popMatrix();
  }
  
  void display2(){
    fill(255);
    pushMatrix();
    translate(x, y);
    rotate(radians(theta)); //rotate clockwise;
    ellipse(0, 0, r, r);
    //popMatrix();
    
    if (dy != 0){
     for (int i = 0; i < sList.size(); i++){
        Spark s1 = (Spark)sList.get(i);
        sList.remove(s1);
     } 
    popMatrix();
  }
  }
  
}

class Spark{
  float x, y;
  float trans;
  float theta;
  
  Spark(float x, float y, float trans, float theta){
    this.x = x;
    this.y = y;
    this.trans = trans;
    this.theta = theta;
  }
  
  void update(){
    trans *= .995;
    y += 6;
  }
  
  void display(){
    fill(255, 25, 25, trans);
    pushMatrix();
    rotate(radians(theta));
    translate(x, y);
    //rotate(radians(theta));
    ellipse(0,0,4,4);
    popMatrix();
  }
  
}

class Work{
  float x, y;
  float dx, dy;
  float rd, grn, bl;
  float trans;

  Work(float x, float y, float dx, float dy, float rd, float grn, float bl){
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
    this.rd = rd;
    this.grn = grn;
    this.bl = bl;
    trans = 255;
  }  
  
  void update(){
    x+=dx;
    y+=dy;
    dy*=.98;
    trans*=.95;
  }
  
  void display(){
    fill(rd, grn, bl, trans);
    pushMatrix();
    translate(x, y);
    ellipse(0, 0, 5, 5);
    popMatrix();
  } 
  
}
