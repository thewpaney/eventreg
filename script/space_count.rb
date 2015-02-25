def tgrab(s)
    Workshop.all.collect {|w| w if w.session == s}.delete_if {|w| w.nil?}.collect {|w| w.tlimit.to_i}.sum
end

def grab(s)
    Workshop.all.collect {|w| w if w.session == s}.delete_if {|w| w.nil?}.collect {|w| w.slimit.to_i}.sum
end

def taken(a)
  Student.all.collect {|s| s.workshops.collect {|w| w.session == a ? w.staken : 0}.sum }.sum
end

def ttaken(a)
  Teacher.all.collect {|t| t.workshops.collect {|w| w.session == a ? w.ttaken : 0}.sum }.sum
end

puts "Total Students: #{ Student.all.count }"
puts "Session 1 Availability: #{ taken(1) } of #{ grab(1) }"
puts "Session 2 Availability: #{ taken(2) } of #{ grab(2) }"
puts "Session 3 Availability: #{ taken(3) } of #{ grab(3) }"

puts "Total Teachers: #{ Teacher.all.count }"
puts "Session 1 Availability: #{ ttaken(1) } of #{ tgrab(1) }"
puts "Session 2 Availability: #{ ttaken(2) } of #{ tgrab(2) }"
puts "Session 3 Availability: #{ ttaken(3) } of #{ tgrab(3) }"

