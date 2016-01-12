#include <Arduino.h>
#include "i2c.h"

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
  byte xMSB = readRegister(L3G4200D_Address, 0x29);
  byte xLSB = readRegister(L3G4200D_Address, 0x28);
  x = ((xMSB << 8) | xLSB);
  byte yMSB = readRegister(L3G4200D_Address, 0x2B);
  byte yLSB = readRegister(L3G4200D_Address, 0x2A);
  y = ((yMSB << 8) | yLSB);
  byte zMSB = readRegister(L3G4200D_Address, 0x2D);
  byte zLSB = readRegister(L3G4200D_Address, 0x2C);
  z = ((zMSB << 8) | zLSB);
}
