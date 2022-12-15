// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 
//from https://processing.org/examples/simpleparticlesystem.html

class TopParticleSystem {
  ArrayList<TopParticle> top_particles;
  PVector origin;
  float ps_lifespan;
  int max_particles = 50;
  int n_particles = 0;

  TopParticleSystem(PVector position) {
    origin = position.copy();
    top_particles = new ArrayList<TopParticle>();
  }


  void startParticleSystem() {
    ps_lifespan = 250;
  }
  
  void addParticle() {
    if(n_particles < max_particles) {
      top_particles.add(new TopParticle(origin));
      n_particles += 1;
    }
  }
  
  void addNumParticles() {
    max_particles += 20;
  }

  void run() {
    if (ps_lifespan > 0) {
      for (int i = top_particles.size()-1; i >= 0; i--) {
        TopParticle p = top_particles.get(i);
        p.run((int)ps_lifespan);
        if (p.isDead()) {
          top_particles.remove(i);
          n_particles -= 1;
        }
      }
    }
    ps_lifespan -= 1;
    //println(ps_lifespan);
    if (ps_lifespan <= 0) {
      n_particles = 0;
    }
  }
}
