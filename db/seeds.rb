# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
# cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# Mayor.create(name: 'Emanuel', city: cities.first)

session = GoogleDrive.login("dlazzeri1@gmail.com", "gooHaiRYPanda007$")
puts "Connected to Google"

puts "Downloading workshops"
workshops = session.spreadsheet_by_key("0AiFYq092sE5adDJ2VVZCQjBib0paQk5GZ3M3WUE4NkE").worksheets[0]
puts "Downloaded workshops"

puts "Seeding workshops"
workshops.rows[1..-1].each do |row|
  if row[3] == "x"
    begin
      w = Workshop.new
      w.presentor = row[0]
      w.name = row[1]
      w.description = row[2]
      w.session = 1
      w.room = row[6]
      w.slimit = row[7]
      w.tlimit = row[8]
      w.staken = 0
      w.ttaken = 0
      w.percentage = row[9].blank? ? 66 : row[9].to_i
      w.save!
#     rescue
#       puts "Couldn't make workshop with row #{workshops.rows.index(row) + 1}: " << row.to_s
    end
  end
  if row[4] == "x"
    begin
      w = Workshop.new
      w.presentor = row[0]
      w.name = row[1]
      w.description = row[2]
      w.session = 2
      w.room = row[6]
      w.slimit = row[7]
      w.tlimit = row[8]
      w.staken = 0
      w.ttaken = 0
      w.percentage = row[9].blank? ? 66 : row[9].to_i
      w.save!
#    rescue
#      puts "Couldn't make workshop with row #{workshops.rows.index(row) + 1}: " << row.to_s
    end
  end
  if row[5] == "x"
    begin
      w = Workshop.new
      w.presentor = row[0]
      w.name = row[1]
      w.description = row[2]
      w.session = 3
      w.room = row[6]
      w.slimit = row[7]
      w.tlimit = row[8]
      w.staken = 0
      w.ttaken = 0
      w.percentage = row[9].blank? ? 66 : row[9].to_i
      w.save!
#    rescue
#      puts "Couldn't make workshop with row #{workshops.rows.index(row) + 1}: " << row.to_s
    end
  end
end
puts "Seeded workshops"  

puts "Downloading students"
students = session.spreadsheet_by_key("0Apg__KXOdrg8dDNYMFVIclFudG9oWm11Ymt6T2RVUXc").worksheets[0]
puts "Downloading students"

puts "Seeding students"
students.rows[1..-1].each do |row|
  begin
    s = Student.new
    s.number = row[0].to_i
    s.last = row[1]
    s.first = row[2]
    s.full = row[3]
    s.gender = row[4]
    s.grade = row[5]
    s.year = row[6]
    s.email = row[8]
    s.prefix = row[9]
    s.rw = row[10]
    s.rw_number = row[13]
    s.rw_teacher = row[15]
    s.advisement = row[22]
    s.save!
#  rescue
#    puts "Couldn't make student with row #{students.rows.index(row) + 1}: " << row.to_s
  end
end
puts "Seeded students"

puts "Downloading teachers"
teachers = session.spreadsheet_by_key("0Apg__KXOdrg8dHRBem5CUC1vanJ3OXlpbWlfMGJLNnc").worksheets[0]
puts "Downloaded teachers"

puts "Seeding teachers"
teachers.rows[1..-1].each do |row|
  begin
    t = Teacher.new
    t.number = row[2]
    t.name = row[3]
    t.prefix = row[6].split("@")[0]
    t.email = row[6]
    t.save!
#  rescue
#    puts "Couldn't make teacher with row #{teachers.rows.index(row) + 1}: " << row.to_s
  end
end
puts "Seeded teachers"
