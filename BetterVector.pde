import java.math.MathContext;
import java.math.RoundingMode;

class Vector
{
  BigDecimal y;
  BigDecimal x;

  Vector(long _x, long _y)
  {
    this.y = new BigDecimal(_y);
    this.x = new BigDecimal(_x);
  }

  Vector(String _x, String _y)
  {
    this.y = new BigDecimal(_y);
    this.x = new BigDecimal(_x);
  }

  Vector(BigDecimal _x, BigDecimal _y)
  {
    this.x = _x;
    this.y = _y;
  }

  Vector add(Vector other)
  {
    return new Vector(x.add(other.x), y.add(other.y));
  }

  Vector sub(Vector other)
  {
    return new Vector(x.subtract(other.x), y.subtract(other.y));
  }

  Vector div(Vector other)
  {
    return new Vector(x.divide(other.x, RoundingMode.HALF_UP), y.divide(other.y, RoundingMode.HALF_UP));
  }

  Vector mult(Vector other)
  {
    return new Vector(x.multiply(other.x), y.multiply(other.y));
  }

  Vector div(BigDecimal n)
  {
    return new Vector(x.divide(n, RoundingMode.HALF_UP), y.divide(n, RoundingMode.HALF_UP));
  }

  Vector div(long n)
  {
    return this.div(new BigDecimal(n));
  }

  Vector mult(BigDecimal n)
  {
    return new Vector(x.multiply(n), y.multiply(n));
  }

  Vector mult(long n)
  {
    return this.mult(new BigDecimal(n));
  }
  
  BigDecimal magnitude() 
  {
    return (x.pow(2).add(y.pow(2))).sqrt(new MathContext(10, RoundingMode.HALF_UP));  
  }
  
  Vector normalized()
  {
    return div(magnitude());
  }
  
  BigDecimal dist(Vector other)
  {
    return sub(other).magnitude(); 
  }
}
