# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'csv'

$workshop_url_2017 = "1vdMBbJuzvmaPk__yB3zSlXtQvXMtUAMHIs-8L7A6nWI"
$workshop_url_2018 = "1Ww5qmj89gYDIdB3OCjpM8fvhkFo50mTADvf3eSAjqLQ"

$student_csv = "db/students-seed.2018.csv"
$teacher_csv = "db/teachers-seed.2018.csv"

def seed_workshops

  session = GoogleDrive::Session.from_config("config.json")

  puts "Downloading workshops"
  workshops = session.spreadsheet_by_key($workshop_url_2018).worksheets[0]
  puts "Downloaded workshops"

  puts "Seeding workshops"
  workshops.rows[1..-1].each do |row|
    # Twofers sessions 1->2
    if (row[3] == "d" and row[4] == "d")
      begin
        w1 = Workshop.new
        w1.presentor = row[0].blank? ? "TBA" : row[0]
        w1.name = row[1].blank? ? "TBA" : row[1]
        w1.name += " (Part One)"
        w1.description = row[2].blank? ? "TBA" : row[2]
        w1.description += "\n\nThis workshop is part one of a two-part workshop.\nRegistering for this workshop will automatically register you for\npart two, and vice-versa."
        w1.session = 1
        w1.room = row[6].blank? ? "TBA" : row[6]
        w1.slimit = row[7].blank? ? "TBA" : row[7]
        w1.tlimit = row[8].blank? ? 2 : row[8]
        w1.staken = 0
        w1.ttaken = 0
        w1.percentage = row[9].blank? ? 66 : row[9].to_i
        w1.overflow = row[10].blank? ? 0 : row[10].to_i
        w1.twofer_ref = 0
        w1.save!
        w2 = Workshop.new
        w2.presentor = row[0].blank? ? "TBA" : row[0]
        w2.name = row[1].blank? ? "TBA" : row[1]
        w2.name += " (Part Two)"
        w2.description = row[2].blank? ? "TBA" : row[2]
        w2.description += "\n\nThis workshop is part two of a two-part workshop.\nRegistering for this workshop will automatically register you for\npart one, and vice-versa."
        w2.session = 2
        w2.room = row[6].blank? ? "TBA" : row[6]
        w2.slimit = row[7].blank? ? "TBA" : row[7]
        w2.tlimit = row[8].blank? ? 2 : row[8]
        w2.staken = 0
        w2.ttaken = 0
        w2.percentage = row[9].blank? ? 66 : row[9].to_i
        w2.overflow = row[10].blank? ? 0 : row[10].to_i
        w2.twofer_ref = 0
        w2.save!
        w1.twofer_ref = w2.id
        w2.twofer_ref = w1.id
        w1.save!
        w2.save!
      end
    end
    # Twofers sessions 2->3
    if (row[4] == "d" and row [5] == "d")
      begin
        w1 = Workshop.new
        w1.presentor = row[0].blank? ? "TBA" : row[0]
        w1.name = row[1].blank? ? "TBA" : row[1]
        w1.name += " (Part One)"
        w1.description = row[2].blank? ? "TBA" : row[2]
        w1.description += "\n\nThis workshop is part one of a two-part workshop.\nRegistering for this workshop will automatically register you for\npart two, and vice-versa."
        w1.session = 2
        w1.room = row[6].blank? ? "TBA" : row[6]
        w1.slimit = row[7].blank? ? "TBA" : row[7]
        w1.tlimit = row[8].blank? ? 2 : row[8]
        w1.staken = 0
        w1.ttaken = 0
        w1.percentage = row[9].blank? ? 66 : row[9].to_i
        w1.overflow = row[10].blank? ? 0 : row[10].to_i
        w1.twofer_ref = 0
        w1.save!
        w2 = Workshop.new
        w2.presentor = row[0].blank? ? "TBA" : row[0]
        w2.name = row[1].blank? ? "TBA" : row[1]
        w2.name += " (Part Two)"
        w2.description = row[2].blank? ? "TBA" : row[2]
        w2.description += "\n\nThis workshop is part two of a two-part workshop.\nRegistering for this workshop will automatically register you for\npart one, and vice-versa."
        w2.session = 3
        w2.room = row[6].blank? ? "TBA" : row[6]
        w2.slimit = row[7].blank? ? "TBA" : row[7]
        w2.tlimit = row[8].blank? ? 2 : row[8]
        w2.staken = 0
        w2.ttaken = 0
        w2.percentage = row[9].blank? ? 66 : row[9].to_i
        w2.overflow = row[10].blank? ? 0 : row[10].to_i
        w2.twofer_ref = 0
        w2.save!
        w1.twofer_ref = w2.id
        w2.twofer_ref = w1.id
        w1.save!
        w2.save!
      end
    end
    if row[3] == "x"
      begin
        w = Workshop.new
        w.presentor = row[0].blank? ? "TBA" : row[0]
        w.name = row[1].blank? ? "TBA" : row[1]
        w.description = row[2].blank? ? "TBA" : row[2]
        w.session = 1
        w.room = row[6].blank? ? "TBA" : row[6]
        w.slimit = row[7].blank? ? "TBA" : row[7]
        w.tlimit = row[8].blank? ? 2 : row[8]
        w.staken = 0
        w.ttaken = 0
        w.percentage = row[9].blank? ? 66 : row[9].to_i
        w.overflow = row[10].blank? ? 0 : row[10].to_i
        w.twofer_ref = 0
        w.save!
        #     rescue
        #       puts "Couldn't make workshop with row #{workshops.rows.index(row) + 1}: " << row.to_s
      end
    end
    if row[4] == "x"
      begin
        w = Workshop.new
        w.presentor = row[0].blank? ? "TBA" : row[0]
        w.name = row[1].blank? ? "TBA" : row[1]
        w.description = row[2].blank? ? "TBA" : row[2]
        w.session = 2
        w.room = row[6].blank? ? "TBA" : row[6]
        w.slimit = row[7].blank? ? "TBA" : row[7]
        w.tlimit = row[8].blank? ? 2 : row[8]
        w.staken = 0
        w.ttaken = 0
        w.percentage = row[9].blank? ? 66 : row[9].to_i
        w.overflow = row[10].blank? ? 0 : row[10].to_i
        w.twofer_ref = 0
        w.save!
        #    rescue
        #      puts "Couldn't make workshop with row #{workshops.rows.index(row) + 1}: " << row.to_s
      end
    end
    if row[5] == "x"
      begin
        w = Workshop.new
        w.presentor = row[0].blank? ? "TBA" : row[0]
        w.name = row[1].blank? ? "TBA" : row[1]
        w.description = row[2].blank? ? "TBA" : row[2]
        w.session = 3
        w.room = row[6].blank? ? "TBA" : row[6]
        w.slimit = row[7].blank? ? "TBA" : row[7]
        w.tlimit = row[8].blank? ? 2 : row[8]
        w.staken = 0
        w.ttaken = 0
        w.percentage = row[9].blank? ? 66 : row[9].to_i
        w.overflow = row[10].blank? ? 0 : row[10].to_i
        w.twofer_ref = 0
        w.save!
        #    rescue
        #      puts "Couldn't make workshop with row #{workshops.rows.index(row) + 1}: " << row.to_s
      end
    end
  end
  puts "Seeded workshops"
