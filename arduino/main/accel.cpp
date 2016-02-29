#include <Arduino.h>
#include "i2c.h"
#include <Wire.h>

// Адреса регистров акселерометра
#define POWER_CTL 0x2D
#define DATA_FORMAT 0x31
#define BW_RATE 0x2C
// I2C адрес акселерометра
int ADXL345_Address = 83; //Адрес ADXL345 (int)

extern int16_t x_a;
extern int16_t y_a;
extern int16_t z_a;

void setupADXL345()
{
   writeRegister(ADXL345_Address,POWER_CTL,8);
  // left-justified, +/-16g, FULL_RES 
   writeRegister(ADXL345_Address,DATA_FORMAT,0x0b);
}

void getADXLValues()
{
  byte _buff[6];
  Wire.beginTransmission(ADXL345_Address); // start transmission to device 
  Wire.write(0x32);       // sends address to read from
  Wire.endTransmission();     // end transmission  
  //Wire.beginTransmission(ADXL345_Address); // start transmission to device
  Wire.requestFrom(ADXL345_Address, 6);  // request 6 bytes from device  
  int i = 0;
  while(Wire.available())     // device may send less than requested (abnormal)
  { 
      _buff[i] = Wire.read();  // receive a byte
      i++;
  }
  Wire.endTransmission();     // end transmission
  x_a = ((_buff[1] << 8) | _buff[0]);
  y_a = ((_buff[3] << 8) | _buff[2]);
  z_a = ((_buff[5] << 8) | _buff[4]);
}
