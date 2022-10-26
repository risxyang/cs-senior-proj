int cr = 200;

void setup()
{
  size(600,600);
}

void draw()
{
  //process input
  String[] sensorVals = loadStrings("/Users/christineyang/Documents/GitHub/cs-senior-proj/wifiread");
  println("there are " + sensorVals.length + " lines");
  for (int i = 0 ; i < sensorVals.length; i++) {
    println(sensorVals[i]);
  }
  
   String[] arr = sensorVals[0].split(",");
  int[] input = {0, 0, 0, 0};
  for(int i = 0; i < 4; i++)
  {
     input[i] = parseInt(arr[i]);
  }
  

  background(50,50,50);
  color(10,10,255);
  circle(300,300, cr + input[0]*5);
  
  delay(100);
    
}
