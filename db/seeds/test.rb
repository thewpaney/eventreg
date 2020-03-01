# Deterministic random seed
# Definitely not my library card number
Faker::Config.random = Random.new(23025003306107)

nStudents = 1600
nTeachers = 200
nSingleWorkshops = 30
nDoubleWorkshops = 40
nTripleWorkshops = 20
nTwoferWorkshops = 2
nWorkshopsTot = nSingleWorkshops + nDoubleWorkshops + nTripleWorkshops + nTwoferWorkshops

Student.delete_all
Teacher.delete_all
Workshop.delete_all

# puts "Seeding test database with:"
# $stdout.write "#{nStudents} students... "
nStudents.times do |id|
  s = User.new
  s.full = Faker::Name.name
  s.division = Faker::Number.sample(["GD", "BD"])
  s.year = Faker::Number.sample([9,10,11,12])
  s.number = Faker::Number.number(9)
  s.prefix = Faker::Internet.user_name(s.full)
  s.email = s.prefix + "@student.regisjesuit.com"
  s.save!
end
# puts "Done."

# $stdout.write "#{nTeachers} teachers... "
nTeachers.times do |id|
  t = User.new
  t.full = Faker::Name.name
  t.division = Faker::Number.sample(["GD", "BD"])
  t.number = Faker::Number.number(4)
  t.prefix = Faker::Internet.user_name(t.full)
  t.email = t.prefix + "@regisjesuit.com"
  t.save!
end
# puts "Done."

def genWorkshop()
  w = Workshop.new
  w.name = Faker::Educator.course_name
  w.presentor = Faker::Name.prefix + " " + Faker::Name.name
  w.description = Faker::Hipster.paragraph
  w.session = Faker::Number.sample([1,2,3])
  w.tlimit = Faker::Number.sample([2,2,2,2,2,2,2,2,3,4,])
  w.slimit = Faker::Number.sample([10,10,20,20,20,20,20,30,30,60])
  w.room = Faker::Nation.capital_city
  w.ttaken = 0
  w.staken = 0
  w.overflow = 0
  w.percentage = 66
  w.twofer_ref = nil
  return w
end

# Workshops
nSingleWorkshops.times do |id|
  w = genWorkshop()
  w.save!
end

nDoubleWorkshops.times do |id|
  w = genWorkshop()
  sessions = Faker::Number.sample([[1,2],[2,3],[1,3]])
  Faker::Number.sample(sessions).each do |s|
    w2 = w.dup()
    w2.session = s
    w2.save!
  end
end

nTripleWorkshops.times do |id|
  w = genWorkshop()
  [1,2,3].each do |s|
    w2 = w.dup()
    w2.session = s
    w2.save!
  end
end

# Twofers

# 50-50 (dance) workshops

# Done
