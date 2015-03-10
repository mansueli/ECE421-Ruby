require './array.rb'
require './timer.rb'
require './vaca.rb'
a = Array.new([1, 2, 3, 1231, 12, 1, 2, 1, 2, 1, 3441, 2, 123, 4, 512, 5, 12, 5123, 5234, 221, 12, 323, 92, 26, 88])
b = a.quick_sort
p 'original'
p a
p 'sorted asc'
p b
b = a.quick_sort { |x, y| x > y }
p 'sorted dsc'
p b
p 'custom object'
v = Vaca.new("odali4", 4)
p "boo" + v.age.to_s
va = Array.new ([Vaca.new("odali4", 4), Vaca.new("oas9", 9), Vaca.new("oda1", 1), Vaca.new("lia4", 11), Vaca.new("ia8", 8), Vaca.new("odalia7", 7),])
# va_sorted = va.quick_sort {|x,y| x.age.to_i < y.age.to_i}
va_sorted = va.quick_sort { |x, y| x.comparato(y) }
va_sorted.each { |k| p k.age.to_s }
p 'sort by name size'
va_sorted = va.quick_sort { |x, y| x.name.length > y.name.length }
va_sorted.each { |k| p k.name }
vaa = Array.new (1000) {|x| x = Random.new.rand(0..1000)}
ac=vaa.timed_out(5).quick_sort
p ac
boo = vaa.timed_out().quick_sort
cavalo = ['aa','g','ff','z','b']
p cavalo.quick_sort
