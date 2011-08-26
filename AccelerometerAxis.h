#ifndef __ACCELEROMETER_AXIS_H
#define __ACCELEROMETER_AXIS_H

#include <WProgram.h>

#define DEJITTERCNT 20
#define CALIBRATECNT 20

class AccelerometerAxis
  {
  protected:
    int m_nPin;
    int m_nReferencePoint;
        
    bool m_bIsCalibrated;
    bool m_bIsDejittered;
    
  protected:
    int dejitter();

  public:
    AccelerometerAxis(int nPin, bool bShouldCalibrate = true, bool bShouldDejitter = true);

    void calibrate();
    
    int getReferencePoint();
    int getPosition(bool bRelative);
  };

#endif  __ACCELEROMETER_AXIS_H

