#include "WiFi.h"
// // Library imports for MPU-6050 readings
#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>
#include <Wire.h>

// // Create an MPU-6050 object to read data from
Adafruit_MPU6050 mpu;

// Wifi Client
WiFiClient client;
const uint16_t port = 8091;
const char * host = "172.29.34.245";
// const char * host = "172.29.21.183";
// const char * host = "172.29.133.225";

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
  initWifi();
  initMPU();
  
}

void loop() {
  // Serial.println("connected to wifi");
  // delay(5000);

  if (!client.connect(host, port)) {
          Serial.println("Connection to host failed");
          delay(10);
          return;
      }

  Serial.println("Connected to server successful!");
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

  client.println(String(g.gyro.x) + "," + String(g.gyro.y) + "," + String(g.gyro.z) + "," + String(a.acceleration.x) + "," + String(a.acceleration.y) + "," + String(a.acceleration.z)+ "," + String(temp.temperature));


  delay(1);
}