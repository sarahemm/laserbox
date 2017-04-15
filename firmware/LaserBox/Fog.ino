// Fog - Handles the fog subsystem, including ultrasonic fogger and fans.

#define FAN_A     8
#define FAN_B     7
#define FAN_C     6

#define FOG       44
#define FOG_SENSE 5

SUI_DeclareString(test_fog_cmd,       "fog");
SUI_DeclareString(test_fog_help,      "Fog subsystem tests");

SUI_DeclareString(test_fog_title,     "Fog Test Menu");
SUI_DeclareString(test_fog_seq_cmd,   "sequence");
SUI_DeclareString(test_fog_seq_help,  "Fog sequence test");
SUI_DeclareString(test_fog_man_cmd,   "manual");
SUI_DeclareString(test_fog_man_help,  "Manual fog controls");

SUI_DeclareString(test_fog_man_fog_cmd,     "fog");
SUI_DeclareString(test_fog_man_fog_help,    "Toggle fogger state");
SUI_DeclareString(test_fog_man_fan_a_cmd,   "fan a");
SUI_DeclareString(test_fog_man_fan_a_help,  "Toggle fan A state");
SUI_DeclareString(test_fog_man_fan_b_cmd,   "fan b");
SUI_DeclareString(test_fog_man_fan_b_help,  "Toggle fan B state");
SUI_DeclareString(test_fog_man_fan_c_cmd,   "fan c");
SUI_DeclareString(test_fog_man_fan_c_help,  "Toggle fan C state");


void fogInit() {
  pinMode(FAN_A, OUTPUT);
  pinMode(FAN_B, OUTPUT);
  pinMode(FAN_C, OUTPUT);
  pinMode(FOG, OUTPUT);
}

void fogInitTestMenu(SUI::Menu *testMenu) {
  // test fog menu
  SUI::Menu *testFogMenu = testMenu->subMenu(test_fog_cmd, test_fog_help);
  testFogMenu->setName(test_fog_help);
  testFogMenu->addCommand(test_fog_seq_cmd, fogTestSequence, test_fog_seq_help);

  // test fog manual control menu
  SUI::Menu *testFogManualMenu = testFogMenu->subMenu(test_fog_man_cmd, test_fog_man_help);
  testFogManualMenu->setName(test_fog_man_help);
  testFogManualMenu->addCommand(test_fog_man_fog_cmd, fogTestManualFog, test_fog_man_fog_help);
  testFogManualMenu->addCommand(test_fog_man_fan_a_cmd, fogTestManualFanA, test_fog_man_fan_a_help);
  testFogManualMenu->addCommand(test_fog_man_fan_b_cmd, fogTestManualFanB, test_fog_man_fan_b_help);
  testFogManualMenu->addCommand(test_fog_man_fan_c_cmd, fogTestManualFanC, test_fog_man_fan_c_help);
}

bool fogTestSequence() {
  debugMessage("FOG ON");
  digitalWrite(FOG, HIGH);
  delay(3000);
  debugMessage("FOG OFF");
  digitalWrite(FOG, LOW);

  digitalWrite(FAN_A, HIGH);
  debugMessage("FAN A ON");
  delay(2000);
  digitalWrite(FAN_A, LOW);
  digitalWrite(FAN_B, HIGH);
  debugMessage("FAN B ON");
  delay(2000);
  digitalWrite(FAN_B, LOW);
  digitalWrite(FAN_C, HIGH);
  debugMessage("FAN C ON");
  delay(2000);
  digitalWrite(FAN_C, LOW);
/*
  Serial.print("Inactive Fog I: ");
  Serial.println(fogReadCurrent());
  
  digitalWrite(FOG, HIGH);
  debugMessage("FOG ON");
  
  Serial.print("Startup Fog I: ");
  Serial.println(fogReadCurrent());
  
  delay(1500);
  
  Serial.print("Running Fog I: ");
  Serial.println(fogReadCurrent());
  if(fogReadCurrent() < 500) {
    digitalWrite(FOG, LOW);
    return false;
  }
  fogPulse(FAN_A, 5, 1000, 750);
  digitalWrite(FOG, LOW);
  */
  return true;
}

// toggle the state of the fogger
bool fogTestManualFog(void) {
  digitalWrite(FOG, !digitalRead(FOG));
  if(digitalRead(FOG))
    debugUI.println("Fogger is now on.");
  else
    debugUI.println("Fogger is now off.");
}

// toggle the state of fan A
bool fogTestManualFanA(void) {
  digitalWrite(FAN_A, !digitalRead(FAN_A));
  if(digitalRead(FAN_A))
    debugUI.println("Fan A is now on.");
  else
    debugUI.println("Fan A is now off.");
}

// toggle the state of fan B
bool fogTestManualFanB(void) {
  digitalWrite(FAN_B, !digitalRead(FAN_B));
  if(digitalRead(FAN_B))
    debugUI.println("Fan B is now on.");
  else
    debugUI.println("Fan B is now off.");
}

// toggle the state of fan C
bool fogTestManualFanC(void) {
  digitalWrite(FAN_C, !digitalRead(FAN_C));
  if(digitalRead(FAN_C))
    debugUI.println("Fan C is now on.");
  else
    debugUI.println("Fan C is now off.");

}

void fogPulse(byte fan, byte nbrPulses, int onTime, int offTime) {
  byte i;

  digitalWrite(FOG, HIGH);
  for(i=0; i<nbrPulses; i++) {
    digitalWrite(fan, HIGH);
    delay(onTime);
    digitalWrite(fan, LOW);
    delay(offTime);
  }
  digitalWrite(FOG, LOW);
}

// returns how many milliamps the fogger is currently drawing
int fogReadCurrent(void) {
  return map(analogRead(FOG_SENSE), 0, 1023, 0, 5000);
}

