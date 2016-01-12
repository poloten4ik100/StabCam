/* Начало положено в 2015 году
       Автор - Женя
*/

#include <Wire.h>
#include "gyro.h"
#include "accel.h"

int16_t x;
int16_t y;
int16_t z;

int16_t x_a;
int16_t y_a;
int16_t z_a;

double xa,ya,za;
double pitch;
double roll;
double FilterRoll;
double FilterPitch;

double PKp = 0.03; //0.4
double PKi = 0.001 ;//0.0006
double PKd = 0.1; //0.005
double RKp = 1.24; //0.4
double RKi = 0.38; //0.0006
double RKd = 0.34; //0.005
double YKp = 0.35; //0.4
double YKi = 0.1; //0.0006
double YKd = 0.35; //0.005
double error_roll = 0;
double pre_error_roll = 0;
double pre_error_roll2 =0;
double res_roll = 0;
double pre_res_roll = 0;
double K = 0.04;
/*const int EN1 = 5;
const int EN2 = 6;
const int EN3 = 7;*/
const int IN1 = 9;
const int IN2 = 10;
const int IN3 = 11;
// СИНУСЫ
//const int pwmSin[] = {127, 138, 149, 160, 170, 181, 191, 200, 209, 217, 224, 231, 237, 242, 246, 250, 252, 254, 254, 254, 252, 250, 246, 242, 237, 231, 224, 217, 209, 200, 191, 181, 170, 160, 149, 138, 127, 116, 105, 94, 84, 73, 64, 54, 45, 37, 30, 23, 17, 12, 8, 4, 2, 0, 0, 0, 2, 4, 8, 12, 17, 23, 30, 37, 45, 54, 64, 73, 84, 94, 105, 116 };
// const int pwmSin[] = {127, 165, 199, 226, 245, 254, 251, 237, 213, 181, 145, 107, 71,  40,  16,  3, 0, 9, 29,  57,  92}; //21
//  const int pwmSin[] = {127, 217, 254, 217, 127, 37 , 0 ,37};
//  const int pwmSin[] = {127 , 202 ,248, 248, 202, 127, 52,  6, 6, 52}; //10
 // const int pwmSin[] = {127 , 135 ,143 ,151, 159, 166, 174 ,181, 188 ,195, 202, 208, 214, 220 ,225 ,230 ,234, 238, 242, 245 ,248 ,250 ,252, 253, 254 ,254 ,254, 253, 252, 250 ,248, 245 ,242 ,238 ,234,230, 225, 220 ,214 ,208 ,202 ,195 ,188 ,181, 174 ,166, 159 ,151, 143, 135, 127 ,119 ,111, 103, 95 , 88  ,80 , 73 , 66 , 59,  52 , 46  ,40 , 34 , 29 , 24,  20,  16,  12 , 9 ,6, 4, 2, 1, 0 ,0, 0, 1 ,2, 4, 6 ,9 ,12 , 16 , 20  ,24  ,29 , 34 , 40,  46 , 52 , 59 , 66 , 73 , 80 , 88 , 95  ,103, 111, 119};
  //const int pwmSin[] = {127, 134, 140, 147, 153, 160, 166, 172, 178, 184, 190, 196, 201, 207, 212, 217, 221, 225, 229, 233, 237, 240, 243, 245, 248, 249, 251, 252, 253, 254, 254, 254, 253, 253, 251, 250, 248, 246, 243, 241, 238, 234, 230, 226, 222, 218, 213, 208, 203, 197, 192, 186, 180, 174, 168, 161, 155, 148, 142, 135, 129, 122, 115, 109, 102, 96, 89, 83, 77, 71, 65, 59, 54, 49, 43, 39, 34, 30, 25, 22, 18, 15, 12, 9, 7, 5, 3, 2, 1, 0, 0, 0, 0, 1, 2, 4, 5, 8, 10, 13, 16, 19, 23, 27, 31, 35, 40, 45, 50, 55, 61, 67, 73, 79, 85, 91, 98, 104, 111, 117, 124};
