// Log - Handle notification of errors and such.

#include <RTClib.h>

SUI_DeclareString(clock_cmd,      "clock");
SUI_DeclareString(clock_help,     "Clock menu");
SUI_DeclareString(clock_get_cmd,  "get");
SUI_DeclareString(clock_get_help, "Get current time");
SUI_DeclareString(clock_set_cmd,  "set");
SUI_DeclareString(clock_set_help, "Set clock");

RTC_PCF8523 rtc;

void logInit(void) {
  if(!rtc.begin()) {
    debugMessage("Unable to communicate with RTC.");
    return;
  }
  if(!rtc.initialized()) debugMessage("Clock is not set.");
}

void logInitMainMenu(SUI::Menu *mainMenu) {
  // clock menu
  SUI::Menu *clockMenu = mainMenu->subMenu(clock_cmd, clock_help);
  clockMenu->setName(clock_help);
  clockMenu->addCommand(clock_get_cmd, clockShowTime, clock_get_help);
  clockMenu->addCommand(clock_set_cmd, clockSetTime, clock_set_help);
}

void logError(char *txt) {
  debugMessage(txt);
  // TODO: log to file as well
}

void clockShowTime(void) {
  char buf[32];
  
  DateTime now = rtc.now();
  sprintf(buf, "Clock: %d-%02d-%02d, %02d:%02d:%02d\n", now.year(), now.month(), now.day(), now.hour(), now.minute(), now.second());
  debugUI.print(buf);
}

void clockSetTime(void) {
  debugUI.print(F("Year"));
  debugUI.showEnterNumericDataPrompt();
  short year = debugUI.parseInt();

  debugUI.print(F("\nMonth"));
  debugUI.showEnterNumericDataPrompt();
  short month = debugUI.parseInt();

  debugUI.print(F("\nDay"));
  debugUI.showEnterNumericDataPrompt();
  short day = debugUI.parseInt();

  debugUI.print(F("\nHour"));
  debugUI.showEnterNumericDataPrompt();
  short hour = debugUI.parseInt();

  debugUI.print(F("\nMinute"));
  debugUI.showEnterNumericDataPrompt();
  short minute = debugUI.parseInt();
  debugUI.print("\n");

  rtc.adjust(DateTime(year, month, day, hour, minute, 00));
}

