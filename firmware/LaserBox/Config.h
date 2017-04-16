// Config.h - Definitions related to configuration that other modules need to be able to access.

#define CFG_VERSION 0

#define DEFAULT_MOTION_TIMEOUT 3

struct lbConfig {
  char magic[3];
  byte cfgVersion;
  
  byte motionTimeout; // timeout in tens of seconds
};

extern struct lbConfig configRunning;

