// A simple Particle class
//from https://processing.org/examples/simpleparticlesystem.html

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0, random(0.02, 0.04));
    velocity = new PVector(random(-10, 10), random(-10,10));
    position = l.copy();
    lifespan = 255.0;
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
    fill(255, min(ps_lifespan, lifespan));
    //ellipse(position.x, position.y, 8, 8);
  }

  // Is the particle still useful?
  boolean isDead() {
    return (lifespan < 0.0);
  }
}
