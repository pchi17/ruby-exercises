require 'benchmark'
require 'matrix'
require_relative 'fibonacci_matrix'
require_relative 'phi_rational'

# using the 2-dimensional matrix form to quickly generate large fibonacci numbers
MATRIX = Matrix[[1,1],[1,0]]
def matrix(n)
  return (MATRIX**(n - 1))[0, 0]
end

# same logic as above, but using the custom Fibonacci::Matrix defined in ./fibonacci_matrix.rb
# I won't define negative powers for this class just for the case of n = 0.
# alternatively, we can return (FIB_MATRIX**n).b (or c), but that's one more multiplication.
FIB_MATRIX = Fibonacci::Matrix.new(1, 1, 1, 0)
def fib_matrix(n)
  return 0 if n.zero?
  return (FIB_MATRIX**(n - 1)).a
end

# Alternatively, the Binet's formula can also be used
# Binet's formula fib(n) = (phi**n - (1 - phi)**n)/(phi - (1 - phi))
# binet(n) generates the fib(n) with the Binet's formula
def binet(n)
  x = PhiRational.new(0, 1)  # = phi
  y = PhiRational.new(1, -1) # = 1 - phi
  return ((x**n - y**n)/(x - y)).a.to_i
end

# test cases
if __FILE__ == $PROGRAM_NAME
  # I chose to use the convention where 0 is the 0th fibonacci number, 1 is the first, and so it begins...
  # first 300 fibonacci numbers according to "http://www.maths.surrey.ac.uk/hosted-sites/R.Knott/Fibonacci/fibtable.html"

  puts "Testing matrix form"
  p matrix(0)   == 0
  p matrix(1)   == 1
  p matrix(2)   == 1
  p matrix(5)   == 5
  p matrix(10)  == 55
  p matrix(20)  == 6765
  p matrix(100) == 354224848179261915075
  p matrix(300) == 222232244629420445529739893461909967206666939096499764990979600

  puts ''
  puts "Testing custom matrix form"
  p fib_matrix(0)   == 0
  p fib_matrix(1)   == 1
  p fib_matrix(2)   == 1
  p fib_matrix(5)   == 5
  p fib_matrix(10)  == 55
  p fib_matrix(20)  == 6765
  p fib_matrix(100) == 354224848179261915075
  p fib_matrix(300) == 222232244629420445529739893461909967206666939096499764990979600

  puts ''
  puts "Testing Binet's formula"
  p binet(0)   == 0
  p binet(1)   == 1
  p binet(2)   == 1
  p binet(5)   == 5
  p binet(10)  == 55
  p binet(20)  == 6765
  p binet(100) == 354224848179261915075
  p binet(300) == 222232244629420445529739893461909967206666939096499764990979600

  puts ''
  puts "run Benchmark to test the performance of matrix form vs Binet's formula"
  puts "Generating the 300th Fibonacci number 1000 times with both formulae"
  puts ''

  Benchmark.bmbm do |x|
    x.report("Matrix Form") do
      1000.times { matrix(300) }
    end
    x.report("Custom Matrix Form") do
      1000.times { fib_matrix(300) }
    end
    x.report("Binet's Formula") do
      1000.times { binet(300) }
    end
  end

  puts ''
  puts "run Benchmark to test the performance of matrix form vs Binet's formula"
  puts "Generating the 2**18th Fibonacci number 10 times with both formulae"
  puts ''

  Benchmark.bmbm do |x|
    x.report("Matrix Form") do
      10.times { matrix(2**18) }
    end
    x.report("Custom Matrix Form") do
      10.times { fib_matrix(2**18) }
    end
    x.report("Binet's Formula") do
      10.times { binet(2**18) }
    end
  end
end
# Benchmark show that the custom matrix form is almost 3 times faster than ruby's matrix
# and almost 7 times faster than Binet's formula when finding the 300th Fibonacci number.
# however, for large n (2**18), there seems to be no difference between the Ruby's built
# in matrix and the custom matrix.

def fast_fib(n)
  fib_matrix(n)
end
