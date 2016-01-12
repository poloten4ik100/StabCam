#include <Arduino.h>
#include <Wire.h>
void writeRegister(int deviceAddress, byte address, byte val)
{
    Wire.beginTransmission(deviceAddress);
    Wire.write(address); 
    Wire.write(val);
    Wire.endTransmission();
}

int readRegister(int deviceAddress, byte address)
{
    int v;
    Wire.beginTransmission(deviceAddress);
    Wire.write(address);
    Wire.endTransmission();
    Wire.requestFrom(deviceAddress, 1);
    while(!Wire.available()) {
        // Ждем?
    }
    v = Wire.read();
    return v;
}
