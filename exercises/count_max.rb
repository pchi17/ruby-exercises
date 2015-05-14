# Method name: count_max
# Inputs:      A list of numbers
# Returns:     The number of times the largest number in the list
#              appears in the list
# Prints:      Nothing
#
# For example,
#   count_max([10, 1,2,10,10]) == 3
# because "10" is the largest number in the list and it occurs 3 times

# This is how we require the max.rb and count_in_list.rb files in the current
# folder. We can now use the "max" and "count_in_list" methods we defined there
# -- as if we had defined them right here!

require_relative "./max"
require_relative "./count_in_list"

def count_max(list)
  count_in_list(list, max(list))
end

if __FILE__ == $PROGRAM_NAME
  p count_max([10, 1,2,10,10]) == 3
  p count_max([]) == 0
  p count_max([7]) == 1
  p count_max([4, 8]) == 1
  p count_max([2, 3, 2]) == 1
  p count_max([4, 4, 2]) == 2
  p count_max([-1, -7, -22]) == 1
  p count_max([0, 0, 0]) == 3
end