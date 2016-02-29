#include <Arduino.h>
#include "i2c.h"
#include <Wire.h>

// Адреса регистров гироскопа
#define CTRL_REG1 0x20
#define CTRL_REG2 0x21
#define CTRL_REG3 0x22
#define CTRL_REG4 0x23
#define CTRL_REG5 0x24

int L3G4200D_Address = 105; //Адрес L3G4200D (int)

extern int16_t x;
extern int16_t y;
extern int16_t z;

void setupL3G4200D()
{
  writeRegister(L3G4200D_Address, CTRL_REG1, 0x2f);
  writeRegister(L3G4200D_Address, CTRL_REG2, 0x00);
  writeRegister(L3G4200D_Address, CTRL_REG3, 0x00);
  writeRegister(L3G4200D_Address, CTRL_REG4, 0x30);
  writeRegister(L3G4200D_Address, CTRL_REG5, 0x00);
}

void getGyroValues()
{
  
  byte _buff[6];
  Wire.beginTransmission(L3G4200D_Address); // start transmission to device 
  Wire.write(0x28| (1 << 7));       // sends address to read from
  Wire.endTransmission();     // end transmission  
  //Wire.beginTransmission(L3G4200D_Address); // start transmission to device
  Wire.requestFrom(L3G4200D_Address, 6);  // request 6 bytes from device  
  int i = 0;
  while(Wire.available())     // device may send less than requested (abnormal)
  { 
      _buff[i] = Wire.read();  // receive a byte
      i++;
  }
  Wire.endTransmission();     // end transmission
  x = ((_buff[1] << 8) | _buff[0]);
  y = ((_buff[3] << 8) | _buff[2]);
  z = ((_buff[5] << 8) | _buff[4]);
  /* byte xMSB = readRegister(L3G4200D_Address, 0x29);
  byte xLSB = readRegister(L3G4200D_Address, 0x28);
  x = ((xMSB << 8) | xLSB);

  byte yMSB = readRegister(L3G4200D_Address, 0x2B);
  byte yLSB = readRegister(L3G4200D_Address, 0x2A);
  y = ((yMSB << 8) | yLSB);

  byte zMSB = readRegister(L3G4200D_Address, 0x2D);
  byte zLSB = readRegister(L3G4200D_Address, 0x2C);
  z = ((zMSB << 8) | zLSB);*/
}
