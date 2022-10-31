// leaf class
class Leaf {
  // position of each leaf
  float x;
  float y;
  float rSize;  // rectangle size
  float a = 0.0;
  
  Leaf() {
    x = random(-displayWidth / 2, displayWidth / 2);
    y = random(-displayHeight / 2, displayHeight / 2);
    rSize = width / 20;  
    noStroke();
    fill(204, 204);
  }

  void update() {
    // TODO - if out of bounds, do something
    a += 0.005;
    if(a > TWO_PI) { 
      a = 0.0; 
    }
    
    translate(width/2, height/2);
    
    rotateX(a);
    rotateY(a * 2.0);
    fill(255);
    rect(x, y, rSize*2, rSize*2);

  }
  
  void show() {
    fill(255);
    noStroke();

    // get the new leaf position

    //float sx = x - changeX;
    //float sy = y - changeY;
    //rect(sx, sy, random(1,3), random(1,3));
    //x = sx;
    //y = sy;

  }
  
  //void keyPressed() {
  // any behavior if you want 
  //}
}
