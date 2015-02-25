require 'csv'

bad = true
CSV.foreach("db/presenters.csv") do |row|
  p = Teacher.where(name: row[0]).first
  if p.nil?
    p = Teacher.where(name: row[1]).first
  end
  puts p.name
  bad = true
  Workshop.all.each do |w|
    if w.presentor.include?(row[0])
      puts "Signed up #{p.full} for workshop #{w.name} in session #{w.session}."
      bad = false
    elsif !row[1].nil?
      if w.presentor.include?(row[1])
      puts "Signed up #{p.full} for workshop #{w.name} in session #{w.session}."
      bad = false
      end
    end
  end
  if bad
    puts "NO WORKSHOPS"
  end
end

CSV.foreach("db/student-presenters.csv") do |row|
  p = Student.where(full: row[0]).first
  puts p.full
  w = Workshop.find(row[1])
  puts "Signed up #{p.full} for workshop #{w.name} in session #{w.session}."
end
