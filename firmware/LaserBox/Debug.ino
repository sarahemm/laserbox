// Debug - Handle the serial debug interface.

SUI_DeclareString(device_greeting,  "+++ Welcome to the LaserBox Debug Interface +++\r\nEnter '?' to list available options.");

SUI_DeclareString(main_title,         "Main Menu");
SUI_DeclareString(main_verbose_cmd,   "verbose");
SUI_DeclareString(main_verbose_help,  "Enable/disable verbose output");
SUI_DeclareString(main_test_cmd,      "test");
SUI_DeclareString(main_test_help,     "Test and Troubleshooting");
SUI_DeclareString(main_live_cmd,      "live");
SUI_DeclareString(main_live_help,     "Enter live mode");

SUI_DeclareString(test_title,         "Test Menu");

SUI::SerialUI debugUI = SUI::SerialUI(device_greeting);

bool debugVerboseFlag;

void debugInit(void) {
  debugUI.begin(115200);
  debugUI.setTimeout(20000);
  debugUI.setMaxIdleMs(30000);
  
  debugMessage("Debug module ready.");
  debugVerboseFlag = false;
  debugInitMenu();
}

void debugInitMenu(void) {
  // main menu
  SUI::Menu *mainMenu = debugUI.topLevelMenu();
  mainMenu->setName(main_title);
  mainMenu->addCommand(main_verbose_cmd, debugToggleVerbose, main_verbose_help);
  mainMenu->addCommand(main_live_cmd, debugEnterLiveMode, main_live_help);
  
  // test menu
  SUI::Menu *testMenu = mainMenu->subMenu(main_test_cmd, main_test_help);
  testMenu->setName(test_title);

  fogInitTestMenu(testMenu);
  laserInitTestMenu(testMenu);

  configInitMainMenu(mainMenu);
  logInitMainMenu(mainMenu);
}

void debugEnterLiveMode(void) {
  debugUI.exit();
  patternStreamingRun();
}

void debugResponse(char *str) {
  // TODO: properly handle multiline responses
  debugUI.print("R-");
  debugUI.println(str);
}

void debugMessage(char *str) {
  // TODO: properly handle multiline responses
  debugUI.print("U-");
  debugUI.println(str);
}

void debugVerbose(char *str) {
  if(debugVerboseFlag) debugMessage(str);
}

void debugToggleVerbose(void) {
  if(debugVerboseFlag) {
    debugUI.println("Verbose mode is now off.");
    debugVerboseFlag = false;
  } else {
    debugUI.println("Verbose mode is now on.");
    debugVerboseFlag = true;
  }

}

void debugHandleEvents(void) {
  if(debugUI.checkForUser(150)) {
    debugUI.enter();
    while(debugUI.userPresent()) {
      debugUI.handleRequests();
    }
  }
}

