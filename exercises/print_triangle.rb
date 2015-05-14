# Method name: print_triangle
# Input: a number n
# Returns: Nothing
# Prints: a right triangle consisting of "*" characters that is "n"
#         characters tall
#
# For example, print_triangle(4) should print
#
# *
# **
# ***
# ****

# The print_line method is here to help you.
# Conceptually, it prints out a row of "count" *'s.  Run it yourself to
# see how it works.  Experiment with different inputs.
def print_line(count)
  count.times { print "*" }
  print "\n"
end

def print_triangle(height)
  (1..height).each do |i|
    print_line(i)
  end
end

# There are no rumble strips this time.  It's up to you to decide whether
# this is working as intended or not.

if __FILE__ == $PROGRAM_NAME
  print_triangle(1)

  print "\n\n\n" # This is here to make the separation between triangles clearer

  print_triangle(2)

  print "\n\n\n" # This is here to make the separation between triangles clearer

  print_triangle(3)

  print "\n\n\n" # This is here to make the separation between triangles clearer

  print_triangle(10)
end
