def vaca(a)
  if block_given?
    boo=yield(a, 500)
    print(boo)
  end
end

def my_comparator(a, b)
  a<b
end


vaca(3) { |a, a2| a > a2 }
print("\nbuceta\n")
vaca(5) { |a, b| my_comparator(a, b) }