Leaf[] leaves = new Leaf[18];
PImage bgImg;

void setup () {
  size(600,600, P3D);
   bgImg = loadImage("xc.jpg");
   rectMode(CENTER);
  
  // make leaves, a lot of them
  for (int i = 0; i < leaves.length; i++) {
    leaves[i] = new Leaf();
  }
  
}

void draw () {
  background(255, 255, 230);
  translate(0,0,-50);
  bgImg.filter(POSTERIZE, 4);
  bgImg.resize(1000, 700);
  tint(240, 180, 80, 150);
  image(bgImg, -50, -50);
  camera();
  for (int i = 0; i < leaves.length; i++) {
      leaves[i].update();
      leaves[i].show();
      camera();
    }
}