// const int pwmSin[] = {127, 139, 151, 163, 175, 186, 196, 206, 215, 224, 231, 238, 243, 248, 251, 253, 254, 254, 252, 250, 246, 241, 236, 229, 221, 212, 203, 193, 182, 171, 159, 147, 135, 123, 111, 99, 87, 76, 65, 54, 45, 36, 28, 21, 15, 9, 5, 2, 1, 0, 1, 2, 5, 9, 14, 20, 28, 36, 44, 54, 64, 75, 87, 98, 110, 123};
  const int pwmSin[] = {127, 130, 133, 136, 139, 143, 146, 149, 152, 155, 158, 161, 164, 167, 170, 173, 176, 178, 181, 184, 187, 190, 192, 195, 198, 200, 203, 205, 208, 210, 212, 215, 217, 219, 221, 223, 225, 227, 229, 231, 233, 234, 236, 238, 239, 240, 242, 243, 244, 245, 247, 248, 249, 249, 250, 251, 252, 252, 253, 253, 253, 254, 254, 254, 254, 254, 254, 254, 253, 253, 253, 252, 252, 251, 250, 249, 249, 248, 247, 245, 244, 243, 242, 240, 239, 238, 236, 234, 233, 231, 229, 227, 225, 223, 221, 219, 217, 215, 212, 210, 208, 205, 203, 200, 198, 195, 192, 190, 187, 184, 181, 178, 176, 173, 170, 167, 164, 161, 158, 155, 152, 149, 146, 143, 139, 136, 133, 130, 127, 124, 121, 118, 115, 111, 108, 105, 102, 99, 96, 93, 90, 87, 84, 81, 78, 76, 73, 70, 67, 64, 62, 59, 56, 54, 51, 49, 46, 44, 42, 39, 37, 35, 33, 31, 29, 27, 25, 23, 21, 20, 18, 16, 15, 14, 12, 11, 10, 9, 7, 6, 5, 5, 4, 3, 2, 2, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 2, 2, 3, 4, 5, 5, 6, 7, 9, 10, 11, 12, 14, 15, 16, 18, 20, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 42, 44, 46, 49, 51, 54, 56, 59, 62, 64, 67, 70, 73, 76, 78, 81, 84, 87, 90, 93, 96, 99, 102, 105, 108, 111, 115, 118, 121, 124};
 //const int pwmSin[] = {};
/// SVPWM (Space Vector Wave),
//const int pwmSin[] = {128, 147, 166, 185, 203, 221, 238, 243, 248, 251, 253, 255, 255, 255, 253, 251, 248, 243, 238, 243, 248, 251, 253, 255, 255, 255, 253, 251, 248, 243, 238, 221, 203, 185, 166, 147, 128, 109, 90, 71, 53, 35, 18, 13, 8, 5, 3, 1, 1, 1, 3, 5, 8, 13, 18, 13, 8, 5, 3, 1, 1, 1, 3, 5, 8, 13, 18, 35, 53, 71, 90, 109};
//const int pwmSin[] = {128, 132, 136, 140, 143, 147, 151, 155, 159, 162, 166, 170, 174, 178, 181, 185, 189, 192, 196, 200, 203, 207, 211, 214, 218, 221, 225, 228, 232, 235, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 248, 249, 250, 250, 251, 252, 252, 253, 253, 253, 254, 254, 254, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 254, 254, 254, 253, 253, 253, 252, 252, 251, 250, 250, 249, 248, 248, 247, 246, 245, 244, 243, 242, 241, 240, 239, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 248, 249, 250, 250, 251, 252, 252, 253, 253, 253, 254, 254, 254, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 254, 254, 254, 253, 253, 253, 252, 252, 251, 250, 250, 249, 248, 248, 247, 246, 245, 244, 243, 242, 241, 240, 239, 238, 235, 232, 228, 225, 221, 218, 214, 211, 207, 203, 200, 196, 192, 189, 185, 181, 178, 174, 170, 166, 162, 159, 155, 151, 147, 143, 140, 136, 132, 128, 124, 120, 116, 113, 109, 105, 101, 97, 94, 90, 86, 82, 78, 75, 71, 67, 64, 60, 56, 53, 49, 45, 42, 38, 35, 31, 28, 24, 21, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 8, 7, 6, 6, 5, 4, 4, 3, 3, 3, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 6, 6, 7, 8, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 8, 7, 6, 6, 5, 4, 4, 3, 3, 3, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 6, 6, 7, 8, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 21, 24, 28, 31, 35, 38, 42, 45, 49, 53, 56, 60, 64, 67, 71, 75, 78, 82, 86, 90, 94, 97, 101, 105, 109, 113, 116, 120, 124};
int currentStepA;
int currentStepB;
int currentStepC;
int sineArraySize;
int increment = 1;
int pred_increment = 1;
int delay_ = 10;
int out = 0;
String inputString = "";         // a string to hold incoming data
boolean stringComplete = false;  // whether the string is complete
int a=0;
long lastMotorDelayTime = 0;
//////////////////////////////////////////////////////////////////////////////
 
