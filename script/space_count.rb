def shops(s)
    Workshop.all.collect {|w| w if w.session == s}.delete_if {|w| w.nil?}.collect {|w| w.slimit.to_i}.sort
end

def grab(s)
    Workshop.all.collect {|w| w if w.session == s}.delete_if {|w| w.nil?}.collect {|w| w.slimit.to_i}.sum
end

puts "Total Students: #{ Student.all.count }"
puts "Total Session 1 Slots: #{ grab(1) }"
p shops(1)
puts "Total Session 2 Slots: #{ grab(2) }"
p shops(2)
puts "Total Session 3 Slots: #{ grab(3) }"
p shops(3)
