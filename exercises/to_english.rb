# Method name: to_roman
# Inputs:      A number
# Returns:     A String representing the number in English
# Prints:      Nothing

# Write a method that takes a positive integer as input and returns the input
# in "plain English."  For example,
#
#   to_english(1)     == "one"
#   to_english(12)    == "twelve"
#   to_english(123)   == "one hundred twenty three"
#   to_english(1234)  == "one thousand two hundred thirty four"
#   to_english(12345) == "twelve thousand three hundred forty five"
#
# You can decide the largest power of 10 you wish to support, but you should
# support at least up to the billions.

# Hint #1
# Write down a bunch of examples and look for patterns.
# What words make up "special cases?" There are likely fewer than you think
# if you can find ways to combine simpler patterns into larger ones.

# currently supporting numbers in trillions
require './commas.rb'

def ones(x)
  case x
  when '9'
    'nine'
  when '8'
    'eight'
  when '7'
    'seven'
  when '6'
    'six'
  when '5'
    'five'
  when '4'
    'four'
  when '3'
    'three'
  when '2'
    'two'
  when '1'
    'one'
  else
    ''
  end
end

def teens(x)
  case x
  when '19'
    'nineteen'
  when '18'
    'eighteen'
  when '17'
    'seventeen'
  when '16'
    'sixteen'
  when '15'
    'fifteen'
  when '14'
    'fourteen'
  when '13'
    'thirteen'
  when '12'
    'twelve'
  when '11'
    'eleven'
  when '10'
    'ten'
  end
end

def tens(x)
  case x
  when '9'
    'ninety'
  when '8'
    'eighty'
  when '7'
    'seventy'
  when '6'
    'sixty'
  when '5'
    'fifty'
  when '4'
    'forty'
  when '3'
    'thirty'
  when '2'
    'twenty'
  else
    ''
  end
end

def to_english(num)
  return 'zero' if num == 0
  result = []
  neg = num < 0 ? 'negative' : ''
  array = commas(num.abs).split(',')
  leng = [5, array.length].min
  (1..leng).each do |i|
    word = ''
    str = array[-i]
    word += ones(str[-3])
    word += ' hundred ' if str[-3] && str[-3] != '0'
    if str[-2] == '1'
      word += teens(str[-2,2])
    else
      word += tens(str[-2])
      word += ' '
      word += ones(str[-1])
    end
    word.strip!
    word += ' thousand' if i == 2 && word.length > 0
    word += ' million'  if i == 3 && word.length > 0
    word += ' billion'  if i == 4 && word.length > 0
    word += ' trillion' if i == 5 && word.length > 0
    result << word
  end
  return result.reverse.join(' ').strip
end

if __FILE__ == $PROGRAM_NAME
  # Hey, there are a bunch of lovely test cases above.  Start with those. :)
  p to_english(0) == 'zero'
  p to_english(7) == 'seven'
  p to_english(11) == 'eleven'
  p to_english(315) == 'three hundred fifteen'
  p to_english(1410) == 'one thousand four hundred ten'
  p to_english(12966) == 'twelve thousand nine hundred sixty six'
  p to_english(1001) == 'one thousand one'
  p to_english(1000) == 'one thousand'
  p to_english(1000000) == 'one million'
  p to_english(43214395857) == 'forty three billion two hundred fourteen million three hundred ninety five thousand eight hundred fifty seven'
end
