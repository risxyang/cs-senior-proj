//receive OSC msg
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress dest;
String[] messageNames = {"/output_1", "/output_2", "/output_3","/output_4","/output_5","/output_6","/output_7","/output_8","/output_9" }; //message names for each DTW gesture type
int output_state = 0;

color currColor;
color prevColor;

ParticleSystem ps;

void setup() {
  size(600,600);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12001);
  dest = new NetAddress("127.0.0.1",6448);
  background(color(0,0,0));
  ps = new ParticleSystem(new PVector(width/2, 50));
}

void draw() {
  prevColor = currColor;
  switch(output_state) {
         case 0:
           //do nothing
           break;
         case 1: 
           currColor = color(255,255,255);
           println("up");
           break;
         case 2:
           currColor = color(0,0,255);
           ps.startParticleSystem();
           break;
         case 3:
           currColor = color(255,0,0);
           break;
         case 4:
           currColor = color(0,255,50);
           break;
         case 5:
           currColor = color((int)random(0,255),(int)random(0,255),(int)random(0,255));
           break;
         case 6:
           currColor = color(255,150,255);
           break;
         case 7:
           currColor = color(205,0,205);
           break;
         case 8:
           currColor = color(255,100,0);
           break;
         case 9:
           currColor = color(255,255,0);
           break;
       }
       background(currColor);
       
       ps.addParticle();
       ps.run();
       //delay(50);
       
}

//This is called automatically when OSC message is received
void oscEvent(OscMessage theOscMessage) {
 for (int i = 0; i < 9; i++) {
    if (theOscMessage.checkAddrPattern(messageNames[i]) == true) {
       //showMessage(i);
       println(i);
       output_state = i;
    }
 }
}
