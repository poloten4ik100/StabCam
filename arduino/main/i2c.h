#ifndef i2c_H
#define i2c_H
void writeRegister(int deviceAddress, byte address, byte val);
int readRegister(int deviceAddress, byte address);
#endif
