

class Try
  DEFAULT_EXCEPTIONS = [StandardError].freeze

  attr_reader :exception

  def self.unit(exceptions, value)
    Value.new(exceptions, value)
  rescue *exceptions => e
    Error.new(e)
  end


  class Value < Try
    attr_reader :exceptions

    def initialize(exceptions, value)
      @exceptions = exceptions
      @value = value
    end

    def bind(func)
      func.call(@value)
    rescue *exceptions => e
      Error.new(e)
    end

    def inspect
      "Try::Value(#{@value.inspect})"
    end
  end

  class Error < Try
    def initialize(exception)
      @exception = exception
    end

    def inspect
      "Try::Error(#{ exception.class }: #{ exception.message })"
    end

    def or(*args)
      if block_given?
        yield(exception, *args)
      else
        args[0]
      end
    end
  end
end

def Try(*exceptions, &f)
  catchable = exceptions.empty? ? Try::DEFAULT_EXCEPTIONS : exceptions.flatten
  Try.unit(catchable, f)
end

# puts Try(ZeroDivisionError) { 1 / 0 }.or { "zero!" } # => "zero!"

# s = Try::Value.new(ZeroDivisionError, 10)
# p s.bind(-> (x) { x / 2})

p Try.unit(ZeroDivisionError, 10).bind(-> (x) { Try.unit(ZeroDivisionError, x / 5) })
                                 .bind(-> (x) { Try.unit(ZeroDivisionError, x / 0) })
