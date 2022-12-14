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
  float r, g, b, o, w, h;
  int l_spawn_bound, r_spawn_bound, t_spawn_bound, b_stop_bound; //spawn position
  Mode particle_mode;
  
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
    posY = random(t_spawn_bound,height);
     
    switch (mode) {
      case RAIN:
        init_rain();
        particle_mode = Mode.RAIN;
        break;
      case LEAVES:
       init_leaf();
       particle_mode = Mode.LEAVES;
        break;
      case SNOW:
      particle_mode = Mode.SNOW;
        break;
    }
   
    
  }
  
  void init_rain() {
    fallSpeed = random(30, 40);
        rotSpeedX = 0;
        rotSpeedY = 0;
        float c = random(200,255);
        r=g=b=c;
        w=random(sq_width-2, sq_width+2);
        h=random(10*sq_width, 30*sq_width);
        o = random(40,80);
  }
  
  void init_snow() {
        fallSpeed = random(10, 20);
        rotSpeedX = random(0.02, 0.1);
        rotSpeedY = random(0.02, 0.1);
        float c = random(200,255);
        r=g=b=c;
        w=h=random(sq_width-2, sq_width+2);
        o = random(80,120);
  }
  
  void init_leaf() {
       fallSpeed = random(0.5, 10);
        rotSpeedX = random(0.02, 0.1) * fallSpeed;
        rotSpeedY = random(0.02, 0.1) * fallSpeed;
        r = random(180,255);
        g = random(100,255);
        b = random(10,80);
        o = random(150,200);
        w=h=rSize;
  }
  

  void update() {
    //if particle falls out of bounds, spawn it anew at top
    if (posY > b_stop_bound) {
      posY = random(-200, t_spawn_bound);
      rSize = random(sq_width-2,sq_width+2); 
      posX = random(l_spawn_bound,r_spawn_bound);
    }
    
    //sometimes rain falls up
    posY = max(posY, -100);
    
    
     switch (mode) {
      case RAIN:
        if(particle_mode != Mode.RAIN) {
          init_rain();
          particle_mode = Mode.RAIN;
        }
        w=random(sq_width-2, sq_width+2);
        h=random(10*sq_width, 30*sq_width);
        posY += fallSpeed;
        if(output_state == 0) {
            if(random(0,10)< 1) {
                o = max((int)random(40,60), o+0.5);
            }
        }
        else if (output_state == 1) {
            if(random(0,10)< 1) {
                o -= 20;
            }
        }
        else if (output_state == 6) {
            fallSpeed += 0.5;
        }
        else if (output_state == 7) {
            fallSpeed -= 0.5;
        }
        translate(posX, posY);
        break;
      case LEAVES:
      if(particle_mode != Mode.LEAVES) {
          init_leaf();
          particle_mode = Mode.LEAVES;
        }
         w=h=random(sq_width-2, sq_width+2);
        //update rotation
        rotSpeedX *= ((100.0-10*time_elapsed)/500.0);
        rotSpeedY *= ((100.0-10*time_elapsed)/300.0);
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
        break;
      case SNOW:
        if(particle_mode != Mode.SNOW) {
          init_snow();
          particle_mode = Mode.SNOW;
        }
        //rotX += rotSpeedX;
        //if(rotX > TWO_PI) { 
        //  rotX = 0.0; 
        //}
        //rotY += rotSpeedY;
        //if(rotY > TWO_PI) { 
        //  rotY = 0.0; 
        //}
        posY += fallSpeed;
        translate(posX, posY);
        rotateX(rotX); // U to D
        rotateY(rotY); // R to L
        break;
    }
    
    

  }
  
  void show() {
    blendMode(ADD);
    //(100.0-10*time_elapsed)/100.0)
    fill(r, g, b, o*((100.0-10*(time_elapsed+1))/100.0));
    noStroke();
    rect(0,0, w, h);
    blendMode(NORMAL);

  }
  
 
  
  //void keyPressed() {
  // time_elapsed+=1;
  //}
}
