require 'time'

class Person
  attr_reader :first_name, :last_name, :dob
  def initialize(first_name, last_name, dob)
    raise(ArgumentError, "Date of Birth must be in 'yyyy-mm-dd' format") unless dob =~ /^\d\d\d\d-\d\d-\d\d$/
    @first_name = first_name
    @last_name  = last_name
    @dob = Time.parse(dob)
  end

  def age
    arr = self.dob.to_a
    now = Time.now
    arr[5] = now.year
    bday_this_year = Time.local(*arr)
    offset = bday_this_year > now ? 1 : 0
    return now.year - self.dob.year - offset
  end

  def first_initial
    self.first_name[0]
  end

  def last_initial
    self.last_name[0]
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def short_name
    "#{self.first_name} #{self.last_initial}."
  end

  def initials
    "#{self.first_initial}#{self.last_initial}"
  end
end

if __FILE__ == $PROGRAM_NAME
  print "Enter your first name:  "
  first_name = gets.chomp.downcase.capitalize

  print "Enter your last  name: "
  last_name = gets.chomp.downcase.capitalize

  print "Enter your date of birth (yyyy-mm-dd):  "
  dob = gets.chomp
  # Person.new returns a new instance of the Person class and we assign it
  # to the variable person
  person = Person.new(first_name, last_name, dob)

  puts "You entered..."
  puts "First name: #{person.first_name}"
  puts "Last  name: #{person.last_name}"
  puts "Date of Birth: #{dob}"
  puts ""

  puts "Welcome, #{person.first_name}!"
  puts ""

  puts "Full name:  #{person.full_name}"
  puts "Short name: #{person.short_name}"
  puts "Initials:   #{person.initials}"
  puts "DOB: #{person.dob}"
  puts "Age: #{person.age}"
end
