# Question 9
# Level 2

# Write a program that accepts sequence of lines as input and prints
# the lines after making all characters in the sentence capitalized.

class Array
  def bind(func)
    func.call(self)
  end

  def self.unit(args)
    args
  end

  def self.lift(f)
    -> e { self.unit(f[e]) }
  end
end

class IOArray
  def self.array
    arr = []

    input_func = -> (val) { val == '' ? return : (arr << val; input_func.call(gets.chomp)) }
    input_func.call(gets.chomp)

    Array.unit(arr)
  end
end
 
upcase_func = -> (x) { x.map(&:upcase) }
stringify_func = -> (x) { x.join("\n") }
upcase_func_lifted = Array.lift(upcase_func)
stringify_func_lifted = Array.lift(stringify_func)
         
puts IOArray.array
            .bind(upcase_func_lifted)
            .bind(stringify_func_lifted)
