require 'csv'

$student_csv = "db/students-seed.2018.csv"

index = 1

contents = CSV.read($student_csv, col_sep: ",", encoding: "ISO8859-1")

puts "Updating student advisement teacher names from CSV columns 10 and 11"

contents[1..-1].each do |row|
  s = Student.where(number: row[0].to_i).first
  s.rw = row[13].blank? ? "MISSING INFO" : row[13]
  s.rw_number = row[16].blank? ? "MISSING INFO" : row[16]
  s.rw_teacher = row[17].blank? ? "MISSING INFO" : row[17]
  s.advisement = row[10].blank? ? "MISSING INFO" : row[10]
  s.advisement_name = row[12].blank? ? "MISSING INFO" : row[12]
  s.save!
end

puts "Updated student advisement teacher names"
