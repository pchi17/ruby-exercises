module Fibonacci
  class Matrix
    attr_reader :a, :b, :c, :d
    def initialize(a, b, c, d)
      @a, @b, @c, @d = a, b, c, d
    end
    # models a 2x2 matrix of the form
    #   |a b|
    #   |c d|
    def *(other)
      Matrix.new(
        a * other.a + b * other.c,
        a * other.b + b * other.d,
        c * other.a + d * other.c,
        c * other.b + d * other.d
      )
    end

    def **(n)
      # even though matrix multiplication is not commutative (AB != BA)
      # it IS associative ie: ABC = A(BC)
      # let B = AA, then AB == A(AA) == (AA)A == BA, this implies
      # multiplication is commutative when ONLY 1 matrix is involved,
      # such is the case in exponentiation.
      result = Matrix.new(1, 0, 0, 1)
      return result if n.zero?
      base   = self
      loop do
        if n[0] == 1
          result *= base
          return result if (n -= 1).zero?
        end
        base *= base
        n /= 2
      end
    end

    # methods for inspection and testing
    def ==(other)
      a == other.a && b = other.b && c == other.c && d == other.d
    end

    def to_s
      "|#{a} #{b}|\n|#{c} #{d}|"
    end

    def inspect
      to_s
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  a = Fibonacci::Matrix.new(1, 1, 1, 0)
  p a ** 1  == Fibonacci::Matrix.new(1, 1, 1, 0)
  p a ** 2  == Fibonacci::Matrix.new(2, 1, 1, 1)
  p a ** 3  == Fibonacci::Matrix.new(3, 2, 2, 1)
  p a ** 4  == Fibonacci::Matrix.new(5, 3, 3, 2)
  p a ** 5  == Fibonacci::Matrix.new(8, 5, 5, 3)
  p a ** 10 == Fibonacci::Matrix.new(89, 55, 55, 34)
  p a ** 50 == Fibonacci::Matrix.new(20365011074, 12586269025, 12586269025, 7778742049)
end
