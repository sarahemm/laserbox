// Laser - Handle controlling all the lasers.

#define LASER_CLK 30
#define LASER_DAT 40
#define LASER_LAT 32

#define LASER_PLANE_YZ 0
#define LASER_PLANE_XY 1

// XY Plane - Lasers firing from bottom up
//            X is left/right when looking down at the plate from the front
//            Y is forward/back

// YZ Plane - Lasers firing from left to riht
//            Z is up/down when looking down at the plate from the front
//            Y is forward/back

// convert Plane, Y Coord, and A Coord to the bit number representing that specific laser
#define laserPYAtoLaserBit(p, y, a) p*48 + y*8 + a

// convert Plane, Channel, and Status Bit Number to the bit number representing that specific status LED
#define laserPCStoStatusBit(p, c, s) p*48 + c*8 + 6 + s

// Bit Numbers
// 0-5   - XY Plane Channel 0 Lasers
// 6-7   - XY Plane Channel 0 Status
// 8-13  - XY Plane Channel 1 Lasers
// 14-15 - XY Plane Channel 1 Status
// 16-21 - XY Plane Channel 2 Lasers
// 22-23 - XY Plane Channel 2 Status
// 24-29 - XY Plane Channel 3 Lasers
// 30-31 - XY Plane Channel 3 Status
// 32-37 - XY Plane Channel 4 Lasers
// 38-39 - XY Plane Channel 4 Status
// 40-45 - XY Plane Channel 5 Lasers
// 46-47 - XY Plane Channel 5 Status
// ---
// 48-53 - YZ Plane Channel 0 Lasers
// 54-55 - YZ Plane Channel 0 Status
// 56-61 - YZ Plane Channel 1 Lasers
// 62-63 - YZ Plane Channel 1 Status
// 64-69 - YZ Plane Channel 2 Lasers
// 70-71 - YZ Plane Channel 2 Status
// 72-77 - YZ Plane Channel 3 Lasers
// 78-79 - YZ Plane Channel 3 Status
// 80-85 - YZ Plane Channel 4 Lasers
// 86-87 - YZ Plane Channel 4 Status
// 88-93 - YZ Plane Channel 5 Lasers
// 94-95 - YZ Plane Channel 5 Status

byte laserFramebuffer[12];

void laserInit(void) {
  pinMode(LASER_CLK, OUTPUT);
  pinMode(LASER_DAT, OUTPUT);
  pinMode(LASER_LAT, OUTPUT);
  
  digitalWrite(LASER_CLK, LOW);
  digitalWrite(LASER_LAT, LOW);
  laserClear();
  laserRefresh();
}

void laserClear(void) {
  memset(&laserFramebuffer, 0, 12);
}

// load data into the framebuffer
void laserLoadPlane(byte plane, byte *data) {
  memcpy(&laserFramebuffer[plane * 6], data, 6);
}

// update one pixel in the framebuffer
void laserLoadPixel(byte plane, byte row, byte col, byte val) {
  byte laser_bit = laserPYAtoLaserBit(plane, row, col);
  bitWrite(laserFramebuffer[laser_bit / 8], laser_bit % 8, val);
}

// update one status led in the framebuffer
void laserLoadStatus(byte plane, byte chan, byte led, byte val) {
  byte status_bit = laserPCStoStatusBit(plane, chan, led);
  bitWrite(laserFramebuffer[status_bit / 8], status_bit % 8, val);
}

// load the framebuffer into the shift registers, then latch the contents into the output registers (i.e. display the framebuffer)
void laserRefresh(void) {
  byte row;

  // shift everything from the framebuffer into the shift registers' storage register
  for(row = 0; row <= 11; row++) {
    shiftOut(LASER_DAT, LASER_CLK, MSBFIRST, laserFramebuffer[11-row]);
  }

  // data is all shifted in, latch the shift registers now to display the new pattern
  digitalWrite(LASER_LAT, HIGH);
  //delay(100); // TODO: check what this value should actually be
  digitalWrite(LASER_LAT, LOW);
}

// Run the laser self-test routine, light each laser in sequence
byte laserTest(void) {
  byte plane, x, y, chan, led;

  // test the status LEDs
  for(plane=0; plane<=1; plane++) {
    for(chan=0; chan<=5; chan++) {
      for(led=0; led<=1; led++) {
        laserLoadStatus(plane, chan, led, 1);
        laserRefresh();
        delay(200);
        laserLoadStatus(plane, chan, led, 0);
      }
    }
  }
  
  // test the laser outputs themselves
  for(plane=0; plane<=1; plane++) {
    for (y=0; y<=5; y++) {
      for (x=0; x<=5; x++) {
        laserLoadPixel(plane, y, x, 1);
        laserRefresh();
        delay(200);
        laserLoadPixel(plane, y, x, 0);
      }
    }
  }

  return 1;
}

