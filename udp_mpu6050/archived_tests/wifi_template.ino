// #include "WiFi.h"

// void initWifi() {
//   WiFi.mode(WIFI_MODE_STA);

//   delay(10);
//   WiFi.begin("yale wireless");

//   Serial.println("Connecting.");
//   while(WiFi.status() != WL_CONNECTED) {
//     Serial.println(".");
//     delay(500);
//   }
// }

// void setup() {
//   Serial.begin(115200);
//   initWifi();
  
// }

// void loop() {
//   Serial.println("connected to wifi");

// if (!client.connect(host, port)) {
 
//         Serial.println("Connection to host failed");
 
//         delay(10);
//         return;
//     }

//  Serial.println("Connected to server successful!");
// }