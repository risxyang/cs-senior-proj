// leaf class
class Leaf {
  // position of each leaf
  // each leaf has its own size, color, dimensions, falling speed, rotation.
  float posX;
  float posY;
  float rSize;  // leaf size
  float rotX = 0.0;
  float rotY = 0.0;
  float rotSpeedX;
  float rotSpeedY;
  float fallSpeed;
  float r, g, b, o;
  
  Leaf() {
    rSize = random(5,15); 
    noStroke();
    fill(204, 204); 
    
    //start position w/ random spawn 
    posX = random(0,width);
    posY = random(0,50);
    fallSpeed = random(0.5, 10);
    rotSpeedX = random(0.02, 0.1) * fallSpeed;
    rotSpeedY = random(0.02, 0.1) * fallSpeed;
    r = random(180,255);
    g = random(100,255);
    b = random(10,80);
    o = random(150,200);
    
  }

  void update() {
    //if leaf falls out of bounds, spawn it anew at top
    if (posY > height) {
      posY = 0;
      rSize = random(5,15); 
      posX = random(0,width);
    }
    
    //update rotation
    rotX += rotSpeedX;
    if(rotX > TWO_PI) { 
      rotX = 0.0; 
    }
    rotY += rotSpeedY;
    if(rotY > TWO_PI) { 
      rotY = 0.0; 
    }
    
    posY += fallSpeed;
    translate(posX, posY);
    rotateX(rotX); // U to D
    rotateY(rotY); // R to L

  }
  
  void show() {
    blendMode(ADD);
    fill(r, g, b, o);
    noStroke();
    rect(0,0, rSize*2, rSize*2);
    blendMode(NORMAL);

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
