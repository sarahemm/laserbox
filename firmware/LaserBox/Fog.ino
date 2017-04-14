// Fog - Handles the fog subsystem, including ultrasonic fogger and fans.

#define FAN_A     8
#define FAN_B     7
#define FAN_C     6

#define FOG       44
#define FOG_SENSE 5

void fogInit() {
  pinMode(FAN_A, OUTPUT);
  pinMode(FAN_B, OUTPUT);
  pinMode(FAN_C, OUTPUT);
  pinMode(FOG, OUTPUT);
}

bool fogTest() {
  /*
  debugMessage("FOG ON");
  digitalWrite(FOG, HIGH);
  delay(3000);
  debugMessage("FOG OFF");
  digitalWrite(FOG, LOW);

  digitalWrite(FAN_A, HIGH);
  debugMessage("FAN A ON");
  delay(2000);
  digitalWrite(FAN_A, LOW);
  */
/*  digitalWrite(FAN_B, HIGH);
  debugMessage("FAN B ON");
  delay(2000);
  digitalWrite(FAN_B, LOW);
  digitalWrite(FAN_C, HIGH);
  debugMessage("FAN C ON");
  delay(2000);
  digitalWrite(FAN_C, LOW);
  */

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
  /*digitalWrite(FAN_A, HIGH);
  debugMessage("FAN A + FOG ON");
  delay(7500);
  digitalWrite(FOG, LOW);
  digitalWrite(FAN_A, LOW);
  */
  fogPulse(FAN_A, 5, 1000, 750);
  digitalWrite(FOG, LOW);
  return true;
}

void fogPulse(byte fan, byte nbrPulses, int onTime, int offTime) {
  byte i;
  
  for(i=0; i<nbrPulses; i++) {
    digitalWrite(fan, HIGH);
    delay(onTime);
    digitalWrite(fan, LOW);
    delay(offTime);
  }
}

// returns how many milliamps the fogger is currently drawing
int fogReadCurrent(void) {
  return map(analogRead(FOG_SENSE), 0, 1023, 0, 5000);
}

