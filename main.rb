

class SchmittTrigger
  class << self
    attr_accessor :upper_threshold, :lower_threshold
    attr_reader :output

    def process(input)
      input = [input] unless input.is_a? Array
      [].tap do |arr|
        input.each{|i| arr << trigger(i)}
      end
    end


    private

    def trigger(input)
      @output = lower_threshold if output == nil
      case
      when output == lower_threshold && input >= upper_threshold
        @output = upper_threshold
      when output == upper_threshold && input <= lower_threshold
        @output = lower_threshold
      end
      output
    end
  end
end
