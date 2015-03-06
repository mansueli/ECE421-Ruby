require './preconditions'

class Array
  include Preconditions
  class << self
    def timeout(seconds = 10)
      Timer.new(self, seconds)
    end
  end

  def quick_sort
    #preconditions
    begin
      is_enumerable? self
    rescue
      is_trivial_block? { Proc.new } if block_given?
    end
    #task
    return data if self.length <= 1
    pivot = self[0]
    if block_given?
      less, greater_equals = self[1..-1].partition { yield(x, pivot) }
    else
      less, greater_equals = self[1..-1].partition { |x| x < pivot }
    end
    l = spawn less.quick_sort
    g = spawn greater_equals.quick_sort
    sync
    l + [pivot] + g
  end
end