void setup() {
  Serial.begin(250000);   
  inputString.reserve(200);
  Wire.begin();
  setupL3G4200D();
  setupADXL345();
  setPwmFrequency(IN1);
  setPwmFrequency(IN2);
  setPwmFrequency(IN3);
  pinMode(IN1, OUTPUT); 
  pinMode(IN2, OUTPUT); 
  pinMode(IN3, OUTPUT); 
  pinMode(EN1, OUTPUT); 
  pinMode(EN2, OUTPUT); 
  pinMode(EN3, OUTPUT); 
  digitalWrite(EN1, HIGH);
  digitalWrite(EN2, HIGH);
  digitalWrite(EN3, HIGH);
  sineArraySize = sizeof(pwmSin)/sizeof(int);
  int phaseShift = sineArraySize / 3;
  currentStepA = 0;
  currentStepB = currentStepA + phaseShift;
  currentStepC = currentStepB + phaseShift;
  sineArraySize--;
  /*Serial.print(currentStepA);
  Serial.print(' ');
  Serial.print(currentStepB);
  Serial.print(' ');
  Serial.print(currentStepC);
  Serial.print(" size: ");
  Serial.println(sineArraySize);*/
}

//Вращаем мотором
void RunMotor(int pos)
{
  analogWrite(IN1, pwmSin[currentStepA]);
  analogWrite(IN2, pwmSin[currentStepB]);
  analogWrite(IN3, pwmSin[currentStepC]); 
/*  Serial.print(pwmSin[currentStepA]);
  Serial.print('|');
  Serial.print(pwmSin[currentStepB]);
  Serial.print('|');
  Serial.println(pwmSin[currentStepC]);*/
  currentStepA = currentStepA+pos;
  currentStepB = currentStepB+pos;
  currentStepC = currentStepC+pos;
  if(currentStepA > sineArraySize) currentStepA = currentStepA-sineArraySize;
  if(currentStepA < 0)  currentStepA = sineArraySize+currentStepA; 
  if(currentStepB > sineArraySize)  currentStepB = currentStepB-sineArraySize;
  if(currentStepB < 0)  currentStepB = sineArraySize+currentStepB;
  if(currentStepC > sineArraySize)  currentStepC = currentStepC-sineArraySize;
  if(currentStepC < 0)  currentStepC = sineArraySize+currentStepC;
}

unsigned int integerValue=0;  // Max value is 65535
char incomingByte;

void loop() {
  // if((millis() - lastMotorDelayTime) > 0)
 // {
  if (stringComplete) {
    //Serial.println(inputString);
    increment = inputString.toInt();
    inputString = "";
    stringComplete = false;
  }
  getGyroValues();
  getADXLValues();

  Serial.print(x);
  Serial.print('|');
  Serial.print(y);
  Serial.print('|');
  Serial.println(z);
  
  xa = (x_a * 0.0039);
  ya = (y_a * 0.0039);
  za = (z_a * 0.0039);
  roll = (atan2(ya ,sqrt(za*za + xa*xa)) * 180) / 3.14;
  pitch = (atan2(xa ,sqrt(za*za + ya*ya)) * 180) / 3.14;

  FilterRoll = (1-K)*(FilterRoll+(x*0.07 +0.2592)*0.01)+K*roll;
  FilterPitch = (1-K)*(FilterPitch+(-1)*(y*0.07 +0.8275)*0.01)+K*pitch; //-1
  
  Serial.print("Roll:");
  Serial.print(FilterRoll);
  Serial.print(" Pitch:");
  Serial.print(FilterPitch);
 
  error_roll = 0-FilterRoll;
  res_roll = pre_res_roll+PKp*(error_roll-pre_error_roll)+ PKi*(error_roll+pre_error_roll)/2+PKd*(x*0.07 +0.2592)*0.01;//PKp*(error_pitch);// //PKd*(error_pitch-2*pre_error_pitch+pre_error_pitch2); //
  out = res_roll / 0.01;
  RunMotor((int)out);
  pre_res_roll = res_roll;
  pre_error_roll = error_roll;
  pre_error_roll2 = pre_error_roll;
  Serial.print(" PID:");
  Serial.println(res_roll);
 /* Serial.print("Roll:");
  Serial.print(FilterRoll);
  Serial.print(" Pitch:");
  Serial.println(FilterPitch);*/
  delay(delay_);
   //lastMotorDelayTime = millis();
  //}
}
 
 
void setPwmFrequency(int pin) {
  if(pin == 5 || pin == 6 || pin == 9 || pin == 10) {
    if(pin == 5 || pin == 6) {
      TCCR0B = TCCR0B & 0b11111000 | 0x01;
    } else {
      TCCR1B = TCCR1B & 0b11111000 | 0x01;
    }
  }
  else if(pin == 3 || pin == 11) {
    TCCR2B = TCCR2B & 0b11111000 | 0x01;
  }
}

void serialEvent() {
  while (Serial.available()) {
    char inChar = (char)Serial.read();
    inputString += inChar;
    if (inChar == '\n') {
      stringComplete = true;
    }
  }
}
