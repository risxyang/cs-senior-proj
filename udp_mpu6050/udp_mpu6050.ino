#include "WiFi.h"
#include <WiFiUdp.h>
// // Library imports for MPU-6050 readings
#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>
#include <Wire.h>

// // Create an MPU-6050 object to read data from
Adafruit_MPU6050 mpu;

// Wifi
void connectToWiFi(const char * ssid, const char * pwd);
void WiFiEvent(WiFiEvent_t event) ;

// WiFi network name and password:
const char * networkName = "yale wireless";
const char * networkPswd = "";

//IP address to send UDP data to:
// either use the ip address of the server or 
// a network broadcast address
const char * udpAddress = "172.29.21.183"; 
//leeds: 172.29.34.245
const int udpPort = 8092;

//Are we currently connected?
boolean connected = false;

//The udp library class
WiFiUDP udp;

void initMPU() {
    // Try to initialize the MPU-6050 and wait while there are errors
  if (!mpu.begin()) {
    Serial.println("Failed to find MPU-6050 chip...");
    while (1) {
      delay(10);
    }
  }
  Serial.println("MPU-6050 found!");

  // Set accelerometer range and print its value
  mpu.setAccelerometerRange(MPU6050_RANGE_8_G);
  Serial.print("Accelerometer range set to: ");
  switch (mpu.getAccelerometerRange()) {
  case MPU6050_RANGE_2_G:
    Serial.println("+-2G");
    break;
  case MPU6050_RANGE_4_G:
    Serial.println("+-4G");
    break;
  case MPU6050_RANGE_8_G:
    Serial.println("+-8G");
    break;
  case MPU6050_RANGE_16_G:
    Serial.println("+-16G");
    break;
  }

  // Set gyroscope range and print its value
  mpu.setGyroRange(MPU6050_RANGE_500_DEG);
  Serial.print("Gyro range set to: ");
  switch (mpu.getGyroRange()) {
  case MPU6050_RANGE_250_DEG:
    Serial.println("+- 250 deg/s");
    break;
  case MPU6050_RANGE_500_DEG:
    Serial.println("+- 500 deg/s");
    break;
  case MPU6050_RANGE_1000_DEG:
    Serial.println("+- 1000 deg/s");
    break;
  case MPU6050_RANGE_2000_DEG:
    Serial.println("+- 2000 deg/s");
    break;
  }

  // Set bandwith and print its value
  mpu.setFilterBandwidth(MPU6050_BAND_21_HZ);
  Serial.print("Filter bandwidth set to: ");
  switch (mpu.getFilterBandwidth()) {
  case MPU6050_BAND_260_HZ:
    Serial.println("260 Hz");
    break;
  case MPU6050_BAND_184_HZ:
    Serial.println("184 Hz");
    break;
  case MPU6050_BAND_94_HZ:
    Serial.println("94 Hz");
    break;
  case MPU6050_BAND_44_HZ:
    Serial.println("44 Hz");
    break;
  case MPU6050_BAND_21_HZ:
    Serial.println("21 Hz");
    break;
  case MPU6050_BAND_10_HZ:
    Serial.println("10 Hz");
    break;
  case MPU6050_BAND_5_HZ:
    Serial.println("5 Hz");
    break;
  }

  // Put a linebreak and short delay after setup
  Serial.println("MPU init finished.");
  delay(100);
}

void setup() {
  Serial.begin(115200);
  //Connect to the WiFi network
  connectToWiFi(networkName, networkPswd);
  initMPU();
  
}

void loop() {

  // Get new sensor event with the readings
  sensors_event_t a, g, temp;
  mpu.getEvent(&a, &g, &temp);

  // // Set struct values based on the readings
  // myData.accel_x = a.acceleration.x;
  // myData.accel_y = a.acceleration.y;
  // myData.accel_z = a.acceleration.z;
  // myData.rot_x = g.gyro.x;
  // myData.rot_y = g.gyro.y;
  // myData.rot_z = g.gyro.z;

  /* Print out the values */
  Serial.print("Acceleration X: ");
  Serial.print(a.acceleration.x);
  Serial.print(", Y: ");
  Serial.print(a.acceleration.y);
  Serial.print(", Z: ");
  Serial.print(a.acceleration.z);
  Serial.println(" m/s^2");

  Serial.print("Rotation X: ");
  Serial.print(g.gyro.x);
  Serial.print(", Y: ");
  Serial.print(g.gyro.y);
  Serial.print(", Z: ");
  Serial.print(g.gyro.z);
  Serial.println(" rad/s");

  Serial.print("Temperature: ");
  Serial.print(temp.temperature);
  Serial.println(" degC");

  Serial.println("");
  // delay(500);

  // client.println(String(g.gyro.x) + "," + String(g.gyro.y) + "," + String(g.gyro.z) + "," + String(a.acceleration.x) + "," + String(a.acceleration.y) + "," + String(a.acceleration.z)+ "," + String(temp.temperature));
  String msg = String(g.gyro.x) + "," + String(g.gyro.y) + "," + String(g.gyro.z) + "," + String(a.acceleration.x) + "," + String(a.acceleration.y) + "," + String(a.acceleration.z);

  //only send data when connected
  if(connected){
    //Send a packet
    udp.beginPacket(udpAddress,udpPort);
    udp.print(msg);  // USES .print INSTEAD OF .write
    udp.endPacket();
  }

  // delay(1);
}

void connectToWiFi(const char * ssid, const char * pwd){
  Serial.println("Connecting to WiFi network: " + String(ssid));

  // delete old config
  WiFi.disconnect(true);
  //register event handler
  WiFi.onEvent(WiFiEvent);

  //Initiate connection
  WiFi.begin(ssid, pwd);

  Serial.println("Waiting for WIFI connection...");
}

//wifi event handler
void WiFiEvent(WiFiEvent_t event){
    switch(event) {
      case SYSTEM_EVENT_STA_GOT_IP:
          //When connected set 
          Serial.print("WiFi connected! IP address: ");
          Serial.println(WiFi.localIP());  
          //initializes the UDP state
          //This initializes the transfer buffer
          udp.begin(WiFi.localIP(),udpPort);
          connected = true;
          break;
      case SYSTEM_EVENT_STA_DISCONNECTED:
          Serial.println("WiFi lost connection");
          connected = false;
          break;
    }
}