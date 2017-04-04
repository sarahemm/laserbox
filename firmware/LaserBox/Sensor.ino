// Sensor - Handles input from the gesture/light sensor.

#include <Wire.h>
#include <SparkFun_APDS9960.h>

#define APDS_INT  2

SparkFun_APDS9960 apds = SparkFun_APDS9960();

void sensorInit() {
  // get the gesture sensor ready
  if(!apds.init()) {
    logError("Unable to initialize gesture sensor.");
    return;
  }
  
  // enable the light sensor without interrupts
  if(!apds.enableLightSensor(false)) {
    logError("Unable to enable ambient light sensor.");
    return;
  }

  // enable the gesture sensor without interrupts
  if(!apds.enableGestureSensor(false)) {
    logError("Unable to enable gesture sensor.");
    return;
  }
}

// put the gesture sensor to sleep or wake it up
void sensorSleep(bool asleep) {
  if(!apds.enableGestureSensor(~asleep)) {
    logError("Unable to enable/disable gesture sensor.");
    return;
  }
}

// get any waiting gestures
byte sensorGetGesture(void) {
  if(apds.isGestureAvailable())
    return apds.readGesture();
  return NULL;
}

bool sensorGetGestureString(char *str) {
  switch(sensorGetGesture()) {
    case DIR_UP:
      strcpy(str, "UP");
      return true;
    case DIR_DOWN:
      strcpy(str, "DOWN");
      return true;
    case DIR_LEFT:
      strcpy(str, "LEFT");
      return true;
    case DIR_RIGHT:
      strcpy(str, "RIGHT");
      return true;
  }
  
  return false;
}

// get the current ambient light level
byte sensorGetAmbientLight(void) {
  uint16_t level;
  if(!apds.readAmbientLight(level)) {
    logError("Unable to read ambient light level.");
    return NULL;
  }
  return level;
}

