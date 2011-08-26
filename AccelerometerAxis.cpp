#include "AccelerometerAxis.h"

void* operator new(size_t size) { return malloc(size); }
void operator delete(void* ptr) { if (ptr) free(ptr); } 

AccelerometerAxis::AccelerometerAxis(int nPin, bool bShouldCalibrate, bool bShouldDejitter) :
  m_nPin(nPin),
  m_bIsDejittered(bShouldDejitter)
  {
  if(bShouldCalibrate)
    calibrate();
  }

void AccelerometerAxis::calibrate()
  {
  int nCalibrationBuffer = 0;

  for(int i = 0; i < CALIBRATECNT; i++)
    {
    nCalibrationBuffer += analogRead(m_nPin);
    delay(1);
    }

  m_nReferencePoint = nCalibrationBuffer / CALIBRATECNT;
  m_bIsCalibrated = true;
  }

int AccelerometerAxis::getReferencePoint()
  {
  return m_nReferencePoint;
  }

int AccelerometerAxis::getPosition(bool bRelative)
  {
  int nPosition = 0;
  
  if(m_bIsDejittered)
    {
    nPosition = dejitter();  

    if(bRelative)
      {
      nPosition = (abs(nPosition - m_nReferencePoint) < 3) ? 0 : (nPosition - m_nReferencePoint < 0) ? nPosition - m_nReferencePoint + 2 : nPosition - m_nReferencePoint - 2; 
      }
    }
  else
    {
    nPosition = analogRead(m_nPin);

    if(bRelative)
      {
      nPosition = nPosition - m_nReferencePoint; 
      }
    }
  

  return nPosition;
  }

int AccelerometerAxis::dejitter()
  {
  int nDejitteringBuffer = 0;
  
  for(int i = 0; i < 10; i++)
    {
    nDejitteringBuffer += analogRead(m_nPin);
    delay(1);
    }

  return nDejitteringBuffer / 10;
  }
