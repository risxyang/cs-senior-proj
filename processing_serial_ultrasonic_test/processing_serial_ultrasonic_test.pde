import processing.serial.*;
Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port

int input;

int cr = 200;

void setup()
{
  size(600,600);
  String portName = "/dev/tty.SLAB_USBtoUART"; //for testing on laptop
  //String portName = "/dev/ttyUSB0"; //for raspi
  myPort = new Serial(this, portName, 115200);
}

void draw()
{
  if ( myPort.available() > 0) 
  {  // If data is available,
    val = myPort.readStringUntil('\n').trim();         // read it and store it in val
    //int[] input = Arrays.stream(val.split(",")).mapToInt(Integer::parseInt).toArray(); //won'trun on version of processing for pi
    
    input = parseInt(val);
    
    //String[] arr = val.split(",");
    //int[] input = {0, 0,d 0, 0, 0};
    //for(int i = 0; i < 5; i++)
    //{
    //    input[i] = parseInt(arr[i]);
    //}
    
    background(50,50,50);
    color(10,10,255);
    circle(300,300, cr + input);
    
    
    
  }
}
