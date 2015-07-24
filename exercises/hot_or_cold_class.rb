class HotOrCold
  def initialize(number_to_guess)
    @number_to_guess = number_to_guess
  end

  def hot_or_cold(number)
    if number > @number_to_guess
      return 'hot'
    elsif number < @number_to_guess
      return 'cold'
    else
      return 'correct'
    end
  end
end

def prompt(msg)
  print "#{msg}: "
  gets.chomp
end

if __FILE__ == $PROGRAM_NAME
  if ARGV[0]
    top_guess = ARGV[0].to_i
  else
    top_guess = 100
  end

  loop do
    puts "Welcome to Hot or Cold!"

    game = HotOrCold.new(rand(1..top_guess))

    loop do
      our_guess = prompt("Guess a number between 1-#{top_guess} " \
                         "(or type \"quit\" to quit)")

      if our_guess == "quit"
        puts "Goodbye!"
        exit # exit the entire program
      end

      our_guess = our_guess.to_i

      result = game.hot_or_cold(our_guess)

      if result == "hot"
        puts "#{our_guess} is too hot!\n\n"
      elsif result == "cold"
        puts "#{our_guess} is too cold!\n\n"
      elsif result == "correct"
        puts "#{our_guess} is correct!\n\n"
        break # breaks out of the inner-most loop, taking us to line 35
      end
    end
  end
end
