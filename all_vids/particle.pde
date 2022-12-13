// particle class
class Particle {
  // position of each particle
  // each particle has its own size, color, dimensions, falling speed, rotation.
  float posX;
  float posY;
  float rSize;  // leaf size
  float rotX = 0.0;
  float rotY = 0.0;
  float rotSpeedX;
  float rotSpeedY;
  float fallSpeed;
  float r, g, b, o;
  int l_spawn_bound, r_spawn_bound, t_spawn_bound, b_stop_bound; //spawn position
  
  Particle(int l_bound, int r_bound, int t_bound, int b_bound) {
    rSize = random(sq_width-2,sq_width+2); 
    noStroke();
    fill(204, 204); 
    
    //start position w/ random spawn 
    l_spawn_bound = l_bound;
    r_spawn_bound = r_bound;
    t_spawn_bound = t_bound;
    b_stop_bound = b_bound;
    posX = random(l_spawn_bound, r_spawn_bound);
    posY = random(t_spawn_bound,50);
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
    if (posY > b_stop_bound) {
      posY = 0;
      rSize = random(sq_width-2,sq_width+2); 
      posX = random(l_spawn_bound,r_spawn_bound);
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

  }
  
  //void keyPressed() {
  // any behavior if you want 
  //}
}
