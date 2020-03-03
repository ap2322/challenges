require 'pry'

class WellFormed
  attr_reader :input_string, :result
  attr_accessor :string_stack

  def initialize(input_string)
    @input_string = input_string
    @string_stack = []
  end

  def pairs
    {
      "(" => ")",
      "[" => "]",
      "{" => "}"
    }
  end

  def open
    pairs.keys
  end

  def closed
    pairs.values
  end

  def build_stack
    @result = true
    input_string.split(//).each do |ch|
      if open.include?(ch)
        string_stack.push(ch)
      elsif closed.include?(ch) && string_stack.length > 0
        peek = string_stack.last
        if ch == pairs[peek]
          string_stack.pop()
        else
          @result = false
        end
      end
    end

    if string_stack.length > 0
      @result = false
    end
    string_stack
  end


end
def validate(given_string)
  well_formed = WellFormed.new(given_string)
  well_formed.build_stack
  well_formed.result
end

well_formed = WellFormed.new("([{}[]])")


puts validate("()[")