end

def seed_students
  index = 1
  contents = CSV.read($student_csv, col_sep: ",", encoding: "ISO8859-1")
  puts "Seeding students"
  contents.each do |row|
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
end

def seed_teachers
  index = 1
  contents = CSV.read($teacher_csv, col_sep: ",", encoding: "ISO8859-1")
  puts "Seeding teachers"
  contents.each do |row|
    t = Teacher.new
    t.id = index
    index += 1
    t.division = ( row[0] ? "BD" : "GD" )
    t.number = row[2]
    t.name = (row[4] + " " + row[3])
    t.prefix = row[6].split("@")[0]
    t.email = row[6]
    t.save!
  end
  puts "Seeded teachers"
end

def seed_presenters
  contents = CSV.read("db/presenters.csv", col_sep: ",", encoding: "ISO8859-1")

  contents.each do |row|
    p = Teacher.where(name: row[0]).first
    if p.nil?
      p = Teacher.where(name: row[1]).first
    end
    puts p.name
    Workshop.all.each do |w|
      if w.presentor.include?(row[0])
        p.workshops << w
        puts "Signed up #{p.full} for workshop #{w.name} in session #{w.session}."
        p.save!
      elsif !row[1].nil?
        if w.presentor.include?(row[1])
          p.workshops << w
          puts "Signed up #{p.full} for workshop #{w.name} in session #{w.session}."
          p.save!
        end
      end
    end
  end
end

def seed_student_presenters
  contents = CSV.read("db/student-presenters.csv", col_sep: ",", encoding: "ISO8859-1")
  contents do |row|
    p = Student.where(full: row[0]).first
    puts p.full
    w = Workshop.find(row[1])
    p.workshops << w
    puts "Signed up #{p.full} for workshop #{w.name} in session #{w.session}."
    p.save!
  end
end

def seed_presenters_from_drive
  session = GoogleDrive::Session.from_config("config.json")

  puts "Downloading presenters"
  presenters = session.spreadsheet_by_key("1vdMBbJuzvmaPk__yB3zSlXtQvXMtUAMHIs-8L7A6nWI").worksheets[1]
  puts "Downloaded presenters"

  presenters.rows[1..-1].each do |row|
    p = Student.where(full: row[0]).first
    if p.nil?
      p = Teacher.where(name: row[0]).first
    end
    if p.nil?
      puts "Bad presenter name: #{row[0]}"
      next
    end
    if row[1] == "x"
      w = Workshop.where(name: row[4], session: 1).first
      if w.nil?
        puts "No workshop named #{row[4]} in session 1"
        next
      end
      p.workshops << w
      puts "Signed up #{p.full} for workshop #{w.name} in session #{w.session}."
    end
    if row[2] == "x"
      w = Workshop.where(name: row[4], session: 2).first
      if w.nil?
        puts "No workshop named #{row[4]} in session 1"
        next
      end
      p.workshops << w
      puts "Signed up #{p.full} for workshop #{w.name} in session #{w.session}."
    end
    if row[3] == "x"
      w = Workshop.where(name: row[4], session: 3).first
      if w.nil?
        puts "No workshop named #{row[4]} in session 1"
        next
      end
      p.workshops << w
      puts "Signed up #{p.full} for workshop #{w.name} in session #{w.session}."
    end
    p.save!
  end
end

# Now actually do it

seed_workshops
seed_students
seed_teachers
seed_presenters_from_drive

#puts "Google drive workshops?"
#if $stdin.gets.chomp === 'y'
#  seed_workshops
#end
#puts "Students and Teachers?"
#if $stdin.gets.chomp === 'y'
#  seed_students
#  seed_teachers
#end
#puts "Presenter CSV files?"
#if $stdin.gets.chomp === 'y'
#  seed_presenters
#  seed_student_presenters
#end
#puts "Presenters from Drive?"
#if $stdin.gets.chomp === 'y'
#  seed_presenters_from_drive
#end
