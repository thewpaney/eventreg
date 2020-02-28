require 'csv'

$teacher_csv = "db/teachers.csv"

index = 1
contents = CSV.read($teacher_csv, col_sep: ",", encoding: "ISO8859-1")
puts "Seeding teachers"

Teacher.delete_all

contents[1..-1].each do |row|
  t = Teacher.new
  t.id = index
  index += 1
  t.division = ( row[0] ? "BD" : "GD" )
  t.number = row[2]
  t.name = (row[4] + " " + row[3])
  t.prefix = row[7].split("@").first.downcase
  t.email = row[7]
  t.save!
end
puts "Seeded teachers"
