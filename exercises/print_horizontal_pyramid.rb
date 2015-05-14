# Method name: print_horizontal_pyramid
# Input: a number n
# Returns: Nothing
# Prints: a pyramid consisting of "*" characters that is "n" characters tall
#         at its tallest
#
# For example, print_horizontal_pyramid(4) should print
#
#    *
#   ***
#  *****
# *******

def print_horizontal_pyramid(height)
  (1..height).each do |i|
    (height - i).times { print " " }
    (2 * i - 1).times { print "*" }
    print "\n"
  end
end

if __FILE__ == $PROGRAM_NAME
  print_horizontal_pyramid(5)
  print "\n\n\n"
  print_horizontal_pyramid(1)
  print "\n\n\n"
  print_horizontal_pyramid(2)
  print "\n\n\n"
  print_horizontal_pyramid(4)
  print "\n\n\n"
  print_horizontal_pyramid(10)
end
