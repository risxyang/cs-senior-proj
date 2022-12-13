int w = 600;
int h = 600;

int nExpInput = 6;
int[][] arr = new int[w][nExpInput];
color[] colors = {color(255,0,0), color(255,100,0), color(255,255,0), color(0,255,0), color(0,0,255), color(255,0,255), color(255,255,255)};
String[] labels = {"accelerometer X", "accelerometer Y", "accelerometer Z", "gyroscope X", "gyroscope Y", "gyroscope Z", "temperature"};
boolean[] arrDisplayInput = new boolean[nExpInput];

int index = 0;
int j = 0;


void setup()
{
  size(600,600);
  
  //init to 0
  for (int m = 0; m < width; m++) {
    for (int n = 0; n < nExpInput; n++) {
      arr[m][n] = 0;
    }
  }
  
  for (int i = 0; i < nExpInput; i++)
  {
   arrDisplayInput[i] = true;
  }
  
}

void draw()
{

  //process input
  String[] sensorVals = loadStrings("/Users/christineyang/Documents/GitHub/cs-senior-proj/wifiread");
  //println("there are " + sensorVals.length + " lines");
  
  if (sensorVals.length > 0)
  {
    background(50,50,50);
    //for debug purposes
    //for (int i = 0 ; i < sensorVals.length; i++) {
    //  println(sensorVals[i]);
    //}
    
    //process csv format
    String[] stringInput = sensorVals[0].split(",");
    //float[] input = {0, 0, 0, 0, 0, 0, 0};
    for(int i = 0; i < nExpInput; i++)
    {
      //input[i] = parseFloat(arr[i]);
      arr[index][i] = int(parseFloat(stringInput[i]) * 10.0);
      
      if(arrDisplayInput[i]) {
        strokeCap(ROUND);
        strokeWeight(3);
        stroke(colors[i]);
        
        j = 0;
        for(int k = index; k < width; k++)
        {
          //print(arr1[i]);
          point(j, h/2 + arr[k][i]);
          j++;
          
        }
        for(int k = 0; k < index; k++)
        {
          //print(arr1[i]);
          point(j, h/2 + arr[k][i]);
          j++;
        }
        
        //draw legend
        fill(colors[i]);
        rect(10, 10+15*i, 10, 10);
        text(str(i) + "--" + labels[i], 25, 18+15*i);
      }
      else {
        //draw legend and mark as hidden
        fill(color(100,100,100));
        //rect(10, 10+15*i, 10, 10);
        text(str(i) + "--" + labels[i] + " (hidden) ", 25, 18+15*i);
      }
     
    }
    //i = 0 is accel x
    //i = 1 is accel y
    //i = 2 is accel z
    //i = 3 is gyro x
    //i = 4 is gyro y
    //i = 5 is gyro z
    //i = 6 is temp
    
    
    //arr1[index] = int(input[0] * 10.0);
    
    
  }
    index = (index + 1) % width;
}

void keyPressed() {
  switch(key) {
    case '0':
      arrDisplayInput[0] = !arrDisplayInput[0];
      break;
    case '1':
      arrDisplayInput[1] = !arrDisplayInput[1];
      break;
    case '2':
      arrDisplayInput[2] = !arrDisplayInput[2];
      break;
    case '3':
      arrDisplayInput[3] = !arrDisplayInput[3];
      break;
    case '4':
      arrDisplayInput[4] = !arrDisplayInput[4];
      break;
    case '5':
      arrDisplayInput[5] = !arrDisplayInput[5];
      break;
    case '6':
      arrDisplayInput[6] = !arrDisplayInput[6];
      break;  
  }
}
