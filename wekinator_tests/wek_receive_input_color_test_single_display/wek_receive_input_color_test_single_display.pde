//receive OSC msg
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress dest;
String[] messageNames = {"/output_1", "/output_2", "/output_3","/output_4","/output_5","/output_6","/output_7","/output_8","/output_9" }; //message names for each DTW gesture type


void setup() {
  size(400,400);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12001);
  dest = new NetAddress("127.0.0.1",6448);
}

void draw() {
  background(color(255,0,0));
}

//This is called automatically when OSC message is received
void oscEvent(OscMessage theOscMessage) {
 for (int i = 0; i < 9; i++) {
    if (theOscMessage.checkAddrPattern(messageNames[i]) == true) {
       //showMessage(i);
       println(i);
    }
 }
}
