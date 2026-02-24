String name = "";

void setup() {
    Serial.begin(9600);
    Serial.print("Enter your name:");
}

void loop() {
    if(Serial.available()) {
        String name = Serial.readStringuntil("\n");
        Serial.print("Hello, ");
        Serial.print(name);
    }
}