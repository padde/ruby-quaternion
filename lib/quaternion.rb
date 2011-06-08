require 'mathn'

class Quaternion < Numeric
  attr_accessor :a, :b, :c, :d
    
  def initialize a=0, b=0, c=0, d=0
    @a = a
    @b = b
    @c = c
    @d = d
  end
  
  def real
    @a
  end
  alias :re :real
    
  def imaginary
    Vector[@b,@c,@d]
  end
  alias :im :imaginary
  
  def length
    Math::sqrt( @a**2 + @b**2 + @c**2 + @d**2 )
  end
  alias :norm :length
  
  def conjugate
    Quaternion.new( @a, -@b, -@c, -@d )
  end
  
  def inverse
    self.conjugate / self.length**2
  end
  
  def unify
    self / self.length
  end
  
  def + other
    Quaternion.new( @a+other.a, @b+other.b, @c+other.c, @d+other.d )
  end
  
  def - other
    Quaternion.new( @a-other.a, @b-other.b, @c-other.c, @d-other.d )
  end
  
  def * other
    if other.is_a? Quaternion
      Quaternion.new( @a*other.a - @b*other.b - @c*other.c - @d*other.d,
                      @a*other.b + @b*other.a + @c*other.d - @d*other.c,
                      @a*other.c - @b*other.d + @c*other.a + @d*other.b,
                      @a*other.d + @b*other.c - @c*other.b + @d*other.a )
    else 
      Quaternion.new( @a*other, @b*other, @c*other, @d*other )
    end
  end
  
  def / other
    if other.is_a? Quaternion
      self * other.inverse
    else 
      self * (1/other)
    end
  end
  
  def == other
    if other.is_a? Quaternion
      @a == other.a and @b == other.b and @c == other.c and @d == other.d
    else
      false
    end
  end
  
  def to_s
    "#{@a}#{pip @b}i#{pip @c}j#{pip @d}k"
  end
  
  def self.rotate point, axis, angle
    phi_half = (angle/180.0*Math::PI)/2.0
    
    p = Quaternion.new( 0.0, *point )
  
    axis = axis.collect{ |c| Math::sin(phi_half)*c }
    r = Quaternion.new( Math::cos(phi_half), *axis )
    
    p_rotated = r * p * r.inverse
    
    Vector[p_rotated.b, p_rotated.c, p_rotated.d]
  end
  
private
  def plus_if_positive x
    if x > 0
      "+#{x}"
    else
      x.to_s
    end
  end
  alias :pip :plus_if_positive
end