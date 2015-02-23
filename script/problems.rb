# Script to check for problem children and teachers and print the errors

def checkProblems(user)
  print "#{user.full}: "
  problems = []
  if user.workshops.count > 3
    problems << "More than three workshops."
  end

  if user.workshops.count < 3
    problems << "Less than three workshops."
  end
  
  if user.workshop_ids.select {|w| user.workshop_ids.count(w) > 1 }.count > 1
    problems << "Has duplicate workshops."
  end
  
  sessions = user.workshops.collect {|w| w.session}
  sessions.select {|s| sessions.count(s) > 1 }.uniq.each do |s|
    problems << "Has multiple workshops in session #{s}."
  end
  
  if user.class == Teacher
    user.workshops.each do |w|
      if w.ttaken.to_i > w.tlimit.to_i
        problems << "Workshop #{w.id} over teacher capacity."
      end
    end
  end
    
  if user.class == Student
    if user.gender == "BD"
      user.workshops.each do |w|
        if w.staken.to_i > w.slimit.to_i
          problems << "Workshop #{w.id} over student capacity."
        end
        if (w.percentage.to_f/100.to_f) < (w.boys.count/w.slimit.to_f)
          problems << "Workshop #{w.id} overbalanced toward boys."
        end
      end
    elsif user.gender == "GD"
      user.workshops.each do |w|
        if w.staken.to_i > w.slimit.to_i
          problems << "Workshop #{w.id} over student capacity."
        end
        if (w.percentage.to_f/100.to_f) < (w.girls.count/w.slimit.to_f)
          problems << "Workshop #{w.id} overbalanced toward girls."
        end
      end
    end
  end
  
  if problems == []
    puts "No issues!"
  else
    problems.each {|p| puts p}
  end
  
end

puts "----------------------------------------"
puts "Checking student problems:"
puts "----------------------------------------"

Student.all.each do |s|
  checkProblems(s)
end

puts
puts "----------------------------------------"
puts "Checking teacher problems:"
puts "----------------------------------------"

Teacher.all.each do |t|
  checkProblems(t)
end
