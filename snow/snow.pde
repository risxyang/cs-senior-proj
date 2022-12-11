import processing.video.*;
Movie movie;

void setup() {
  //size(2000,1200);
  fullScreen();
  movie = new Movie(this, "snow.mov");
  movie.loop();
}

void draw() {
  image(movie, 0, 0);
  delay(10);
}

//called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}
