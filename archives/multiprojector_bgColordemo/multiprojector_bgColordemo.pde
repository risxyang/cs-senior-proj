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


//bgColorDemo
int r, g = 0;
int b = 255;
color bgColor = color(0,0,255);
color[] colors = {color(255,0,0), color(255,100,0), color(255,255,0), color(0,255,0), color(0,0,255), color(255,0,255), color(255,255,255)};
int colorIndex = 0;

int startTime = 0;
int waitSeconds = 2000;
boolean isCountDown = false;

float[] input = {0, 0, 0, 0, 0, 0, 0};

void settings() {
  //size(sizeX , sizeY);
  smooth();
}

void setup() {
  
  //instantiate child applets
  child1 = new ChildApplet();
  child2 = new ChildApplet();
  child3 = new ChildApplet();
  child4 = new ChildApplet();
  child5 = new ChildApplet();
  child6 = new ChildApplet();
}

void draw() {
  //process input
  String[] sensorVals = loadStrings("/Users/christineyang/Documents/GitHub/cs-senior-proj/wifiread");
  
  if (sensorVals.length > 0) {
  //println("there are " + sensorVals.length + " lines");
    for (int i = 0 ; i < sensorVals.length; i++) {
      println(sensorVals[i]);
    }
    
    //process csv format
    String[] arr = sensorVals[0].split(",");
    for(int i = 0; i < 7; i++)
    {
       input[i] = parseFloat(arr[i]);
       print(input[i] + " ");
    }
  
}
}


class ChildApplet extends PApplet {

  //vars for holding this child applet's loaded image, child applet ID
  PImage img;
  int cid = 0;
  
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
    
    //spawn this window at the designated location, with the same interval of distance between each window
    surface.setLocation(spawnX + startX, spawnY);
    spawnX += sizeX;
    
  }

  public void draw() {
    
        if(millis() - startTime > waitSeconds) {
      //if (input[3] > 0) {
      //  r = min(255, r+(int)input[3]);
      //}
      //else {
      //  r = max(0, r+(int)input[3]);
      //}
      
      //if (input[5] > 0) {
      //  g = min(255, g+(int)input[4]);
      //}
      //else {
      //  g = max(0, g+(int)input[4]);
      //}
      
      //if (input[4] > 0) {
      //  b = min(255, r+(int)input[5]);
      //}
      //else {
      //  b = max(0, r+(int)input[5]);
      //}
      
      //bgColor = color(r,g,b);
      
      //just take avg of accelerations
      float avg_accel = max(abs(input[0]*10.0), abs(input[1]*10.0), abs(input[2]*10.0));
      if (avg_accel > 40.0) { //20 kinda sensitive
        bgColor = colors[colorIndex]; //later change this to all panels get some color
        colorIndex = (colorIndex + 1) % 7;
        startTime = millis();
      }
    }
    //else if (avg_accel > 10.0) {
    //  bgColor = color(255,0,0);
    //}
    
    background(bgColor);
  }

}
