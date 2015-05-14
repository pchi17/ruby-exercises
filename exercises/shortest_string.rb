# Method name: shortest_string(list)
# Inputs:      a list of strings
# Returns:     the shortest string in the list
# Prints:      Nothing

def shortest_string(list)
  shortest_so_far = list.shift
  list.each do |item|
    if item.length < shortest_so_far.length
      shortest_so_far = item
    end
  end
  return shortest_so_far
end

# alternatively
def shortest_str(list)
  list.min_by { |x| x.length }
end

if __FILE__ == $PROGRAM_NAME
# test for first method
  p shortest_string(["a", "zzzz", "c"]) == "a"
  p shortest_string(["I", "love", "you"]) == "I"
  p shortest_string(["how", "are", "you"]) == "how"
  p shortest_string(["mike"]) == "mike"
  p shortest_string([]) == nil
# test for second method
  p shortest_str(["a", "zzzz", "c"]) == "a"
  p shortest_str(["I", "love", "you"]) == "I"
  p shortest_str(["how", "are", "you"]) == "how"
  p shortest_str(["mike"]) == "mike"
  p shortest_str([]) == nil

end
