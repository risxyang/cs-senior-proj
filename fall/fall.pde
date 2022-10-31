Leaf[] leaves = new Leaf[10];

void setup () {
  size(600,600, P3D);
  
  // make leaves, a lot of them
  for (int i = 0; i < leaves.length; i++) {
    leaves[i] = new Leaf();
  }
  
}

void draw () {
  background(0);
  for (int i = 0; i < leaves.length; i++) {
      leaves[i].update();
      leaves[i].show();
    }
}
