
import processing.serial.*;
 
Serial port;  // Create object from Serial class
int val;      // Data received from the serial port
int[] values;
float zoom;
float center;
float scale = 1;
 
void setup() 
{
  size(1280, 720);
  // Open the port that the board is connected to and use the same speed (9600 bps)
  port = new Serial(this, Serial.list()[0], 9600);
  values = new int[width];
  zoom = 1.0f;
  smooth();
}
 
int getY(int val) {
  return (int)(height/2  -(val-512+center)*scale / 1023.0f * (height - 1));
}
 
int getValue() {
  int value = -1;
  while (port.available() >= 3) {
    if (port.read() == 0xff) {
      value = (port.read() << 8) | (port.read());
    }
  }
  return value;
}
 
void pushValue(int value) {
  for (int i=0; i<width-1; i++)
    values[i] = values[i+1];
  values[width-1] = value;
}
 
void drawLines() {
  stroke(0,0,255);
  strokeWeight(2.0);
  int displayWidth = (int) (width / zoom);
  
  int k = values.length - displayWidth;
  
  int x0 = 0;
  int y0 = getY(values[k]);
  for (int i=1; i<displayWidth; i++) {
    k++;
    int x1 = (int) (i * (width-1) / (displayWidth-1));
    int y1 = getY(values[k]);
    line(x0, y0, x1, y1);
    x0 = x1;
    y0 = y1;
  }
}
 
void drawGrid() {
  stroke(255, 0, 0);
  line(0, height/2, width, height/2);
}
 
void keyReleased() {
  println(key+": "+(int)key);
  switch (key) {
    case '4':
    case '*':
      zoom *= 2.0f;
      println(zoom);
      if ( (int) (width / zoom) <= 1 )
        zoom /= 2.0f;
      break;
    case '6':
    case '/':
      zoom /= 2.0f;
      if (zoom < 1.0f)
        zoom *= 2.0f;
      break;
     case '+':     scale*=2;  break;
     case '-':   scale /= 2;  break;
     
     case '8': center += 10/scale; break;
     case '2': center -= 10/scale; break;
     case '5': center = 0; scale = 1; break;  
  }
}
 
void draw()
{
  background(0);
  drawGrid();
  val = getValue();
  if (val != -1) {
    pushValue(val);
  }
  drawLines();
}