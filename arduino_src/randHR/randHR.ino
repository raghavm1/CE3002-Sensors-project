void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  int randHR;
  randHR = random(50,80);
  Serial.println(randHR);
  delay(500);
}
