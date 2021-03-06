require 'csv'

$teacher_csv = "db/teachers-seed.csv"

index = 1
contents = CSV.read($teacher_csv, col_sep: ",", encoding: "ISO8859-1")
puts "Seeding teachers"

User.teachers.delete_all

contents[1..-1].each do |row|
  t = User.new
  t.id = index
  index += 1
  t.division = ( row[0] ? "BD" : "GD" )
  t.number = row[2]
  t.name = (row[4] + " " + row[3])
  t.prefix = row[7].split("@")[0]
  t.email = row[7]
  t.year = nil
  t.rw = nil
  t.rw_number = nil
  t.rw_teacher = nil
  t.advisement = nil
  t.advisement_name = nil
  t.special = nil
  t.save!
  t.save!
end
puts "Seeded teachers"
