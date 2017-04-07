// Fog - Handles the fog subsystem, including ultrasonic fogger and fans.

#define FAN_A 8
#define FAN_B 7
#define FAN_C 6

void fogInit() {
  pinMode(FAN_A, OUTPUT);
  pinMode(FAN_B, OUTPUT);
  pinMode(FAN_C, OUTPUT);
}

void fogTest() {
  digitalWrite(FAN_A, HIGH);
  delay(2000);
  digitalWrite(FAN_A, LOW);
  digitalWrite(FAN_B, HIGH);
  delay(2000);
  digitalWrite(FAN_B, LOW);
  digitalWrite(FAN_C, HIGH);
  delay(2000);
  digitalWrite(FAN_C, LOW);
}

