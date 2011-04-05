//debounce delay
#define DELAY 250

//buttons!
#define BUTTON1 2
#define BUTTON2 3

//button values
int val1 = 0;
int old_val1 = 0;

//button 2 values
int val2 = 0;
int old_val2 = 0;


void setup(){
  pinMode(BUTTON1, INPUT);
  pinMode(BUTTON2, INPUT);  
  Serial.begin(9600);
}

void loop(){
  val1 = digitalRead(BUTTON1);
  val2 = digitalRead(BUTTON2);
  
  if(released(val1, old_val1)){
    Serial.print("1");
    delay(DELAY);
  }
  
  if(released(val2, old_val2)){
    Serial.print("2");
    delay(DELAY); 
  }
   
  old_val1 = val1;
  old_val2 = val2;
}

int released(int val, int old_val){
  return ((val == HIGH) && (old_val == LOW));  
}
