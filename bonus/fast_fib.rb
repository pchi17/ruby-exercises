require 'benchmark'

# using the 2-dimensional matrix form to quickly generate large fibonacci numbers
require 'matrix'
MATRIX = Matrix[[1,1],[1,0]]

def fast_fib(n)
  return (MATRIX**(n-1))[0, 0]
end

# Alternatively, the Binet's formula can also be used
# Binet's formula fib(n) = (phi**n - (1 - phi)**n)/(phi - (1 - phi))
# binet(n) generates the fib(n) with the Binet's formula

require_relative 'phi_rational'

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
  p fast_fib(0)   == 0
  p fast_fib(1)   == 1
  p fast_fib(2)   == 1
  p fast_fib(5)   == 5
  p fast_fib(10)  == 55
  p fast_fib(20)  == 6765
  p fast_fib(100) == 354224848179261915075
  p fast_fib(300) ==  222232244629420445529739893461909967206666939096499764990979600

  puts ''
  puts "Testing Binet's formula"
  p binet(0)   == 0
  p binet(1)   == 1
  p binet(2)   == 1
  p binet(5)   == 5
  p binet(10)  == 55
  p binet(20)  == 6765
  p binet(100) == 354224848179261915075
  p binet(300) ==  222232244629420445529739893461909967206666939096499764990979600

  puts ''
  puts "run Benchmark to test the performance of matrix form vs Binet's formula"
  puts "Generating the 300th Fibonacci number 1000 times with both formulae"
  puts ''
  Benchmark.bmbm do |x|
    x.report("Matrix Form") do
      1000.times { fast_fib(300) }
    end
    x.report("Binet's Formula") do
      1000.times { binet(300) }
    end
  end
end
# although both methods are impressively fast,
# after running Benchmark, I conclude that Matrix Form is the faster method. About twice as fast!
