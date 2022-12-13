import processing.video.*;
Movie rain_mov;
Movie fall_mov;
Movie snow_mov;
Movie movie; //currently playing

float time_at_start;
float time_now;
float movie_start;
int time_elapsed = 0;

boolean leeds = false;
int single_screen_mode_display_dimensions = 1024;

enum Mode {
  RAIN,
  LEAVES,
  SNOW {
  @Override
        public Mode next() {
            return values()[0];  
        };
    };

    public Mode next() {
        // No bounds checking required here, because the last instance overrides
        return values()[ordinal() + 1];
    }
 };

Mode mode;

void setup() {
  //size(2000,1200);
  fullScreen();
  mode = Mode.RAIN;
  rain_mov = new Movie(this, "rain_20s.mp4");
  fall_mov = new Movie(this, "fall_20s.mp4");
  snow_mov = new Movie(this, "snow_20s.mov");
  rain_mov.pause();
  fall_mov.pause();
  snow_mov.pause();
  time_at_start = millis();
  movie_start = millis();
  //movie.loop();
}

void movieEvent(Movie movie) {
  movie.read();
}

void draw() {
  background(0);
  println(width, height);
  //image(movie, 0, 0);
  //loadPixels();
  //println(mode);
  switch(mode) {
    case RAIN:
      movie = rain_mov;
      rain_mov.play();
      fall_mov.stop();
      snow_mov.stop();
      //println("play rain mov");
      break;
    case LEAVES:
      movie = fall_mov;   
      snow_mov.stop();
      rain_mov.stop();
      fall_mov.play();
      //println("play fall mov");
      break;
    case SNOW:
      movie = snow_mov;
      rain_mov.stop();
      fall_mov.stop();
      snow_mov.play();
      //println("play snow mov");
      break;
  }
  movie.loadPixels();
  println(millis(), movie_start, movie.duration());
  if ((millis() -  movie_start)/1000 >= movie.duration()) {
    //println("finished!");
    movie_start = millis();
    mode = mode.next();
  }
  int border_x = (width - single_screen_mode_display_dimensions)/2;
  int border_y = (height - single_screen_mode_display_dimensions)/2;
  int x = border_x;
  int y = border_y;
  //int sq_width = 30;
  
  //random check for elapsed time
  float r = random(0,10);
  if (r < 0.05) {
    time_elapsed += 1;
  }
  //int time_elapsed = (int)((time_now - time_at_start) / 1000);
  int sq_width =  min(1024, max(4, int(pow(2, time_elapsed))));
  println(sq_width);
  //println(sq_width);
  
  //PIXELLATE
   while (y < height - (border_y+1)){
      x = border_x;
      while(x < width - border_x) {
       fill_with_avg_rgb(x, x+sq_width, y, y+sq_width);
       x += sq_width;
      }
     y += sq_width;
    }
  updatePixels();
  
  delay(10);
}

void keyPressed() {
    mode = mode.next();
}

void fill_with_avg_rgb(int x_start, int x_end, int y_start, int y_end) {
  float area = (x_end - x_start) * (y_end - y_start);
  float r_sum, g_sum, b_sum;
  float r_avg, g_avg, b_avg;
  r_sum = g_sum = b_sum = 0.0;
        r_avg = g_avg = b_avg = 0.0;
        for (int a = x_start; a < x_end; a += 1)
        {
          for (int c = y_start; c < y_end; c+=1)
          {
            //println("hi",movie.height, movie.width);
             int loc = (a + c * movie.width) % (movie.height * movie.width);
             float r = red(movie.pixels[loc]);
             float g = green(movie.pixels[loc]);
             float b = blue(movie.pixels[loc]);
             
             r_sum += r;
             g_sum += g;
             b_sum += b;
          }
        }
        
        r_avg = r_sum / area;
        g_avg = g_sum / area;
        b_avg = b_sum / area;
        
        noStroke();
        fill(r_avg, g_avg, b_avg);
        rect(x_start, y_start, x_end - x_start, y_end - y_start);
}
