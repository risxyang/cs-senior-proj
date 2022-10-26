#include "WiFi.h"

// Wifi Client
WiFiClient client;
const uint16_t port = 8091;
const char * host = "172.29.21.183";

void initWifi() {
  WiFi.mode(WIFI_MODE_STA);

  delay(10);
  WiFi.begin("yale wireless");

  Serial.println("Connecting.");
  while(WiFi.status() != WL_CONNECTED) {
    Serial.println(".");
    delay(500);
  }
}


#define THRESHOLD 30

const int trigPin = 5;
const int echoPin = 18;

//define sound speed in cm/uS
#define SOUND_SPEED 0.034
#define CM_TO_INCH 0.393701

long duration;
float distanceCm;
float distanceInch;
int newDistance;
int distance;

void setup() {
  Serial.begin(115200); // Starts the serial communication
  initWifi();

  pinMode(trigPin, OUTPUT); // Sets the trigPin as an Output
  pinMode(echoPin, INPUT); // Sets the echoPin as an Input
}

int getDistance()
{
   // Clears the trigPin
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  // Sets the trigPin on HIGH state for 10 micro seconds
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  
  // Reads the echoPin, returns the sound wave travel time in microseconds
  duration = pulseIn(echoPin, HIGH);
  
  // Calculate the distance
  distanceCm = duration * SOUND_SPEED/2;
  
  // Convert to inches
  distanceInch = distanceCm * CM_TO_INCH;
  
  // Prints the distance in the Serial Monitor
  // Serial.print("Distance (cm): ");
  // Serial.println(distanceCm);
  // Serial.print("Distance (inch): ");
  // Serial.println(distanceInch);

  return distanceCm;

}

void loop() {
    if (!client.connect(host, port)) {
          Serial.println("Connection to host failed");
          delay(10);
          return;
    }
    Serial.println("Connected to server successful!");

   
  newDistance = getDistance();
  if (abs(newDistance - distance) < THRESHOLD)
  {
     distance = newDistance;
  }
  // process distance.. 
  Serial.println(distance);
  client.println(String(distance)+","+String(distance)+","+String(distance)+","+String(distance));

  delay(50);


}