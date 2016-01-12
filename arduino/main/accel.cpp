#include <Arduino.h>
#include "i2c.h"

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
  byte xMSB = readRegister(ADXL345_Address, 0x33);
  byte xLSB = readRegister(ADXL345_Address, 0x32);
  x_a = ((xMSB << 8) | xLSB);
  byte yMSB = readRegister(ADXL345_Address, 0x35);
  byte yLSB = readRegister(ADXL345_Address, 0x34);
  y_a = ((yMSB << 8) | yLSB);
  byte zMSB = readRegister(ADXL345_Address, 0x37);
  byte zLSB = readRegister(ADXL345_Address, 0x36);
  z_a = ((zMSB << 8) | zLSB);
}
