# Method name: time_format
# Inputs:      A number, representing seconds
# Returns:     A string, describing the number of weeks, days, minutes, seconds
# Prints:      Nothing

# Remember when we wrote the countdown clock to count down from 5 minutes?
# Let's write a method that takes in an integer, representing a number of
# seconds, and returns a string describing larger chunks of time.  For example,
#
#   time_format(1234)  == "20m 34s"
#   time_format(12345) == "3h 25m 45s"
#
# This should support weeks, days, hours, minutes, and seconds.

def time_format(seconds)
  result = []
  secs = seconds % 60
  result << "#{secs}s"
  seconds -= secs
  unless seconds == 0
    seconds /= 60
    mins = seconds % 60
    result << "#{mins}m"
    seconds -= mins
    unless seconds == 0
      seconds /= 60
      hrs = seconds % 24
      result << "#{hrs}h"
      seconds -= hrs
      unless seconds == 0
        seconds /= 24
        days = seconds % 7
        result << "#{days}d"
        seconds -= days
        unless seconds == 0
          seconds /= 7
          result << "#{seconds}w"
        end
      end
    end
  end
  return result.reverse.join(' ')
end

if __FILE__ == $PROGRAM_NAME
  # Write your own test cases!  These four won't suffice.
  # Notice that we're looking at "edge" cases. We likely want to test
  # the boundaries where the parts "flip over", and also one output on
  # each side of that boundary, i.e., exactly 1 hour, 1 hour plus 1 second,
  # and 1 hour minute 1 second.
  #
  # Why? This is where our code is most likely to "go wrong."

  p time_format(0)    == "0s"
  p time_format(1)    == "1s"

  p time_format(59)   == "59s"
  p time_format(60)   == "1m 0s"
  p time_format(61)   == "1m 1s"

  p time_format(3600) == "1h 0m 0s"
end
