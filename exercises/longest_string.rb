# Method name: longest_string(list)
# Inputs:      a list of strings
# Returns:     the longest string in the list
# Prints:      Nothing
#
# For example, longest_string(["a", "zzzz", "c"]) should return "zzzz" since
# the other strings are 1 character long and "zzzz" is 4 characters long.
#
# To get the length of a string in the variable str, call str.length
# For example,
#   str = "zzzz"
#   str.length == 4

def longest_string(list)
  longest_so_far = list.shift
  list.each do |item|
    if item.length > longest_so_far.length
      longest_so_far = item
    end
  end
  return longest_so_far
end

# alternatively
def longest_str(list)
  list.max_by { |x| x.length }
end

# TEST CODE
if __FILE__ == $PROGRAM_NAME
# test for first method
  p longest_string(["a", "zzzz", "c"]) == "zzzz"
  p longest_string(["I", "love", "you"]) == "love"
  p longest_string(["how", "are", "you"]) == "how"
  p longest_string(["mike"]) == "mike"
  p longest_string([]) == nil
# test for second method
  p longest_str(["a", "zzzz", "c"]) == "zzzz"
  p longest_str(["I", "love", "you"]) == "love"
  p longest_str(["how", "are", "you"]) == "how"
  p longest_str(["mike"]) == "mike"
  p longest_str([]) == nil
end
