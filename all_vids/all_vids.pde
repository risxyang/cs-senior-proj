import processing.video.*;
Movie rain_mov;
Movie fall_mov;
Movie snow_mov;
Movie movie; //currently playing

////receive OSC msg
//import oscP5.*;
//OscP5 oscP5;
//String[] messageNames = {"/output_1", "/output_2", "/output_3","/output_4","/output_5","/output_6","/output_7","/output_8","/output_9" }; //message names for each DTW gesture type


float time_at_start;
float time_now;
float movie_start;
int time_elapsed = 0;

boolean leeds = false;
int single_screen_mode_display_dimensions = 1024;
int border_x;
int border_y;
int sq_width = 4;

//particles
Particle[] particles = new Particle[100];

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
  fullScreen(P3D);
  border_x = (width - single_screen_mode_display_dimensions)/2;
  border_y = (height - single_screen_mode_display_dimensions)/2;
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
  
  // make particles, a lot of them
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle(border_x, width-border_x, border_y, height-border_y);
  }
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
  println(millis(), movie_start, movie.duration());
  if ((millis() -  movie_start)/1000 >= movie.duration()) {
    //println("finished!");
    movie_start = millis();
    mode = mode.next();
  }
  int x = border_x;
  int y = border_y;
  //int sq_width = 30;
  
  //random check for elapsed time
  float r = random(0,10);
  if (r < 0.01) {
    time_elapsed += 1;
  }
  //int time_elapsed = (int)((time_now - time_at_start) / 1000);
  sq_width =  min(1024, max(4, int(pow(2, time_elapsed))));
  println(sq_width);
  //println(sq_width);
  
  //PIXELLATE
  movie.loadPixels();
  image(movie, 10000,10000); //render off screen somwhere because apparently this fixes the issue of the movie otherwise not appearing
   while (y < movie.height && y < height - (border_y+1)){
      x = border_x;
      while(x < movie.width && x < width - border_x) {
       fill_with_avg_rgb(x, x+sq_width, y, y+sq_width);
       x += sq_width;
      }
     y += sq_width;
    }
  updatePixels();
  //show particles
  camera();
  for (int i = 0; i < particles.length; i++) {
      translate(0,0,15);
      particles[i].update();
      particles[i].show();
      camera();
   }
  //draw borders again
  camera();
  //fill(0);
  //translate(0,0,50);
  //rect(0,0, border_x, height);
  //rect(0,0, width, border_y);
  //rect(0, height-border_y, width, height);
  //rect(width-border_x, 0, width, height);
  //rect(
 
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
