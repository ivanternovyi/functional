# Question 9
# Level 2

# Write a program that accepts sequence of lines as input and prints
# the lines after making all characters in the sentence capitalized.

class Maybe
  attr_reader :value

  def self.unit(value)
    value == [] ? None.new : Some.new(value)
  end

  def bind(func)
    is_a?(None) ? self : func.call(self.value)
  end

  def inspect
    is_a?(None) ? 'Nothing' : self.value
  end

  class Some < Maybe
    def initialize(value)
      @value = value
    end
  end

  class None < Maybe
  end
end

class IOMaybe
  def self.maybe
    arr = []

    input_func = -> (val) { val == '' ? return : (arr << val; input_func.call(gets.chomp)) }
    input_func.call(gets.chomp)

    Maybe.unit(arr)
  end
end

puts IOMaybe.maybe
            .bind(
              ->(x) {
                Maybe.unit(x.map(&:upcase))
              }
            ).bind(
              ->(x) {
                Maybe.unit(x.join("\n"))
              }
            ).inspect
