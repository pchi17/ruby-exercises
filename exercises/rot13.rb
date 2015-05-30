# Method name: rot13
# Inputs:      A String to be encoded in ROT13
# Returns:     A ROT13-encoded string
# Prints:      Nothing

# ROT13 is short for "rotate 13" and is the simplest example of a
# "Caesar cipher".  See http://en.wikipedia.org/wiki/ROT13

# ROT13 works by taking a string and "rotating" all the characters in that
# string 13 places to the right in the alphabet, with "z" wrapping around to
# the beginning of the alphabet.
#
# In other words, every letter from the top row in this table is replaced with
# the corresponding letter in the bottomr row
#
#   ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz
#   NOPQRSTUVWXYZABCDEFGHIJKLMnopqrstuvwxyzabcdefghijklm
#
# "ROT13" is called a Caesar cipher because Julius Caesar used such letter
# replacement schemes to "encrypt" his communication.
require './rot_n.rb'
def rot13(string)
  rot_n(string, 13)
end

if __FILE__ == $PROGRAM_NAME
  # See http://www.rot-n.com/ to generate test inputs and outputs
  p rot13("The Quick Brown Fox Jumps Over The Lazy Dog") ==
    "Gur Dhvpx Oebja Sbk Whzcf Bire Gur Ynml Qbt"
  p rot13('ant') == 'nag'
  p rot13('envy') == 'rail'
  p rot13('fur') == 'she'
  p rot13('barf') == 'ones'
  p rot13('balk') == 'onyx'
end
