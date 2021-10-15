const int bufferLength = 250;

int buf[bufferLength];

unsigned long timeBuf[bufferLength];

unsigned long p1 = 0, p2 = 0, p3 = 0, p4 = 0, p5 = 0;
int pInd = 0;

int printCycle = 10;
int curCycle = 0;

int hr = 0;

void shiftBuffer(int buf[], int len)
{
  for(int i = 0; i < len-1; ++i)
  {
    buf[i] = buf[i+1];
  }
}

void shiftTimeBuffer(unsigned long buf[], int len)
{
  for(int i = 0; i < len-1; ++i)
  {
    buf[i] = buf[i+1];
  }
}

int findPeakN(int buf[], int len, int N)
{
  bool val = true;
  for(int i = N; i < len-N; ++i)
  {
    val = true;
    for(int j = 1; j < N; ++j)
    {
      if(buf[i-j] > buf[i] && buf[i+j] >= buf[i])
      {
        val = false;
      }
    }
    if(val)
    {
      return i;
    }
  }
  return -1;
}

int findPeak(int buf[], int len)
{
  for(int i = 1; i < len-1; ++i)
  {
    if(buf[i-1] < buf[i] && buf[i] > buf[i-1])
    {
      return i;
    }
  }
  return -1;
}

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  for(int i = 0; i < bufferLength; ++i)
  {
    buf[i] = 0; 
  }
}

void loop() {
  shiftBuffer(buf, bufferLength);
  shiftTimeBuffer(timeBuf, bufferLength);
  buf[bufferLength-1] = analogRead(A0);
  timeBuf[bufferLength-1] = millis();

  //Check Signal
  //Serial.print(buf[bufferLength-1]);

  pInd = findPeakN(buf, bufferLength, 75);
  //Serial.print(",");
  //Serial.print(pInd);

  if(pInd >= 140)
  {
    if(p1 != timeBuf[pInd])
    {
      p5 = p4;
      p4 = p3;
      p3 = p2;
      p2 = p1;
      p1 = timeBuf[pInd];
    }
  }

  ++curCycle;
  if(curCycle == printCycle)
  {
    if(p5 != p4 && p4 != p3 && p3 != p2 && p2 != p1){
      hr = 15000/(p1-p2) + 15000/(p2-p3) + 15000/(p3-p4) + 15000/(p4-p5);
      if(hr < 200 && hr > 40)
      {
        Serial.println(hr);
      }
    }
    //Serial.print(p1);
    //Serial.print(",");
    //Serial.println(p2);
    curCycle = 0;
  }

  delay(0.01);
}
