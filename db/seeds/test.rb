# Deterministic random seed
# Definitely not my library card number
Faker::Config.random = Random.new(23025003306107)

nStudents = 1600
nTeachers = 200
nSingleWorkshops = 20
nDoubleWorkshops = 20
nTripleWorkshops = 30
nTwoferWorkshops = 2
nWorkshopsTot = nSingleWorkshops + nDoubleWorkshops + nTripleWorkshops + nTwoferWorkshops

User.delete_all

# puts "Seeding test database with:"
# $stdout.write "#{nStudents} students... "
nStudents.times do |id|
  s = User.new
  s.full = Faker::Name.name
  s.division = Faker::Number.sample(["GD", "BD"])
  s.year = Faker::Number.sample([9,10,11,12])
  s.number = Faker::Number.number(9)
  s.prefix = Faker::Internet.user_name(s.full)
  s.email = s.prefix + "@regisjesuit.com"
  s.role = "student"
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
  t.role = "teacher"
  t.save!
end
# puts "Done."

# Workshops
load 'db/seeds/workshops.rb'
# Done
