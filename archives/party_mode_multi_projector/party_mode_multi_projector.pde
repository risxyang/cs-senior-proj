ChildApplet child1;
ChildApplet child2;
ChildApplet child3;
ChildApplet child4;
ChildApplet child5;
ChildApplet child6;
//window index for instantiating child applets w/ a child id
int windex = 0;

//sizeX = horizontal width of image-to-be-projected ond desktop
//sizeX = vertical height of image-to-be-projected ond desktop
int sizeX = 1360; 
int sizeY = 768;

//vars to hold current spawn locations for windows as they are created
int spawnX = 0;
int spawnY = 0;

//start location of the first window (after first desktop monitor)
int startX = 1024;


//receive OSC msg
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress dest;
String[] messageNames = {"/output_1", "/output_2", "/output_3","/output_4","/output_5","/output_6","/output_7","/output_8","/output_9" }; //message names for each DTW gesture type
int output_state = 1;
int prev_output_state = 0;


void setup() {
  //fullScreen();
  //size(600,600x);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12001);
  dest = new NetAddress("127.0.0.1",6448);
  background(color(0,0,0));
  
  //instantiate child applets
  child1 = new ChildApplet();
  child2 = new ChildApplet();
  child3 = new ChildApplet();
  child4 = new ChildApplet();
  child5 = new ChildApplet();
  child6 = new ChildApplet();
}


class ChildApplet extends PApplet {

  //vars for holding this child applet's loaded image, child applet ID
  PImage img;
  int cid = 0;
  ParticleSystem cps;
  color currColor;
  color prevColor;
  float gradientCycleHue = 0;
  float circleCycle = 1.0;


  //int var to hold the y value at which the small background image begins
  int xStartSmall;
  
  public ChildApplet() {
    super();
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
    
  }

  public void settings() {
    size(sizeX, sizeY);
    smooth();
  }
  public void setup() { 
    surface.setTitle("Child sketch");
    currColor = 100;
    prevColor = 100;
    
    //spawn this window at the designated location, with the same interval of distance between each window
    surface.setLocation(spawnX + startX, spawnY);
    
    cps = new ParticleSystem(new PVector(width/2.0, height/2.0));
    println(width/2.0, height/2.0);
    
    spawnX += sizeX;
   
  }
  void draw() {
    //println(output_state);
    prevColor = currColor;
    switch(output_state) {
           case 0:
             //do nothing
             break;
           case 1: 
             //cps.startParticleSystem();
             //cps.addParticle();
             //println("up");
             gradientCycleHue = (gradientCycleHue + 1)%255;
             colorMode(HSB);
             currColor = color(gradientCycleHue, 200, 200);
             //background(currColor);
             colorMode(RGB);
             break;
           case 2:
           println(circleCycle);
             currColor = color(0,0,255);
             if(frameCount % 3 == 0) {
               circleCycle = max(0.0, circleCycle - 0.1);
             }
             colorMode(HSB);
              currColor = color(hue(currColor), 255, 255.0*circleCycle);
             colorMode(RGB);
             break;
           case 3:
             println(circleCycle);
             currColor = color(255,0,0);
             if(frameCount % 3 == 0) {
               circleCycle = min(1.0, circleCycle + 0.1);
             }
             colorMode(HSB);
              currColor = color(hue(currColor), 255, 255.0*circleCycle);
             colorMode(RGB);
             break;
           case 4:
             //currColor = color(0,255,50);
             //currColor = color(200,50,200);
             cps.startParticleSystem();
             cps.addParticle();
             break;
           case 5:
             //currColor = color((int)random(0,255),(int)random(0,255),(int)random(0,255));
             //currColor = color(255,150,200);
             cps.startParticleSystem();
             int r = (int)random(0,5);
             if (r < 1) {
               cps.addParticle();
             }
             //delay(50);
             break;
           case 6:
             currColor = color(255,150,255);
             break;
           case 7:
             currColor = color(205,0,205);
             //currColor = color((int)random(0,255),(int)random(0,255),(int)random(0,255));
             //delay(250);
             break;
           case 8:
             currColor = color(255,100,0);
             break;
           case 9:
             currColor = color(255,50,50);
             cps.startParticleSystem();
             cps.addParticle();
             break;
         }
         //background(currColor);
         rectMode(CENTER);
         blendMode(ADD);
         noStroke();
         if(currColor != -1) {
           fill(currColor,255);
         }
         if(output_state == 2) {
           if(circleCycle == 1.0) {
              background(0);
           }
            blendMode(NORMAL);
           star2(width/2.0, height/2.0, height * circleCycle, height*circleCycle*2, 5);
          if(circleCycle == 0.0) {
             circleCycle = 1.0;
           }
         }
         else if(output_state == 3) {
           if(circleCycle == 0.0) {
              background(0);
           }
           star2(width/2.0, height/2.0, height * circleCycle, height*circleCycle*2, 5);
          if(circleCycle == 1.0) {
             circleCycle = 0.0;
           }
         }
         else {
           background(currColor);
           //rect(sizeX/2,sizeY/2,sizeX,sizeY);
         }
         cps.run();
         blendMode(NORMAL);
         delay(50);
         
  }
  
  //This is called automatically when OSC message is received
  void oscEvent(OscMessage theOscMessage) {
   for (int i = 0; i < 9; i++) {
      if (theOscMessage.checkAddrPattern(messageNames[i]) == true) {
         //showMessage(i);
         //println(i);
         prev_output_state = output_state;
         output_state = i;
      }
   }
}

void star2(float x, float y, float radius1, float radius2, int npoints) {
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



void keyPressed() {
  prev_output_state = output_state;
  if(key == '1') {
    output_state = 1;
  }
  else if(key == '2') {
    output_state = 2;
  }
  else if(key == '0') {
    output_state = 0;
  }
  else if(key == '3') {
    output_state = 3;
  }
  else if(key == '4') {
    output_state = 4;
  }
  else if(key == '5') {
    output_state = 5;
  }
  else if(key == '6') {
    output_state = 6;
  }
  else if(key == '7') {
    output_state = 7;
  }
  else if(key == '8') {
    output_state = 8;
  }
  else if(key == '9') {
    output_state = 9;
  }
}

// A simple Particle class
//from https://processing.org/examples/simpleparticlesystem.html

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(PVector l) {
    acceleration = new PVector(0, random(0.05, 0.1));
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
    //ellipse(position.x, position.y, 100, 100);
  }

  // Is the particle still useful?
  boolean isDead() {
    return (lifespan < 0.0);
  }
}

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
    blendMode(NORMAL);
      if(output_state == 5 || prev_output_state == 5) {
      star(0,0, 30, 60, 5); 
    }
    else if(output_state == 4 || prev_output_state == 4) {
      star(0,0, 5, 10, 5); 
    }
    else if(output_state == 1 || output_state == 9 || prev_output_state == 1 || prev_output_state == 9 ) {
      rotate(-frameCount / 50.0);
      rotate(-PI/2); //change if needed
      beginShape();
      vertex(50, 15);
      bezierVertex(50, -5, 90, 5, 50, 40);
      vertex(50, 15);
      bezierVertex(50, -5, 10, 5, 50, 40);
      endShape();
    }
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


}
