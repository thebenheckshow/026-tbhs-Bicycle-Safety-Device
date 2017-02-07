//Super Bike Safety Thing
//Benjamin J Heckendorn 8-15-11


int RightSense = 34; //Pin the sensor is hooked up to
int LeftSense = 35; //Pin the sensor is hooked up to

int green = 6;
int lred = 9;
int rred = 5;
int Buzzer = 36;

int Left = 0;
int Right = 0;

int Brightness = 0;

int Inches = 0;
int Blink = 0;
int Good = 0;
int Counter = 0;
int GreenOut = 100;

void setup() {

  //Serial.begin(9600); 

  pinMode(34, OUTPUT);  
  pinMode(35, OUTPUT);  
  pinMode(36, OUTPUT);

  pinMode(lred , OUTPUT);  
  pinMode(rred, OUTPUT);  
  pinMode(green, OUTPUT);  

}  


void loop() {

  SetBrightness();
  Good = 0;
  
  Distance(LeftSense); //Get left distance, in inches, off Pin 33
  
  if (Inches < 45) { //Is something closer than 45 inches?
    if (Blink > 10) {
      analogWrite(lred, Brightness);
    }
    else
    {
      analogWrite(lred, 0);      
    }
    
    digitalWrite(green, 0);
    Counter = 0;
    Blink += 1;
  }
  else {
    digitalWrite(lred, 0);
    Good += 1;
  }

  Distance(RightSense);

  if (Inches < 45) { //Is something closer than 45 inches?
    if (Blink > 10) {
      analogWrite(rred, Brightness);
    }
    else
    {
      analogWrite(rred, 0);      
    }
    
    digitalWrite(green, 0);
    Counter = 0;
    Blink += 1;
  }
  else {
    digitalWrite(rred, 0);
    Good += 1;
  }

  if (Blink > 20) {
    Blink = 0;
  }

  if (Good == 2 and Counter < GreenOut) {  //Both sensors clear?
    analogWrite(green, Brightness);
    Counter += 1;
    digitalWrite(Buzzer, 0);
  } 

  if (Good == 2 and Counter == GreenOut) {  //Both sensors clear?
    digitalWrite(green, 0);
  } 


}  


void Distance(unsigned char ppin) {

  Inches = 0;
  
  digitalWrite(ppin, 0);   //Clear I/O Pin 
  pinMode(ppin, OUTPUT);        //Make pin output
  digitalWrite(ppin, 1);   //Set I/O pin high
  delayMicroseconds(2);    //Wait 2 us
  digitalWrite(ppin, 0);   //Set I/O pin low
  pinMode(ppin, INPUT);        //Set I/O pin to input

while (digitalRead(ppin) == 0) { //Wait for pin to go HIGH
}

while (digitalRead(ppin) == 1) { //Wait for pin to go LOW
  Inches += 1;
}

Inches /= 215; //Convert to inches

//Serial.println(Inches, DEC);
  
}  

void SetBrightness() {

  Brightness = analogRead(5);

  Brightness -= 400; //Set baseline value to effective range
  
  Brightness /= 2.5;
  
  if (Brightness < 17) {
    
    Brightness = 10;
    
  }  
  
  //Serial.println(Brightness, DEC);  

}  

  
