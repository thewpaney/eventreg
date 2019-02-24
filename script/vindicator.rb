#Workshop.seconds.each do |w|
#  a = w.students.sample
#  a.unsignup w unless a.nil?
#  a.signup(129) unless a.nil?
#end

#Student.unregistered.each do |s|
#  puts s.prefix, s.sessions_needed, "="*30
#  s.sessions_needed.each do |session|
#    w = Workshop.where(:session => session).sample
#    sob = w.students.sample
#    sob.unsignup w unless sob.nil?
#    sob.signup 23
#    sob.signup 129
#    s.signup w unless sob.nil?
#  end
#end

puts "Registering all students"
Student.unregistered.map(&:auto)
puts "#{Student.unregistered.count} students are not fully registered"
