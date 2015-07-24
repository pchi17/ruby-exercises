# Classes: Die

# This is a variation on the previous Die class.  Rather than hard-coding
# the number of sides to 6, allow the user to initialize a new die with any
# number of sides.  Die#roll will then return a random number between
# 1 and the value the user initialized the die with.

# See the code below from examples.

class Die
  def initialize(sides)
    @sides = sides
  end

  def roll
    return rand(1..@sides)
  end
end

if __FILE__ == $PROGRAM_NAME
  die_10 = Die.new(10)
  die_20 = Die.new(20)
  die_6  = Die.new(6)

  20.times do
    roll = die_10.roll
    res  = roll < 1 || roll > 10 ? 'FAIL' : 'PASS'
    puts "#{res} : 10-sided die roll : #{roll}"
    roll = die_20.roll
    res  = roll < 1 || roll > 20 ? 'FAIL' : 'PASS'
    puts "#{res} : 20-sided die roll : #{roll}"
    roll = die_6.roll
    res  = roll < 1 || roll > 6 ? 'FAIL' : 'PASS'
    puts "#{res} :  6-sided die roll : #{roll}"
    puts "*******************************"
  end
  # die_10.roll should return a random number between 1 and 10 (inclusive)
  # die_20.roll should return a random number between 1 and 20 (inclusive)
  # die_6.roll should return a random number between 1 and 6 (inclusive)
end
