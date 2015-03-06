module Parallel_Sort

  def quick_sort(data)
    return data if data.length <= 1
    pivot = data[0]
    if block_given?
      less, greater_equals = data[1..-1].partition { yield(x, pivot) }
    else
      less, greater_equals = data[1..-1].partition { |x| x < pivot }
    end
    l = spawn less.quick_sort
    g = spawn greater_equals.quick_sort
    sync
    l + [pivot] + g
  end
end