/*
 * Testing ESC on quadcopter
 * 
 * Connect ground of ESC (brown) and data (yellow), but DO NOT connect Vcc (red)
 * 
 * - 1st connect arduino to ESC and power up arduino
 * - power up ESCs (hear bips)
 * - send any value between 1000 and 2000 ...
 */

#include <Servo.h>

// 4 ESCs
Servo myservo[4];

void setup() {
  Serial.begin(115200);
  delay(1000);

  for(int i=0; i<4; i++) {
    myservo[i].attach(i+3);  // attaches the servo on pin 9 to the servo object
  }

/*
  int pos = 2000;
  for(int i=0; i<4; i++) {
    myservo[i].writeMicroseconds(pos);
  }
  delay(2200);
  pos = 1000;
  for(int i=0; i<4; i++) {
    myservo[i].writeMicroseconds(pos);
  }
*/
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
  Serial.print("Specify motor: ");
  int i = GetStringNumber();
  Serial.println(i);
  
  Serial.print("Specify speed: ");
  int pos = GetStringNumber();
  Serial.println(pos);

  //for(int i=0; i<4; i++) {
    myservo[i].writeMicroseconds(pos);
  //}

  delay(15);
}


