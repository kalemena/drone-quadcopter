/*
 * Testing ESC on quadcopter
 * 
 * Connect ground of ESC (brown) and data (yellow), but DO NOT connect Vcc (red)
 * 
 * - 1st connect arduino to ESC and power up arduino
 * - send High value (e.g. 2000)
 * - power up ESCs (hear bips)
 * - after 2s, send Low value (e.g. 1000) (hear other bips)
 * - send any value between 1000 and 2000 ...
 */

#include <Servo.h>

// 4 ESCs
Servo myservo[4];

void setup() {
  Serial.begin(115200);
  delay(1000);
  Serial.println("Specify position: ");

  for(int i=0; i<4; i++) {
    myservo[i].attach(i+3);  // attaches the servo on pin 9 to the servo object
  }
}

int GetStringNumber()
{
   int value = 0;
       
   while(1)
   {
       char byteBuffer = Serial.read();
       if(byteBuffer == '\n')
         break;

       if(byteBuffer > -1) 
       {
         if(byteBuffer >= '0' && byteBuffer <= '9')
           value = (value * 10) + (byteBuffer - '0');
         else
           break;       
       }
   }

  return value;
}

void loop() {
  int pos = GetStringNumber();
  Serial.print("Value:"); Serial.println(pos);

  for(int i=0; i<4; i++) {
    myservo[i].writeMicroseconds(pos);
  }

  delay(15);
}


