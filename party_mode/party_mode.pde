//receive OSC msg
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress dest;
String[] messageNames = {"/output_1", "/output_2", "/output_3","/output_4","/output_5","/output_6","/output_7","/output_8","/output_9" }; //message names for each DTW gesture type
int output_state = 0;

color currColor;
color prevColor;
float gradientCycleHue = 0;
float circleCycle = 1.0;

ParticleSystem ps;

void setup() {
  fullScreen();
  //size(600,600x);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12001);
  dest = new NetAddress("127.0.0.1",6448);
  background(color(0,0,0));
  ps = new ParticleSystem(new PVector(width/2, height/2));
}

void draw() {
  prevColor = currColor;
  switch(output_state) {
         case 0:
           //do nothing
           break;
         case 1: 
           ps.startParticleSystem();
           ps.addParticle();
           //ps.startParticleSystem();
           //ps.addParticle();
           //println("up");
           gradientCycleHue = (gradientCycleHue + 1)%255;
           colorMode(HSB);
           currColor = color(gradientCycleHue, 200, 200);
           //background(currColor);
           colorMode(RGB);
           break;
         case 2:
         println(circleCycle);
           //currColor = color(0,0,255);
           if(frameCount % 10 == 0) {
             circleCycle = max(0.0, circleCycle - 0.1);
           }
           colorMode(HSB);
            currColor = color(hue(currColor), 255, 255.0*circleCycle);
           colorMode(RGB);
           break;
         case 3:
           //currColor = color(255,0,0);
           if(frameCount % 10 == 0) {
             circleCycle = min(1.0, circleCycle + 0.1);
           }
           colorMode(HSB);
            currColor = color(hue(currColor), 255, 255.0*circleCycle);
           colorMode(RGB);
           break;
         case 4:
           //currColor = color(0,255,50);
           //currColor = color(200,50,200);
           ps.startParticleSystem();
           ps.addParticle();
           break;
         case 5:
           //currColor = color((int)random(0,255),(int)random(0,255),(int)random(0,255));
           //currColor = color(255,150,200);
           ps.startParticleSystem();
           ps.addParticle();
           //delay(50);
           break;
         case 6:
           currColor = color(255,150,255);
           break;
         case 7:
           currColor = color(205,0,205);
           //currColor = color((int)random(0,255),(int)random(0,255),(int)random(0,255));
           //delay(250);
           break;
         case 8:
           currColor = color(255,100,0);
           break;
         case 9:
           currColor = color(255,50,50);
           ps.startParticleSystem();
           ps.addParticle();
           break;
       }
       //background(currColor);
       rectMode(CENTER);
       noStroke();
       if(currColor != -1) {
         fill(currColor,255);
       }
       if(output_state == 2) {
         if(circleCycle == 1.0) {
            background(0);
         }
         star(width/2.0, height/2.0, height * circleCycle, height*circleCycle*2, 5);
        if(circleCycle == 0.0) {
           circleCycle = 1.0;
         }
       }
       else if(output_state == 3) {
         if(circleCycle == 0.0) {
            background(0);
         }
         star(width/2.0, height/2.0, height * circleCycle, height*circleCycle*2, 5);
        if(circleCycle == 1.0) {
           circleCycle = 0.0;
         }
       }
       else {
         background(0);
         rect(width/2,height/2,width,height);
       }
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



void keyPressed() {
  if(key == '1') {
    output_state = 1;
  }
  else if(key == '2') {
    output_state = 2;
  }
  else if(key == '0') {
    output_state = 0;
  }
  else if(key == '3') {
    output_state = 3;
  }
  else if(key == '4') {
    output_state = 4;
  }
  else if(key == '5') {
    output_state = 5;
  }
  else if(key == '6') {
    output_state = 6;
  }
  else if(key == '7') {
    output_state = 7;
  }
  else if(key == '8') {
    output_state = 8;
  }
  else if(key == '9') {
    output_state = 9;
  }
}
