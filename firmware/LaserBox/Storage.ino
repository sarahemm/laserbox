// Storage - Handle communication with the SD card.

#define STORAGE_SD_CS_PIN  10

void storageInit(void) {
  if(!SD.begin(STORAGE_SD_CS_PIN)) {
    logError("Unable to open SD card.");
    return;
  }
}

// read all pattern data from a specific pattern file, return the length of it
// returns a pointer which must be freed when done with it!
// TODO: DRY this with storageGetRandomPattern
int *storageGetPattern(char *patternFilename, byte **patternData) {
  File patternFile;
  byte patternLength;
  
  patternFile = SD.open(patternFilename);
  patternLength = patternFile.available();
  *patternData = malloc(patternLength); // TODO: should read from the file bit by bit as we parse, ideally
  if(patternData == NULL) {
    debugMessage("Failed to allocate memory for pattern.");
    patternFile.close();
    return 0;
  }
  patternFile.read(*patternData, patternLength);
  patternFile.close();

  return patternLength;
}

// read all pattern data from a random file of a provided type, return the length of it
// returns a pointer which must be freed when done with it!
int *storageGetRandomPattern(char *patternType, byte **patternData) {
  File patternDir;
  File patternFile;
  byte patternLength;

  patternDir = SD.open(patternType);
  if(!patternDir) {
    debugMessage("Unable to open random pattern.");
    return 0;
  }
  patternFile = storageOpenRandomFile(patternDir);
  patternDir.close();
  patternLength = patternFile.available();
  *patternData = malloc(patternLength); // TODO: should read from the file bit by bit as we parse, ideally
  if(patternData == NULL) {
    debugMessage("Failed to allocate memory for pattern.");
    patternFile.close();
    return 0;
  }
  patternFile.read(*patternData, patternLength);
  patternFile.close();

  return patternLength;
}

// return how many files are in a directory (useful for then choosing one at random)
int storageCountFiles(File dir) {
  int nbrFiles = 0;
  
  while(dir.openNextFile()) {
    nbrFiles++;
  }
  dir.rewindDirectory();
  Serial.print("Found ");
  Serial.print(nbrFiles);
  Serial.println(" files in directory.");
  
  return nbrFiles;
}

// open a random file in a given open directory
File storageOpenRandomFile(File dir) {
  byte fileNbrToOpen;
  byte i;

  fileNbrToOpen = random(0, storageCountFiles(dir));
  Serial.print("Opening file ");
  Serial.println(fileNbrToOpen, DEC);
  for(i=0; i<fileNbrToOpen; i++) {
    Serial.print("c: ");
    Serial.println(i, DEC);
    dir.openNextFile();
  }
  
  return dir.openNextFile();
}

