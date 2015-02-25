def tgrab(s)
    Workshop.all.collect {|w| w if w.session == s}.delete_if {|w| w.nil?}.collect {|w| w.tlimit.to_i}.sum
end

def grab(s)
    Workshop.all.collect {|w| w if w.session == s}.delete_if {|w| w.nil?}.collect {|w| w.slimit.to_i}.sum
end

def taken(s)
  Workshop.all.collect {|w| w if w.session == s}.delete_if {|w| w.nil?}.collect {|w| w.staken.to_i}.sum
end

def ttaken(s)
  Workshop.all.collect {|w| w if w.session == s}.delete_if {|w| w.nil?}.collect {|w| w.ttaken.to_i}.sum
end

def over(s)
  Workshop.all.select{|w| w.session == s}.collect(&:overflow).sum
end

puts "Total Students: #{ Student.all.count }"
puts "Session 1 Availability: #{ taken(1) } of #{ grab(1) } taken. #{ over(1) } overflow capacity."
puts "Session 2 Availability: #{ taken(2) } of #{ grab(2) } taken. #{ over(2) } overflow capacity."
puts "Session 3 Availability: #{ taken(3) } of #{ grab(3) } taken. #{ over(3) } overflow capacity."

puts "Total Teachers: #{ Teacher.all.count }"
puts "Session 1 Availability: #{ ttaken(1) } of #{ tgrab(1) } taken."
puts "Session 2 Availability: #{ ttaken(2) } of #{ tgrab(2) } taken."
puts "Session 3 Availability: #{ ttaken(3) } of #{ tgrab(3) } taken."

