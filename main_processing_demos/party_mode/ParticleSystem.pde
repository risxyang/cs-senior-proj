// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 
//from https://processing.org/examples/simpleparticlesystem.html

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  int ps_lifespan = 255;

  ParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<Particle>();
  }


  void startParticleSystem() {
    ps_lifespan = 255;
  }
  
  void addParticle() {
    particles.add(new StarParticle(origin));
  }

  void run() {
    if (ps_lifespan > 0) {
      for (int i = particles.size()-1; i >= 0; i--) {
        Particle p = particles.get(i);
        p.run(ps_lifespan);
        if (p.isDead()) {
          particles.remove(i);
        }
      }
    }
    ps_lifespan -= 5;
  }
}
