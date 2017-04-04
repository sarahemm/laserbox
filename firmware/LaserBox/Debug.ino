// Debug - Handle the serial debug interface.

bool debugVerboseFlag;

void debugInit(void) {
  Serial.begin(115200);
  debugMessage("Debug module ready.");
  debugVerboseFlag = false;
}

void debugResponse(char *str) {
  // TODO: properly handle multiline responses
  Serial.print("R-");
  Serial.println(str);
}

void debugMessage(char *str) {
  // TODO: properly handle multiline responses
  Serial.print("U-");
  Serial.println(str);
}

void debugVerbose(char *str) {
  if(debugVerboseFlag) debugMessage(str);
}

void debugHandleEvents(void) {
  char cmd, test;
  
  while(Serial.available() > 0) {
    cmd = Serial.read();
    switch(cmd) {
      case 'N':
      case 'n':
        // NoOp
        debugResponse("OK");
        break;
      case 'S':
      case 's':
        // Status report
        debugResponse("Not Implemented"); // TODO: Implement!
        break;
      case 'T':
      case 't':
        // Test mode
        while(!Serial.available()) { }
        test = Serial.read();
        switch(test) {
          case 'L':
          case 'l':
            laserTest();
            debugResponse("LASER OK");
            break;
        }
        break;
      case 'L':
      case 'l':
        // Live mode - accept pattern data via serial
        patternStreamingRun();
        break;
      case 'V':
      case 'v':
        // Verbose output toggle
        debugVerboseFlag = !debugVerboseFlag;
        if(debugVerboseFlag)
          debugMessage("Verbose output enabled.");
        else
          debugMessage("Verbose output disabled.");
        break;
    }
  }
}

