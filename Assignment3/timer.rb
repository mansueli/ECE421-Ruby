require 'timeout'
require './preconditions'
class Timer
  include Preconditions

  attr_reader :seconds, :object

  def initialize(object, seconds)
    #preconditions
    is_number? seconds
    #main execution
    @seconds = seconds
    @object = object
  end

  def method_missing(name, *args, &block)
    Timeout::timeout(seconds) { object.send(name, *args, &block) }
  rescue Timeout::Error
    raise ContractViolation "The process timed out"
  end
end