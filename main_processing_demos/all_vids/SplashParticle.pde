// A simple Particle class
//from https://processing.org/examples/simpleparticlesystem.html

class SplashParticle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  SplashParticle(PVector l) {
    acceleration = new PVector(0, random(-0.04, 0.04));
    velocity = new PVector(random(-4, 4), random(-1,1));
    position = l.copy();
    position.x = position.x + (int)random(-100,100);
    lifespan = 100.0;
  }

  void run(int ps_lifespan) {
    update();
    display(ps_lifespan);
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 2.0;
  }

  // Method to display
  void display(int ps_lifespan) {
    stroke(255, min(ps_lifespan, lifespan));
    
    if (mode == Mode.RAIN) {
      fill(255, min(ps_lifespan, lifespan));
    }
    else if (mode == Mode.LEAVES) {
     float r = random(180,255);
     float g = random(100,255);
     float b = random(10,80);
      fill(color(r,g,b), min(ps_lifespan, lifespan));
    }
    rectMode(CENTER);
    blendMode(ADD);
    rect(position.x, position.y, sq_width, sq_width);
  }

  // Is the particle still useful?
  boolean isDead() {
    return (lifespan < 0.0);
  }
}
