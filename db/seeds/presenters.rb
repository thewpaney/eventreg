require 'csv'

$workshop_url_2018 = "1Ww5qmj89gYDIdB3OCjpM8fvhkFo50mTADvf3eSAjqLQ"

session = GoogleDrive::Session.from_config("config.json")

puts "Downloading spreadsheet"
spreadsheet = session.spreadsheet_by_key($workshop_url_2018)
puts "Downloaded spreadsheet"

teacher_presenters = spreadsheet.worksheets[2]
student_presenters = spreadsheet.worksheets[3]

puts "Seeding student presenters"
student_presenters.rows[1..-1].each do |row|
  p = Student.where(full: row[0]).first
  if p.nil?
    puts "Bad presenter name: #{row[0]}"
    next
  end
  if row[1].include? "1"
    w = Workshop.where(name: row[4], session: 1).first
    if w.nil?
      puts "No workshop named #{row[4]} in session 1"
      next
    end
    if p.workshops.include? w
      puts "#{p.full} already signed up for #{w.name} in session #{w.session}"
    else
      p.workshops << w
      puts "Signed up #{p.full} for workshop #{w.name} in session #{w.session}."
    end
  end
  if row[1].include? "2"
    w = Workshop.where(name: row[4], session: 2).first
    if w.nil?
      puts "No workshop named #{row[4]} in session 1"
      next
    end
    if p.workshops.include? w
      puts "#{p.full} already signed up for #{w.name} in session #{w.session}"
    else
      p.workshops << w
      puts "Signed up #{p.full} for workshop #{w.name} in session #{w.session}."
    end
  end
  if row[1].include? "3"
    w = Workshop.where(name: row[4], session: 3).first
    if w.nil?
      puts "No workshop named #{row[4]} in session 1"
      next
    end
    if p.workshops.include? w
      puts "#{p.full} already signed up for #{w.name} in session #{w.session}"
    else
      p.workshops << w
      puts "Signed up #{p.full} for workshop #{w.name} in session #{w.session}."
    end
  end
  p.save!
end

puts "Seeded student presenters"

puts "Seeding teacher presenters"
teacher_presenters.rows[1..-1].each do |row|
  p = Teacher.where(name: row[0]).first
  if p.nil?
    puts "Bad presenter name: #{row[0]}"
    next
  end
  if row[1].include? "1"
    w = Workshop.where(name: row[2], session: 1).first
    if w.nil?
      puts "No workshop named #{row[2]} in session 1"
      next
    end
    if p.workshops.include? w
      puts "#{p.full} already signed up for #{w.name} in session #{w.session}"
    else
      p.workshops << w
      puts "Signed up #{p.full} for workshop #{w.name} in session #{w.session}."
    end
  end
  if row[1].include? "2"
    w = Workshop.where(name: row[2], session: 2).first
    if w.nil?
      puts "No workshop named #{row[2]} in session 1"
      next
    end
    if p.workshops.include? w
      puts "#{p.full} already signed up for #{w.name} in session #{w.session}"
    else
      p.workshops << w
      puts "Signed up #{p.full} for workshop #{w.name} in session #{w.session}."
    end
  end
  if row[1].include? "3"
    w = Workshop.where(name: row[2], session: 3).first
    if w.nil?
      puts "No workshop named #{row[2]} in session 1"
      next
    end
    if p.workshops.include? w
      puts "#{p.full} already signed up for #{w.name} in session #{w.session}"
    else
      p.workshops << w
      puts "Signed up #{p.full} for workshop #{w.name} in session #{w.session}."
    end
  end
  p.save!
end

puts "Seeded teacher presenters"
