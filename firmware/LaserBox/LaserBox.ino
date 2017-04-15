#define LIGHT_LVL_BRIGHT    12000
#define LIGHT_LVL_DARK      6000

#include <SPI.h>
#include <SD.h>
#include <SerialUI.h>

void setup() {
  // initialize the debugging subsystem so we can interact early if needed
  debugInit();
  
  // initialize the logging subsystem so we can record/report any errors
  logInit();

  // initialize the storage subsystem so we can read patterns and write logs
  storageInit();
  
  // initialize the telemetry subsystem so we can communicate with the outside world
  telemetryInit();

  // initialize the laser subsystem so we can make blinkyness
  laserInit();

  // initialize the fog subsystem so we can make and blow fog
  fogInit();
  
  // initialize the sensor subsystem so we can receive control info
  sensorInit();
}

void loop() {
  // go to sleep while the light is bright
  // TODO: put the Arduino itself into a deeper sleep and use the ambient light interrupt to wake back up
  /*
  if(sensorGetAmbientLight() > LIGHT_LVL_BRIGHT) {
    sensorSleep(true);
    while(sensorGetAmbientLight() > LIGHT_LVL_DARK) {
      delay(15);
    }
    sensorSleep(false);
  }
  */
  // handle any debug events pending
  debugHandleEvents();

  char gestureType[6];  // fits RIGHT<null>, the longest string that can be returned
  byte *patternData;
  byte patternLength;

  if(sensorGetGestureString(gestureType)) {
    Serial.print("Playing [");
    Serial.print(gestureType);
    Serial.println("]");
    patternLength = storageGetRandomPattern(gestureType, &patternData);
    //patternLength = storageGetPattern("ATTRACT/INOUT.LBP", &patternData);
    patternRun(patternData, patternLength);
    free(patternData);
  }
  
  delay(250);
}
