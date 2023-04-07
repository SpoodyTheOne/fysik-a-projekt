int SUBSTEPS_AMOUNT = 2000;
int TRAIL_LENGTH = 140;
double G = 6.67408E-11;

double scaleFactor = 1000000000L;

Vector viewOffset = new Vector(0,0);

ArrayList<Body> Bodies = new ArrayList<Body>();

long start = java.lang.System.nanoTime();

void setup()
{
  fullScreen();
  background(0);
  color(0xff0000);
  noStroke();
  smooth(8);
  
  // The sUN!
  Bodies.add( new Body("0","0", "0","0", "1.989E30", "695508000", #ffffff) );
  
  // Mercury
  Bodies.add( new Body("5.983914828E10", "0", "0", "-47100", "3.330E24", "2440000", #67684e) );
  
  // Venus             Dist(sun)             Speed     Mass       Radius
  Bodies.add( new Body("1.047E11", "0", "0", "-35640", "4.87E24", "6050000", #ea9a2a) );
  
  // Earth
  Bodies.add( new Body("1.495979E11", "0", "0", "-29788", "5.972E24", "6371000", #0000ff) );
  
  // Mars              Dist(sun)             Speed     Mass        Radius
  Bodies.add( new Body("2.243E11", "0", "0", "-24322", "0.642E24", "3390000", #e22d12) );
  
  // Jupiter           Dist(sun)             Speed     Mass       Radius
  Bodies.add( new Body("7.779E11", "0", "0", "-13063", "1898E24", "69950000", #e0934c) );
  
  // Saturn            Dist(sun)             Speed    Mass       Radius
  Bodies.add( new Body("1.421E12", "0", "0", "-9664", "568E24", "58300000", #e0b34c) );
  
  // Uranus            Dist(sun)             Speed    Mass       Radius
  Bodies.add( new Body("2.932E12", "0", "0", "-6728", "86.8E24", "25360000", #45e0d6) );
  
  // Neptune           Dist(sun)             Speed    Mass       Radius
  Bodies.add( new Body("4.487E12", "0", "0", "-5438", "102E24", "24600000", #456ce0) );
  
  
  viewOffset = new Vector(-width/2, -height/2);
}

void draw()
{
  background(0);
  
  for (int i = 0; i < SUBSTEPS_AMOUNT; i++)
  {
    Time.Tick(java.lang.System.nanoTime() - start);
    
    for (Body body : Bodies)
    {
      body.simulate(Bodies); 
    }
    
    for (Body body : Bodies)
    {
      body.tick();
    }
  }
  
  for (Body body : Bodies)
  {
    body.draw(); 
  }
  
  fill(#00ff00);
  
  text("Scale: " + scaleFactor, 50, 50);
  text("Time scale: x" + Time.timeScale(), 50,64);
  text("Start: " + millis()/1000, 50,78);
  text("fps: " + frameRate, 50,92);
  
}

void mouseDragged()
{
  println("drag");
  
  Vector current = new Vector(mouseX, mouseY);
  Vector previous = new Vector(pmouseX, pmouseY);
  
  viewOffset = viewOffset.sub(current.sub(previous));
}

void mouseWheel(MouseEvent e)
{
  
  scaleFactor = scaleFactor +  e.getCount() * (scaleFactor/100);
}
