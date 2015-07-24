# Thanks to Jesse Farmer [https://github.com/jfarmer] for showing me this concept,
# as I was looking for ways to accurately calculate high powers of "phi",
# which is the furtherest thing from a rational number...

# Defining a custom class to represent "phi" AKA the golden ratio (1 + sqrt(5))/2
# Using Rational arithmetic to preserve the accuracy of computations of "phi"
# Key identities:
#   phi**2 = 1 + phi
#   1/phi = phi - 1 therefore 1 - phi = -(1/phi)
#   1/(a + b*phi) = (a + b - b*phi)/(a**2 + ab - b**2)

class PhiRational
  attr_reader :a, :b
  def initialize(a, b)
    @a, @b = Rational(a), Rational(b)
  end

  def to_s
    return "(#{a}) + (#{b})*phi"
  end

  def ==(other)
    return a == other.a && b == other.b
  end

  def +(other)
    return PhiRational.new(a + other.a, b + other.b)
  end

  def -(other)
    return self + other.inverse
  end

  def *(other)
    c = other.a
    d = other.b
    return PhiRational.new(a * c + b * d, a * d + b * c + b * d)
  end

  def /(other)
    return self * other.reciprocal
  end

  def **(n)
    base   = self.dup
    result = PhiRational.new(1, 0)
    while n > 0
      if n[0] == 1 # when the power is odd
        result *= base
        n -= 1
      end
      base *= base
      n /= 2 # eventually the power will be reduced to 1
    end
    return result
  end

  def inverse
    return PhiRational.new(-a, -b)
  end

  def det
    return Rational(a**2 + a * b - b**2)
  end

  def reciprocal
    return PhiRational.new(Rational(a + b, self.det), Rational(-b, self.det))
  end

  def to_f #converts the PhiRational object to a float.
    return a + (b / 2) * (1 + Math.sqrt(5))
  end
end

# tests that all methods work properly
if __FILE__ == $PROGRAM_NAME
  n = PhiRational.new(2,3)
  m = PhiRational.new(1,5)
  # helper methods that exponentiates by multiplying the base = 1 by n one by one.
  test_helper = lambda do |x|
    base = PhiRational.new(1, 0)
    x.times { base *= n }
    return base
  end

  puts 'testing with variables n and m'
  puts "n : #{n}"
  puts "m : #{m}"
  p n + m == PhiRational.new(3, 8)
  p n - m == PhiRational.new(1, -2)
  p n * m == PhiRational.new(17, 28)
  p n / m == PhiRational.new(Rational(3, 19), Rational(7, 19))
  p n**0  == PhiRational.new(1, 0)
  p n**1  == n
  p n**2  == n * n
  p n**5  == n * n * n * n * n
  p n**10 == test_helper.call(10)
  p n**50 == test_helper.call(50)
end
