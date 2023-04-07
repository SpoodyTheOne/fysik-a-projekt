int SUBSTEPS_AMOUNT = 1000;
int TRAIL_LENGTH = 140;
double G = 6.67408E-11;

double scaleFactor = 1000000000L;

Vector viewOffset = new Vector(0,0);

ArrayList<Body> Bodies = new ArrayList<Body>();

void setup()
{
  fullScreen();
  background(0);
  color(0xff0000);
  noStroke();
  smooth(2);
  
  // The sUN!
  Bodies.add( new Body("0","0", "0","0", "1.989E30", "695508000", #ffffff) );
  
  // Earth
  Bodies.add( new Body("1.495979E11", "0", "0", "-29788", "5.972E24", "6371000", #0000ff) );
  
  viewOffset = new Vector(-width/2, -height/2);
}

void draw()
{
  background(0);
  
  for (int i = 0; i < SUBSTEPS_AMOUNT; i++)
  {
    Time.Tick(millis());
    
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
