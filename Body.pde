import java.math.BigDecimal;

class Body {

  Vector pos;
  Vector vel;

  double mass;
  double radius;
  color _color;

  ArrayList<Vector> trailPoints = new ArrayList<Vector>();

  Body(String _x, String _y, String _vx, String _vy, String _m, String _r, color _c)
  {
    this.pos = new Vector(_x, _y);

    this.vel = new Vector(_vx, _vy);

    this.mass = bd(_m);
    this.radius = bd(_r);
    this._color = _c;
  }

  void simulate(ArrayList<Body> others)
  {
    for (int i = others.size()-1; i >= 0; i--)
    {
      Body other = others.get(i);

      if (other == this)
        continue;
        
      double r = pos.dist(other.pos);
      
      double m = mass;
      double M = other.mass;
      
      double GmM = G * m*M;
      
      double r2 = r * r;
      
      double f = GmM / r2;
      
      double a = (f / mass) * Time.dt();
      
      Vector dir = other.pos.sub(pos).normalized();
      
      vel = vel.add( dir.mult(a) );
    }
  }

  void tick()
  {
    pos = pos.add(vel.mult( bd(Time.dt()) ));
  }

  void draw()
  {
    drawTrail();
    
    fill(_color, 255);
    
    float x = width/2;
    float y = height/2;
    
    Vector viewPos = pos.div(scaleFactor).sub(viewOffset);
    
    circle((float) viewPos.x, (float) viewPos.y, (float)(radius / scaleFactor) );

    
    if (frameCount % 3 == 0)
      trailPoints.add(pos);

    if (trailPoints.size() > TRAIL_LENGTH)
      trailPoints.remove(0);
  }

  void drawTrail()
  {
    if (trailPoints.size() < 2)
      return;

    stroke(_color);
    strokeWeight(1);
    noFill();

    beginShape();

    for (int i = 0; i < trailPoints.size(); i++)
    {

      Vector p = trailPoints.get(i);
      
      Vector viewPos = p.div(scaleFactor).sub(viewOffset);
      vertex((float)viewPos.x, (float)viewPos.y);
    }

    endShape();
  }
}
