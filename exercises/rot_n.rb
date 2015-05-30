# Method name: rot_n
# Inputs:      A String to be encoded plus an integer to "rotate" by
# Returns:     A ROT-N encoded message
# Prints:      Nothing

# In a previous kata, we wrote a ROT13 method.  In this one, we will write
# a ROT-N method.

# e.g., rot13(string) == rot_n(string, 13)
def rot_n(string, n)
  n %= 26
  result = ''
  string.each_char do |c|
    x = c.ord
    if x.between?(65,90)
      x += n
      x = 64 + x % 90 unless x.between?(65,90)
    elsif x.between?(97, 122)
      x += n
      x = 96 + x % 122 unless x.between?(97, 122)
    end
    result << x.chr
  end
  return result
end

if __FILE__ == $PROGRAM_NAME
  # See http://www.rot-n.com/ to generate test inputs and outputs
  p rot_n('hello', 7) == 'olssv'
  p rot_n('Warriors', 13) == 'Jneevbef'
  p rot_n('California', 17) == 'Trczwfiezr'
  p rot_n('United States', 76) == 'Slgrcb Qryrcq'
  p rot_n('YMCA', 26) == 'YMCA'
  p rot_n('', 5) == ''
  p rot_n('K', 1) == 'L'
  p rot_n('NYC', 11) == 'YJN'
end
