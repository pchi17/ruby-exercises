# Method:  is_fibonacci?(n)
# Inputs:  A single non-negative integer +n+
# Returns: true if +n+ is a Fibonacci number and false otherwise

require "benchmark"
require "bigdecimal"
require_relative "fast_fib"

BIG_FIB_INPUT = 2**18

=begin
according to Binet's formula the nth Fibonacci number F(n) = (phi**n - (-phi)**(-n)) / sqrt(5)
as n increases, (-phi)**(-n) will approach 0 because |phi| > 1. F(n) is asymptotic to (phi**n) / sqrt(5)
rearrange the above equation and isolate n we get n ~= ln(F(n) * sqrt(5)) / ln(phi)
n should be very close to an integer as it gets large.

below is the first 20 Fibonacci numbers

fib(n)   n     approximate of n          approximation's deviation from n

1        2     1.6722759381845549        0.32772406181544517
2        3     3.112696028597111         0.11269602859711117
3        4     3.955287766773834         0.044712233226166
5        5     5.016827814553664         0.016827814553663972
8        6     5.993536209422224         0.0064637905777761885
13       7     7.002463651555561         0.0024636515555612475
21       8     7.9990581974241834        0.0009418025758168884
34       9     9.000359623948889         0.0003596239488894062
55       10    9.999862619447256         0.00013738055274425126
89       11    11.000052472304787        5.2472304787052674e-05
144      12    11.999979957013338        2.0042986661563933e-05
233      13    13.000007655688647        7.655688645914024e-06
377      14    13.9999970757797          2.924220300985744e-06
610      15    15.000001116951676        1.1169516765080856e-06
987      16    15.999999573362263        4.2663773706761886e-07
1597     17    17.00000016296109         1.629610894270236e-07
2584     18    17.999999937754396        6.224560297268123e-08
4181     19    19.0000000237757          2.3775701760037662e-08
6765     20    19.999999990918486        9.081512621730928e-09

it is clear that as n gets large, the approximation's deviation from the real n gets smaller,
confirming the asymptotic behavior. Note that 0 is a special case because we cannot take the log of 0,
also, n rounds to 2 for F(1). Those are the only 2 exceptions and will not affect the trend afterwards.
=end

# finds an approximate of n, rounds it to the nearest integer, and checks if the input is in fact F(n)
def is_fibonacci?(n)
  return true if n == 0 || n == 1
  big = BigDecimal.new(n)
  x = BigMath::log(big * Math::sqrt(5), 10) / Math::log((1 + Math::sqrt(5)) / 2)
  return fast_fib(x.round) == n
end

# Print out some friendly usage information
def show_usage!
  puts "Usage:"
  puts "  #{$PROGRAM_NAME} <number-to-test>"
  puts ""
  puts "Options:"
  puts "  -t, --test        Run PASS/FAIL tests"
  puts "  -b, --bench       Run benchmarks"
end

# Run our benchmark suite
def run_benchmarks!(iterations = 3)
  big_fib = fast_fib(BIG_FIB_INPUT)
  big_not_fib = big_fib + 100

  msg = "Benchmarking #{iterations} iterations of is_fibonacci?"

  puts "=" * msg.length
  puts msg
  puts "Fibonacci input:     fib(#{BIG_FIB_INPUT})"
  puts "Non-Fibonacci input: fib(#{BIG_FIB_INPUT}) + 100"
  puts "=" * msg.length

  Benchmark.bm(label_width = 40) do |x|
    x.report("is_fibonacci? (w/ Fibonacci input)") do
      iterations.times { is_fibonacci?(big_fib) }
    end

    x.report("is_fibonacci? (w/ non-Fibonacci input)") do
      iterations.times { is_fibonacci?(big_not_fib) }
    end
  end
end

# Run our test suite
def run_tests!
  puts "Testing with Fibonacci inputs"
  [0, 1, 2, 3, 5, 39088169].each do |n|
    assert_equal(true, is_fibonacci?(n), "is_fibonacci?(#{n}) is true")
  end

  puts ""
  puts "Testing with non-Fibonacci inputs"
  [4, 6, 7, 10, 39088169 - 1].each do |n|
    assert_equal(false, is_fibonacci?(n), "is_fibonacci?(#{n}) is false")
  end

  puts ""
  print "Testing with large inputs. Generating inputs..."

  big_fib = fast_fib(BIG_FIB_INPUT)
  big_not_fib = big_fib + 100

  puts "done"

  assert_equal(true, is_fibonacci?(big_fib),
               "is_fibonacci?(fib(#{BIG_FIB_INPUT})) is true")

  assert_equal(false, is_fibonacci?(big_not_fib),
               "is_fibonacci?(fib(#{BIG_FIB_INPUT}) + 100) is false")
end

# Helper method for testing purposes
def assert_equal(expected, actual, msg)
  if expected == actual
    puts "[PASS] : #{msg}"
  else
    puts "[FAIL] : #{msg}"
  end
end

if __FILE__ == $PROGRAM_NAME
  case ARGV[0]
  when "-h", "--help", "", nil
    show_usage!
  when "-b", "--bench"
    # benchmarks is run at least 3 times.
    freq = ARGV[1].to_i
    freq > 3 ? run_benchmarks!(freq) : run_benchmarks!
  when "-t", "--test"
    run_tests!
  else
    puts is_fibonacci?(ARGV[0].to_i)
  end
end
