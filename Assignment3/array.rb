require './preconditions'

class Array
  include Preconditions
  class << self
    def timeout(seconds = 10)
      Timer.new(self, seconds)
    end
  end

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
    left_thread.join
    right_thread.join
    return l.+ [pivot] + g
  end
end
