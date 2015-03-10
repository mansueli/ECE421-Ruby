=begin
      Array extensions - ECE 421 Assignment 3
      @Authors Rodrigo Mansueli & Andy Yao

      Description: Adds timeout and parallel quick sort to the Class Array
=end
require 'timeout'
require './preconditions'
class Timer
  include Preconditions

  attr_reader :seconds, :object

  # Timer Constructor
  # @param object [Object] object to be analyzed
  # @param seconds [Numeric] amount of time in seconds
  def initialize(object, seconds)
    #preconditions
    is_number? seconds
    is_negative? seconds
    #main execution
    @seconds = seconds
    @object = object
  end

  # Wrapper Method
  # @param name [String] name of the object
  # @param args [Object] arguments used
  # @param block [Block] if a block was given
  # @raise exception [ContractViolation] when code fails to succeed
  def method_missing(name, *args, &block)
    Timeout::timeout(seconds) { object.send(name, *args, &block) }
  rescue Timeout::Error
    raise ContractViolation.exception "The process timed out"
  end
end