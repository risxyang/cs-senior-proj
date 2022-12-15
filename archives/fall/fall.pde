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
  //bgImg.filter(POSTERIZE, 4);
  bgImg.resize(1000, 700);
  //tint(240, 180, 80, 150);
  //image(bgImg, -50, -50);
  bgImg.loadPixels();
  int x = 0;
  int y = 0;
  int sq_width = 20;
  float r_sum, g_sum, b_sum;
  float r_avg, g_avg, b_avg;
   while (y < bgImg.height - (sq_width + 1)){
      while(x < bgImg.width - (sq_width + 1)){
        r_sum = g_sum = b_sum = 0.0;
        r_avg = g_avg = b_avg = 0.0;
        for (int a = x; a < x + sq_width; a += 1)
        {
          for (int c = y; c < y + sq_width; c+=1)
          {
             int loc = (a + c * bgImg.width) % (bgImg.height * bgImg.width);
             //outofbounds

           float r = red(bgImg.pixels[loc]);
           float g = green(bgImg.pixels[loc]);
           float b = blue(bgImg.pixels[loc]);
           
           r_sum += r;
           g_sum += g;
           b_sum += b;
          }
        }
        
        r_avg = r_sum / (sq_width * sq_width);
        g_avg = g_sum / (sq_width * sq_width);
        b_avg = b_sum / (sq_width * sq_width);
        
        noStroke();
        fill(r_avg, g_avg, b_avg);
        rect(x, y, sq_width, sq_width);
        
        x += sq_width;
      }
        
     y += sq_width;
     x = 0;
    }
  updatePixels();
  camera();
  for (int i = 0; i < leaves.length; i++) {
      leaves[i].update();
      leaves[i].show();
      camera();
    }
}
