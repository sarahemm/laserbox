// Config - Handle storing and retrieving configuration information.

#include "Config.h"
struct lbConfig configRunning;

SUI_DeclareString(config_cmd,         "config");
SUI_DeclareString(config_help,        "Configuration menu");
SUI_DeclareString(config_write_cmd,   "write");
SUI_DeclareString(config_write_help,  "Save running configuraton to EEPROM");
SUI_DeclareString(config_reset_cmd,   "reset");
SUI_DeclareString(config_reset_help,  "Reset running configuration to defaults");
SUI_DeclareString(config_show_cmd,   "show");
SUI_DeclareString(config_show_help,  "Show running configuration");

void configInit(void) {
  EEPROM.get(0, configRunning);
  if(strcmp(configRunning.magic, "LBc") != 0) {
    debugMessage("Startup configuration is invalid, creating new config.");
    configCreate();
  }
  if(configRunning.cfgVersion != CFG_VERSION) {
    char buf[64];
    sprintf(buf, "Startup config is version %d but current is %d, creating new config.", configRunning.cfgVersion, CFG_VERSION);
    debugMessage(buf);
    configCreate();
  }
}


void configInitMainMenu(SUI::Menu *mainMenu) {
  // config menu
  SUI::Menu *configMenu = mainMenu->subMenu(config_cmd, config_help);
  configMenu->setName(config_help);
  configMenu->addCommand(config_write_cmd, configSave, config_write_help);
  configMenu->addCommand(config_reset_cmd, configCreate, config_reset_help);
  configMenu->addCommand(config_show_cmd, configShow, config_show_help);
}

void configCreate(void) {
  strcpy(configRunning.magic, "LBc");
  configRunning.cfgVersion = CFG_VERSION;
  
  configRunning.motionTimeout = DEFAULT_MOTION_TIMEOUT;
}

void configShow(void) {
  char buf[32];
  sprintf(buf, "Motion timeout: %d", configRunning.motionTimeout);
  debugUI.println(buf);
}

void configSave(void) {
  EEPROM.put(0, configRunning);
  debugMessage("Configuration saved to EEPROM.");  
}

