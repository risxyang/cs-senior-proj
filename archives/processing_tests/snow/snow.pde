import processing.video.*;
Movie movie;

void setup() {
  //size(2000,1200);
  fullScreen();
  movie = new Movie(this, "snow.mov");
  movie.loop();
}

void movieEvent(Movie movie) {
  movie.read();
}

void draw() {
  //image(movie, 0, 0);
  //loadPixels();
  movie.loadPixels();
  int x = 0;
  int y = 0;
  int sq_width = 90;
  float r_sum, g_sum, b_sum;
  float r_avg, g_avg, b_avg;
   while (y < movie.height - (sq_width + 1)){
      while(x < movie.width - (sq_width + 1)){

        r_sum = g_sum = b_sum = 0.0;
        r_avg = g_avg = b_avg = 0.0;
        for (int a = x; a < x + sq_width; a += 1)
        {
          for (int c = y; c < y + sq_width; c+=1)
          {
             int loc = (a + c * movie.width) % (movie.height * movie.width);
             //outofbounds

           float r = red(movie.pixels[loc]);
           float g = green(movie.pixels[loc]);
           float b = blue(movie.pixels[loc]);
           
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
  delay(10);
}
