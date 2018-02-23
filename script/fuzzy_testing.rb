Student.all.shuffle do |student| 
  begin
    first  = Workshop.firstsAvailable(student).sample
    student.signup first.id
  rescue
    puts "Unable to place #{student.prefix} in #{first.name}"
  end

  begin
    second = Workshop.secondsAvailable(student).sample
    student.signup second.id
  rescue
    puts "Unable to place #{student.prefix} in #{second.name}"
  end

  begin
    third  = Workshop.thirdsAvailable(student).sample
    student.signup third.id
  rescue
    puts "Unable to place #{student.prefix} in #{second.name}"
  end
end
