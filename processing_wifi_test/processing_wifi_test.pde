int w = 600;
int h = 600;

int rec_cx = w/2;
int rec_cy = h/2;
int rec_w = w/4;
int rec_h = h/4;


void setup()
{
  size(600,600);
  rectMode(CENTER);
}

void draw()
{
  background(50,50,50);

  //process input
  String[] sensorVals = loadStrings("/Users/christineyang/Documents/GitHub/cs-senior-proj/wifiread");
  println("there are " + sensorVals.length + " lines");
  for (int i = 0 ; i < sensorVals.length; i++) {
    println(sensorVals[i]);
  }
  
  //process csv format
   String[] arr = sensorVals[0].split(",");
  int[] input = {0, 0, 0, 0, 0, 0, 0};
  for(int i = 0; i < 7; i++)
  {
     input[i] = parseInt(arr[i]);
  }
  //i = 0 is accel x
  //i = 1 is accel y
  //i = 2 is accel z
  //i = 3 is gyro x
  //i = 4 is gyro y
  //i = 5 is gyro z
  //i = 6 is temp
  delay(500);
  
  noStroke();
  //rect(centerx, centery, w, h)
  rec_cx += input[3]*10;
  rec_cy += input[4]*10;
  
  rec_w += (input[0] + input[1] + input[2]) * 100; 
  rec_h += (input[0] + input[1] + input[2]) * 100; 
  
  rect(rec_cx, rec_cy, rec_w, rec_h);
}
