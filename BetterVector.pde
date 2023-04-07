import java.lang.Math;

class Vector
{
  double y;
  double x;

  Vector(long _x, long _y)
  {
    this.y = (_y);
    this.x = (_x);
  }

  Vector(String _x, String _y)
  {
    this.y = Double.parseDouble(_y);
    this.x = Double.parseDouble(_x);
  }

  Vector(double _x, double _y)
  {
    this.x = _x;
    this.y = _y;
  }

  Vector add(Vector other)
  {
    return new Vector(x + (other.x), y + (other.y));
  }

  Vector sub(Vector other)
  {
    return new Vector(x - (other.x), y - (other.y));
  }

  Vector div(Vector other)
  {
    return new Vector(x / (other.x), y / (other.y));
  }

  Vector mult(Vector other)
  {
    return new Vector(x * (other.x), y * (other.y));
  }

  Vector div(double n)
  {
    return new Vector(x / (n), y / (n));
  }

  Vector div(long n)
  {
    return this.div((n));
  }

  Vector mult(double n)
  {
    return new Vector(x * (n), y * (n));
  }

  Vector mult(long n)
  {
    return this.mult((n));
  }
  
  double magnitude() 
  {
    return java.lang.Math.sqrt(java.lang.Math.pow(x,2) + java.lang.Math.pow(y,2));
  }
  
  Vector normalized()
  {
    return div(magnitude());
  }
  
  double dist(Vector other)
  {
    return sub(other).magnitude(); 
  }
}
