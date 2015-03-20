=begin
      Array extensions - ECE 421 Assignment 3
      @Authors Rodrigo Mansueli & Andy Yao

      Description: Adds timeout and parallel quick sort to the Class Array
=end
require 'timeout'
require './preconditions'
require './contract_violation'
include Preconditions

class Array
  include Preconditions

  #causes exceptions to propagate up through program threads
  Thread.abort_on_exception=true

  # Gives a time for the object to execute it´s method
  # @param secounds [Numeric] amount of time
  # @raise exception [ContractViolation] when the method did not complete withing the time given
  def timed_out(seconds = 10)
      Timer.new(self, seconds)
      self
  end

  # Sorts the array
  # @param block comparator block (optional)
  def quick_sort &block
    #preconditions
    begin
      is_enumerable? self
    rescue
      is_trivial_block? &block if block_given?
    end
    #task
    return self if self.length <= 1
    pivot = self[0]
    if block_given?
      less, greater_equals = self[1..-1].partition { |x| yield x, pivot }
    else
      less, greater_equals = self[1..-1].partition { |x| x < pivot }
    end
    l = []
    g = []
    left_thread = Thread.new { l = less.quick_sort &block }
    right_thread = Thread.new { g = greater_equals.quick_sort &block }
    # Process.waitall
    begin
      left_thread.join
      right_thread.join
    rescue ThreadError => te
      puts "EXCEPTION: #{te.inspect}"
      puts "MESSAGE: #{te.message}"
    rescue RunTimeError => re
      puts "EXCEPTION: #{re.inspect}"
      puts "MESSAGE: #{re.message}"
    end
    return l.+ [pivot] + g
  end
end
