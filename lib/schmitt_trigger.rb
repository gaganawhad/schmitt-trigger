require 'schmitt_trigger/version'

class SchmittTrigger
  class LowerThresholdGreaterThanUpperThreshold < StandardError; end
  class LowerThresholdSameAsUpperThreshold < StandardError; end

  attr_accessor :lower_threshold, :upper_threshold
  attr_reader :output

  def initialize(lower_threshold, upper_threshold)
    raise LowerThresholdGreaterThanUpperThreshold unless lower_threshold <= upper_threshold
    raise LowerThresholdSameAsUpperThreshold unless lower_threshold != upper_threshold
    @lower_threshold = lower_threshold
    @upper_threshold = upper_threshold
  end

  def run(input)
    input = [input] unless input.is_a? Array
    [].tap do |arr|
      input.each { |i| arr << trigger(i) }
    end
  end

  private

  def trigger(input)
    @output = lower_threshold if output.nil?
    case
    when output == lower_threshold && input >= upper_threshold
      @output = upper_threshold
    when output == upper_threshold && input <= lower_threshold
      @output = lower_threshold
    end
    output
  end
end
