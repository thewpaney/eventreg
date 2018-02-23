Student.all.shuffle.each do |student|
  first  = Workshop.firstsAvailable(student).sample
  student.signup first.id
  second = Workshop.secondsAvailable(student).sample
  student.signup second.id
  third  = Workshop.thirdsAvailable(student).sample
  student.signup third.id
end
