import java.math.BigDecimal;

class Body {

  Vector pos;
  Vector vel;

  BigDecimal mass;
  BigDecimal radius;
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
        
      BigDecimal r = pos.dist(other.pos);
      
      BigDecimal m = mass;
      BigDecimal M = other.mass;
      
      BigDecimal GmM = G.multiply( m.multiply(M) );
      
      BigDecimal r2 = r.multiply(r);
      
      BigDecimal f = GmM.divide( r2, RoundingMode.HALF_UP );
      
      BigDecimal a = f.divide(mass).multiply( bd(Time.dt()) );
      
      Vector dir = other.pos.sub(pos).normalized();
      
      vel = vel.add( dir.mult(a).mult( bd(Time.dt()) ) );
    }
  }

  void tick()
  {
    pos = pos.add(vel);
  }

  void draw()
  {
    drawTrail();
    
    fill(_color, 255);
    
    float x = width/2;
    float y = height/2;
    
    Vector viewPos = pos.div(scaleFactor).sub(viewOffset);
    
    circle(viewPos.x.floatValue(), viewPos.y.floatValue(), radius.divide(scaleFactor, RoundingMode.HALF_UP).floatValue() );

    
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
      vertex(viewPos.x.floatValue(), viewPos.y.floatValue());
    }

    endShape();
  }
}
