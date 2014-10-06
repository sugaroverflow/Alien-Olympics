int buttonPin1=2;
int buttonPin2=3;
int buttonPin3=8;
int buttonPin4=9;
int buttonPin5=10;

int buttonState1 = 0;
int buttonState2 = 0;
int buttonState3 = 0;
int buttonState4 = 0;
int buttonState5 = 0;

int photoSensorPin = A3;
int photoSensorValue = 0;

int tiltSensorPin = 4;
int tiltState1 = 0;

int piezoPin1 = A1;
int piezoPin2 = A0;
int piezo1SensorValue = 0;
int piezo2SensorValue = 0;

int threshold = 100;

void setup(){
  Serial.begin(9600);
}

void loop(){
  
   photoSensorValue = analogRead(photoSensorPin);
   piezo1SensorValue = analogRead(piezoPin1);
   piezo2SensorValue = analogRead(piezoPin2);
  photoSensorValue = map(photoSensorValue,0,1023,0,255);
  
  buttonState1 = digitalRead(buttonPin1);
  buttonState2 = digitalRead(buttonPin2);
  buttonState3 = digitalRead(buttonPin3);
  buttonState4 = digitalRead(buttonPin4);
  buttonState5 = digitalRead(buttonPin5);
  tiltState1 = digitalRead(tiltSensorPin);
 
   if (buttonState1 == HIGH)
   {
     Serial.write(230);
     delay(200);
   } 

   if (buttonState2 == HIGH)
   {
     Serial.write(231);
     delay(200);
   } 

   if (buttonState3 == HIGH)
   {
     Serial.write(232);
     delay(100);
   } 
    if (buttonState4 == HIGH)
   {
    Serial.write(233);
    delay(100);
   } 
    if (buttonState5 == HIGH)
   {
     Serial.write(234);
     delay(100);
   } 

   
   if (photoSensorValue < 30)
   {
    Serial.write(3);
    delay(100);
   }  
   
   if (piezo1SensorValue >= 400)
   {
     Serial.write(1);
     delay(300);
   }

   if (piezo2SensorValue >= 100)
   {
     Serial.write(2);
     delay(2000);
   }   
   
   delay(100);
}
