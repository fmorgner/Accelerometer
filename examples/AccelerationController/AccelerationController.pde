#include "AccelerometerAxis.h"
#include <stdlib.h>
#include <EEPROM.h>

int baseAddress = 100;

AccelerometerAxis* axisX;
AccelerometerAxis* axisY;
AccelerometerAxis* axisZ;

const char commandCalibrate = 'c';
const char commandStoreReference = 's';
const char commandLoadReference = 'l';
const char commandControllerVersion = 'v';

void calibrateAllAxis();
void printAllAxisValues();
void storeReferencePoints();
void loadReferencePoints();
void printVersionInformation();

void setup()
  {
  axisX = new AccelerometerAxis(7);
  axisY = new AccelerometerAxis(6);
  axisZ = new AccelerometerAxis(5);
  
  Serial.begin(115200);
  }
  
void loop()
  {
  if(Serial.available())
    {
    switch(Serial.read())
      {
      case commandCalibrate:
        calibrateAllAxis();
        break;
      case commandStoreReference:
        storeReferencePoints();
        break;
      case commandLoadReference:
        loadReferencePoints();
        break;
      case commandControllerVersion:
        printVersionInformation();
        break;
      default:
        break;
      }
    }
  }

void calibrateAllAxis()
  {
  axisX->calibrate();
  axisY->calibrate();
  axisZ->calibrate();
  }

void printAllAxisValues()
  {
  Serial.print(axisX->getPosition(true));
  Serial.print(";");
  Serial.print(axisY->getPosition(true));
  Serial.print(";");
  Serial.println(axisZ->getPosition(true));
  }

void storeReferencePoints()
  {
  EEPROM.write(baseAddress + 0, (axisX->getReferencePoint() >> 8));
  EEPROM.write(baseAddress + 1, (axisX->getReferencePoint() ));
  EEPROM.write(baseAddress + 2, (axisY->getReferencePoint() >> 8));
  EEPROM.write(baseAddress + 3, (axisY->getReferencePoint() ));
  EEPROM.write(baseAddress + 4, (axisZ->getReferencePoint() >> 8));
  EEPROM.write(baseAddress + 5, (axisZ->getReferencePoint() ));
  }
  
void loadReferencePoints()
  {
  int xRef = 0, yRef = 0, zRef = 0;

  xRef = (int)(EEPROM.read(baseAddress + 0) << 8) | (int)(EEPROM.read(baseAddress + 1));
  yRef = (int)(EEPROM.read(baseAddress + 2) << 8) | (int)(EEPROM.read(baseAddress + 3));
  zRef = (int)(EEPROM.read(baseAddress + 4) << 8) | (int)(EEPROM.read(baseAddress + 5));
  }
  
void printVersionInformation()
  {
  
  }

