require 'csv'

$student_csv = "db/students-seed.2018.csv"

index = 1
contents = CSV.read($student_csv, col_sep: ",", encoding: "ISO8859-1")
puts "Seeding students"

Student.delete_all

contents[1..-1].each do |row|
  s = Student.new
  s.id = index
  index += 1
  s.number = row[0].to_i
  #s.last = row[1]                                                                                                                                                                                      
  #s.first = row[2]                                                                                                                                                                                     
  s.full = (row[2] + " " + row[1])
  s.gender = ( row[3] === "Male" ? 'BD' : 'GD' )
  s.grade = row[4].blank? ? "MISSING INFO" : row[4]
  s.year = row[4].blank? ? 99 : ( row[4] === "Senior" ? 12 : ( row[4] === "Junior" ? 11 : ( row[4] === "Sophomore" ? 10 : ( row[4] === "Freshman" ? 9 : 99 ) ) ) )
  s.email = row[6]
  s.prefix = row[6].split('@').first
  s.rw = row[10].blank? ? "MISSING INFO" : row[10]
  s.rw_number = row[10].blank? ? "MISSING INFO" : row[10]
  s.rw_teacher = row[11].blank? ? "MISSING INFO" : row[11]
  s.advisement = row[7].blank? ? "MISSING INFO" : row[7]
  s.advisement_name = row[8].blank? ? "MISSING INFO" : row[8]
  s.save!
end
puts "Seeded students"
