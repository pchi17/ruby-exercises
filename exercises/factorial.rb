# Method name: factorial
# Inputs:      A single non-negative integer, n
# Returns:     The factorial of n (see below)
# Prints:      Nothing

# The factorial of 5 is denoted by 5! and is defined as
#   5! = 5*4*3*2*1
#
# In English, you'd read "5!" as "five factorial".  In general, the factorial
# of a number is the product of every number from that number down to 1, so
#
#   4! = 4*3*2*1
#  10! = 10*9*8*7*6*5*4*3*2*1
#

def factorial(n)
  fac = 1
  (2..n).each do |x|
    fac *= x
  end
  return fac
end

if __FILE__ == $PROGRAM_NAME
  p factorial(0) == 1
  p factorial(1) == 1
  p factorial(2) == 2
  p factorial(5) == 120
  p factorial(10) == 3628800
end
