# Method:  is_fibonacci?(n)
# Inputs:  A single non-negative integer +n+
# Returns: true if +n+ is a Fibonacci number and false otherwise

require "benchmark"
require "bigdecimal"
require_relative "fast_fib"

BIG_FIB_INPUT = 2**18

# according to Binet's formula the nth Fibonacci number F(n) = (phi**n - (-phi)**(-n)) / sqrt(5)
# as n increases, (-phi)**(-n) will approach 0, therefore F(n) is asymptotic to (phi**n) / sqrt(5)
# rearrange the above equation and isolate n we get n ~ ln(F(n) * sqrt(5)) / ln(phi)
# n should be very close to an integer for large n.
# below is the first 10 Fibonacci numbers [index, number itself, n found by taking logs, and deviation from the closest integer]
#   0  , 0/1, NA
#   1  , 1 , 1.6722759381845549   : 0.3277240618154451
#   2  , 1 , 1.6722759381845549   : 0.3277240618154451
#   3  , 2 , 3.112696028597111    : 0.11269602859711103
#   4  , 3 , 3.955287766773834    : 0.04471223322616602
#   5  , 5 , 5.016827814553664    : 0.016827814553663778
#   6  , 8 , 5.993536209422224    : 0.0064637905777757965
#   7  , 13, 7.002463651555561    : 0.0024636515555611638
#   8  , 21, 7.9990581974241834   : 0.0009418025758165527
#   9  , 34, 9.000359623948889    : 0.0003596239488885544
#   10 , 55, 9.999862619447256    : 0.0001373805527435934
# it is clear that as n gets large, its deviation from an integer gets smaller, confirming the asymptotic behavior.
# Note that 0 is an odd case because we cannot take the log of it, also, n rounds to 2 for F(1). Those are the only
# 2 exceptions and will not affect the trend afterwards. The equation below will handle them.

# this method finds n, rounds it to the nearest integer, and checks if the input is in fact F(n)
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
