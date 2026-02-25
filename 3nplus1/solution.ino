long cycleLength(unsigned long n) {
  unsigned long length = 1;

  while(n!=1) {
    if(n%2==0) 
      n = n/2;
    else 
      n=3*n+1;

    length++;
  }
  return length;
}

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  while(!Serial);

  Serial.println("Enter Two numbers (i j):");
}

void loop() {
  // put your main code here, to run repeatedly:
  if(Serial.available()) {
    unsigned long i = Serial.parseInt();
    unsigned long j = Serial.parseInt();

    if(i>0 && j>0) {
      unsigned long start = min(i,j);
      unsigned long end = max(i,j);

      unsigned long maxCycle = 0;

      for(unsigned long k = start;k<=end;k++) {
        unsigned long length = cycleLength(k);
        if(length>maxCycle) {
          maxCycle = length;
        }
      }

      Serial.print(i);
      Serial.print(" ");
      Serial.print(j);
      Serial.print( " ")
      Serial.println(maxCycle);
    
      Serial.println("Enter next pair: ");
    }
  }
}
