#define ANALOG_IN A1

void setup() {

  Serial.begin(9600);
}

void loop() {
  int val = analogRead(ANALOG_IN);
  //Serial.write(0xff);
  //Serial.write( (val >> 8) & 0xff );
  Serial.println(val);
  //Serial.write(val);
}

