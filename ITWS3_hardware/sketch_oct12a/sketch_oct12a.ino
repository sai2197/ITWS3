#define ANALOG_IN1 0
//#define ANALOG_IN2 1


void setup() {
 // Serial.begin(9600); 
  Serial.begin(9600); 
}

void loop() {
  int val = analogRead(ANALOG_IN1);
 // int val2 = analogRead(ANALOG_IN2);  
   
  Serial.print(val,DEC);
 
 // delay(50); //This may be able to be faster than 50ms                                            
  Serial.write(0xff);                                                         
  Serial.write( (val >> 8) & 0xff );                                            
  Serial.write(val>>8 & 0xff);
}
