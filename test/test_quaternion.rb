require "quaternion"
require "test/unit"


class TestQuaternion < Test::Unit::TestCase
  def test_should_have_an_external_constructor
    q = Quaternion(1)
    exp = Quaternion.new( 1, 0, 0, 0 )
    assert_equal exp, q
    
    q = Quaternion(1,2)
    exp = Quaternion.new( 1, 2, 0, 0 )
    assert_equal exp, q
    
    q = Quaternion(1, 2, 3)
    exp = Quaternion.new( 1, 2, 3, 0 )
    assert_equal exp, q
    
    q = Quaternion(1, 2, 3, 4)
    exp = Quaternion.new( 1, 2, 3, 4 )
    assert_equal exp, q
    
    p = Quaternion(q)
    assert_equal q, p
    
    q = Quaternion( 0, Vector[1,2,3] )
    exp = Quaternion.new( 0, 1, 2, 3 )
    assert_equal exp, q
  end
  
  def test_should_have_four_individual_components
    q = Quaternion( 0, 1, 2, 3 )
    exp2 = Quaternion( 7, 1, 2, 3 )
    exp3 = Quaternion( 7, 1, 6, 2 )
    
    q.a += 7
    assert_equal exp2, q
  
    q.c += 4
    q.d -= 1
    assert_equal exp3, q
  end
  
  def test_should_be_able_to_get_real_part
    q = Quaternion( 14/7, 123.7, 9, 12 )
    assert_equal 14/7, q.a
    assert_equal q.real, q.a
    assert_equal q.re, q.a
  end
  
  def test_should_be_able_to_get_imaginary_part
    q = Quaternion( 14/7, 123.7, 9, 12 )
    exp = Vector[123.7, 9, 12]
    assert_equal exp, q.imag
    assert_equal exp, q.im
    assert_equal exp, q.imaginary
  end
  
  def test_should_be_able_to_compute_length
    q = Quaternion( 1, 0, 0, 0 )
    assert_equal 1.0, q.length
    
    q = Quaternion( 0, 1, 0, 0 )
    assert_equal 1.0, q.length
    
    q = Quaternion( 0, 0, 1, 0 )
    assert_equal 1.0, q.length
    
    q = Quaternion( 0, 0, 0, 1 )
    assert_equal 1.0, q.length
    
    q = Quaternion( 1, 6, 3, 2 )
    assert_equal Math::sqrt(50), q.length
  end
  
  def test_should_be_able_to_compute_the_conjugate
    q = Quaternion( 1, 6, 3, 2 )
    exp = Quaternion( 1, -6, -3, -2 )
    assert_equal exp, q.conjugate
  end
  
  def test_should_be_able_to_compute_the_inverse
    q = Quaternion( 2, 2, 2, 2 )
    exp = Quaternion( 1/8, -1/8, -1/8, -1/8 )
    assert_equal exp, q.inverse
  end
  
  def test_should_be_able_to_unify
    q = Quaternion( 24, 7, 8, 234 )
    assert 1.0 - q.unify.length < Float::EPSILON,
      'A unified vector does not have length 1.'
  end
  
  def test_should_be_able_to_compute_sum
    q1 = Quaternion( 2, 7, 8, 23 )
    q2 = Quaternion( 3, 4, 3, 12 )
    exp = Quaternion( 5, 11, 11, 35 )
    assert_equal exp, q1+q2
  end
  
  def test_should_be_able_to_compute_difference
    q1 = Quaternion( 2, 7, 8, 2 )
    q2 = Quaternion( 1, 9, 4, 5 )
    exp = Quaternion( 1, -2, 4, -3 )
    assert_equal exp, q1-q2
  end
  
  def test_should_be_able_to_compute_product_with_scalar
    q = Quaternion( 4, 3, 1, -9 )
    exp = Quaternion( -28, -21, -7, 63 )
    assert_equal exp, q*(-7)
  end
  
  def test_should_be_able_to_compute_product_with_quaternion
    q1 = Quaternion( 4, 3, 1, -9 )
    q2 = Quaternion( 6, 7, -3, 1 )
    exp1 = Quaternion( 15, 20, -72, -66 )
    exp2 = Quaternion( 15, 72, 60, -34 )
    assert_equal exp1, q1*q2
    assert_equal exp2, q2*q1
  end
  
  def test_should_be_able_to_compute_fraction_with_scalar
    q = Quaternion( 4, 3, 1, -9 )
    exp = Quaternion( 2, 1.5, 0.5, -4.5 )
    assert_equal exp, q/2
  end
  
  def test_should_be_able_to_compute_fraction_with_quaternion
    q1 = Quaternion( 4, 3, 1, -9 )
    q2 = Quaternion( 6, 7, -3, 1 )
    exp = Quaternion( 33, -16, -84, 42 )
    assert_equal q1*q2.inverse, q1/q2
  end
  
  
  def test_should_be_able_to_check_for_equality
    q = Quaternion( 0, 1, 2, 3 )
    exp = Quaternion( 0, 1, 2, 3 )
    assert_equal exp, q,
      'Two equivalent quaternions are not recognized as such.'
  end
  
  def test_should_be_able_to_round
    q = Quaternion( 0.1234, 1.2345, 2.3456, 3.4567 )
    exp1 = Quaternion( 0, 1, 2, 3 )
    exp2 = Quaternion( 0.1, 1.2, 2.3, 3.5 )
    assert_equal exp1, q.round
    assert_equal exp2, q.round(1)
    assert_equal q, q.round(10)
  end
  
  def test_should_have_a_proper_string_representation
    q = Quaternion( 0, 1, -2, -3 )
    assert_equal '0+1i-2j-3k', q.to_s,
      'The string representation is not correct for ints.'
  
    q = Quaternion( -0.0, 1.0, 2.0, 3.0 )
    assert_equal '-0.0+1.0i+2.0j+3.0k', q.to_s,
      'The string representation is not correct for floats.'

    q = Quaternion( -1/7, 2/7, 3/7, 4/7 )
    assert_equal '-1/7+2/7i+3/7j+4/7k', q.to_s,
      'The string representation is not correct for fractions.'
  end
  
  def test_should_make_a_rotation_quaternion_from_angle_and_vector
    point = Vector[1.0, 2.0, 3.0] # point to rotate
    axis  = Vector[0.0, 0.6, 0.8] # rotation axis
    angle = 45                    # rotation angle in degrees
    exp   = Vector[0.8485, 2.6125, 2.5406] # rotated point
    
    p = Quaternion::rotate( point, axis, angle )
    p = p.map{ |c| c.round(4) }
    assert_equal exp, p,
      'Quaternion rotation is not performed correctly'
  end
end