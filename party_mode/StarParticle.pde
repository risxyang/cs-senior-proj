// A subclass of Particle
//adapted from https://processing.org/examples/multipleparticlesystems.html

class StarParticle extends Particle {

  // Just adding one new variable to a CrazyParticle
  // It inherits all other fields from "Particle", and we don't have to retype them!
  float theta;

  // The CrazyParticle constructor can call the parent class (super class) constructor
  StarParticle(PVector l) {
    // "super" means do everything from the constructor in Particle
    super(l);
    // One more line of code to deal with the new variable, theta
    //theta = 0.0;
  }

  // Notice we don't have the method run() here; it is inherited from Particle

  // This update() method overrides the parent class update() method
  void update() {
    super.update();
    // Increment rotation based on horizontal velocity
    //float theta_vel = (velocity.x * velocity.mag()) / 10.0f;
    //theta += theta_vel;
  }

  // This display() method overrides the parent class display() method
  void display(int ps_lifespan) {
    // Render the ellipse just like in a regular particle
    super.display(ps_lifespan);
    // Then add a rotating line
    pushMatrix();
    translate(position.x, position.y);
    rotate(frameCount / 50.0);
    //fill(255,255,0);
    star(0,0, 30, 60, 5); 
    //line(0, 0, 25, 0);
    popMatrix();
  }
}

//from https://processing.org/examples/star.html
void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
