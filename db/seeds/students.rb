require 'csv'

$student_csv = "db/students-seed.csv"

index = 1
contents = CSV.read($student_csv, col_sep: ",", encoding: "ISO8859-1")
puts "Seeding students"

User.students.delete_all

contents[1..-1].each do |row|
  s = User.new
  s.id = index
  index += 1
  s.number = row[0].to_i
  s.full = (row[2] + " " + row[1])
  s.division = ( row[3] === "Male" ? 'BD' : 'GD' )
  s.grade = row[4].blank? ? "MISSING INFO" : row[4]
  s.year = row[4].blank? ? 99 : ( row[4] === "Senior" ? 12 : ( row[4] === "Junior" ? 11 : ( row[4] === "Sophomore" ? 10 : ( row[4] === "Freshman" ? 9 : 99 ) ) ) )
  s.email = row[6]
  s.prefix = row[6].split('@').first
  s.rw = row[13].blank? ? "MISSING INFO" : row[13]
  s.rw_number = row[16].blank? ? "MISSING INFO" : row[16]
  s.rw_teacher = row[17].blank? ? "MISSING INFO" : row[17]
  s.advisement = row[10].blank? ? "MISSING INFO" : row[10]
  s.advisement_name = row[12].blank? ? "MISSING INFO" : row[12]
  s.special = ""
  s.save!
end
puts "Seeded students"
