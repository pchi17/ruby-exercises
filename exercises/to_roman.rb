# Method name: to_roman
# Inputs:      A number
# Returns:     A String representing the number in roman numerals
# Prints:      Nothing

# to_roman takes a number as input and returns that number using Roman numerals
# See http://en.wikipedia.org/wiki/Roman_numerals

# It can be tricky to handle the cases where "IV" means 4.  As a first pass,
# don't hesitate to implement a simpler version where 4 is denoted by "IIII".
#
# Remember: the priority is FEEDBACK, even if your implementation can't handle
# every single case.

# Currently support numbers less than 5000
def digits(int, base = 10)
  q, r = int.divmod(base)
  (q > 0 ? digits(q, base) : []) + [r]
end

def ones(x)
  case x
  when 1..3
    'I' * x
  when 4
    'IV'
  when 5
    'V'
  when 6
    'VI'
  when 7,8
    'V' + 'I' * (x - 5)
  when 9
    'IX'
  else
    ''
  end
end

def tens(x)
  case x
  when 1..3
    'X' * x
  when 4
    'XL'
  when 5
    'L'
  when 6
    'LX'
  when 7,8
    'L' + 'X' * (x - 5)
  when 9
    'XC'
  else
    ''
  end
end

def hundreds(x)
  case x
  when 1..3
    'C' * x
  when 4
    'CD'
  when 5
    'D'
  when 6
    'DC'
  when 7,8
    'D' + 'C' * (x - 5)
  when 9
    'CM'
  else
    ''
  end
end

def thousands(x)
  case x
  when 1..4
    'M' * x
  else
    ''
  end
end

def to_roman(num)
  raise ArgumentError, 'number must be less than 5000' unless num < 5000
  array = digits(num)
  result = ''
  result += thousands(array[-4])
  result += hundreds(array[-3])
  result += tens(array[-2])
  result += ones(array[-1])
  return result
end

if __FILE__ == $PROGRAM_NAME
  # What are some test cases?
  p to_roman(1) == 'I'
  p to_roman(2) == 'II'
  p to_roman(3) == 'III'
  p to_roman(4) == 'IV'
  p to_roman(5) == 'V'
  p to_roman(6) == 'VI'
  p to_roman(7) == 'VII'
  p to_roman(8) == 'VIII'
  p to_roman(9) == 'IX'
  p to_roman(10) == 'X'
  p to_roman(15) == 'XV'
  p to_roman(24) == 'XXIV'
  p to_roman(58) == 'LVIII'
  p to_roman(100) == 'C'
  p to_roman(101) == 'CI'
  p to_roman(523) == 'DXXIII'
  p to_roman(1000) == 'M'
  p to_roman(4297) == 'MMMMCCXCVII'
end
