// Pattern - Handle parsing of pattern code.

// if we don't have enough bytes for parameters yet, return how many bytes we /did/
// consume and we'll get the rest next tme
#define checkIfParamsAvailable(b) if(codePtr - code + b + 1 > code_len) return codePtr - code

// Run pattern data as it comes in over the serial port
byte patternStreamingRun(void) {
  byte buf[255];
  byte buflen = 0;
  byte bytes_consumed;

  Serial.setTimeout(100);
  while(1) {
    while(!Serial.available()) { }
    buflen += Serial.readBytes(&buf[buflen], 255-buflen);
    //Serial.print("Buffer is now of length ");
    //Serial.println(buflen, DEC);
    bytes_consumed = patternExecute(buf, buflen, false);
    if(bytes_consumed == -1) continue;  // if we get an error, just try again
    //Serial.print("Execution run consumed ");
    //Serial.print(bytes_consumed, DEC);
    //Serial.println(" bytes.");
    if(bytes_consumed > 0) memmove(&buf[0], &buf[bytes_consumed], buflen-bytes_consumed);
    buflen -= bytes_consumed;
  }
}

// Run pattern data from a buffer
byte patternRun(byte *code, byte code_len) {
  patternExecute(code, code_len, true);
  laserClear();
  laserRefresh();
}

byte patternExecute(byte *code, byte code_len, bool check_magic) {
  byte *codePtr;
  
  byte plane;
  byte row;
  byte col;
  byte val;

  codePtr = code;

  // in streaming mode we don't have magic to deal with
  if(check_magic) {
    if(code_len < 5) return -1; // data can't be a Pattern v2 file because it's not long enough
    if(strncmp(codePtr, "PATv2", 5) != 0) return -2; // data is not a Pattern v2 file, no magic bytes
    codePtr = code + 5;
  }
  
  debugVerbose("Pattern magic OK, executing.");
  while(codePtr - code < code_len) {
    switch(*codePtr) {
      case 0x00:
        // NoOp - Don't do anything.
        break;
      case 0x01:
        // Delay - Wait a certain amount of time then continue.
        checkIfParamsAvailable(1);
        debugVerbose("Executing pattern cmd 'delay'");
        codePtr++;
        delay(*codePtr * 5);
        break;
      case 0x02:
        // Load Plane - Load pixel data into a given plane.  
        checkIfParamsAvailable(7);
        debugVerbose("Executing pattern cmd 'load plane'");
        codePtr++;
        plane = *codePtr;
        codePtr++;
        laserLoadPlane(plane, codePtr);
        codePtr += 5;
        break;
      case 0x03:
        // Load Pixel and Refresh - Load one pixel of data and refresh the display.
        checkIfParamsAvailable(1);
        debugVerbose("Executing pattern cmd 'load pixel and refresh'");
        codePtr++;
        plane = (*codePtr & 0x80) >> 7; // msb
        row   = (*codePtr & 0x70) >> 4; // three bits after the msb
        col   = (*codePtr & 0x0E) >> 1; // three bits before the lsb
        val   = *codePtr & 0x01;        // lsb
        laserLoadPixel(plane, row, col, val);
        laserRefresh();
        break;
      case 0x04:
        // Refresh All Planes - Push loaded pixel data from the framebuffer into the display
        laserRefresh();
        debugVerbose("Executing pattern cmd 'refresh'");
        break;
      case 0xFF:
        return -1;
        break;
    }
    codePtr++;
  }

  // return how many bytes out of the buffer we consumed
  return codePtr - code;
}

