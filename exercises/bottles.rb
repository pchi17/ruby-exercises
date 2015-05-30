# Method name: bottles
# Inputs:      A number, n
# Returns:     Nothing
# Prints:      The text for "99 bottles", starting at the input number and
#              counting down to 1

# For example, bottles(99) should print...
#
# 99 bottles of beer on the wall, 99 bottles of beer.
# Take one down, pass it around, 98 bottles of beer on the wall!
# 98 bottles of beer on the wall, 99 bottles of beer.
# Take one down, pass it around, 97 bottles of beer on the wall!
#
# ... and so on...
#
# 2 bottles of beer on the wall, 2 bottles of beer.
# Take one down, pass it around, 1 bottle of beer on the wall!
# 1 bottle of beer on the wall, 1 bottle of beer.
# Take one down, pass it around, no more bottles of beer on the wall!

# NOTE NOTE NOTE
# This method should print out the correct form of "bottles".  That is,
# it should say
#   2 bottles
#   1 bottle
#   no more bottles
#   etc.

def bottles(start_number)
  def words(n)
    return n == 1 ? '1 bottle of beer' : "#{n} bottles of beer"
  end
  start_number.downto(1) do |i|
    k = i -1
    k = 'no more' if k == 0
    puts "#{self.words(i)} on the wall, #{self.words(i)}."
    print 'take one down, pass it around, '
    puts "#{self.words(k)} on the wall!"
  end
end

if __FILE__ == $PROGRAM_NAME
  # What *should* this print?
  bottles(5)
  puts ''
  bottles(0)
  puts ''
  bottles(1)
  puts ''
  bottles(2)
  puts ''
  bottles(10)
  puts ''
end

# Hint #1:
# The "downto" method will be useful.
#
# See http://ruby-doc.org/core-2.0/Integer.html#method-i-downto or try this:
#
#   puts "Counting down..."
#   10.downto(1) do |i|
#     puts i
#   end
#   puts "Blast off!"

# Hint #2:
# The priority is getting this method to work, even if your code is messy, but
# try to isolate the part of each line that changes depending on the number of
# bottles and move it to its own method.  This makes handling the
# singular/plural logic much easier.
#
# Yes, that means you'll need to define another method here on your own. If you
# decide to try this approach, give it a sensible name. :)
