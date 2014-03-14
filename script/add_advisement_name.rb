require 'csv'
# Deprecated - now grab from .csv
# puts "Downloading students"
# students = session.spreadsheet_by_key("0Apg__KXOdrg8dDNYMFVIclFudG9oWm11Ymt6T2RVUXc").worksheets[0]
# puts "Downloading students"

# Student fields:
# <Student id: nil, number: nil, full: nil, gender: nil, grade: nil, year: nil, email: nil, prefix: nil, rw: nil, rw_number: nil, rw_teacher: nil, advisement: nil>
# .csv rows:
# 0  STUDENT ID
# 1  StsSt_IntegrationID
# 2  STUDENT LAST NAME
# 3  STUDENT FIRST NAME
# 4  DIVISION
# 5  CURRENT GRADE
# 6  STUDENT CELL
# 7  STUDENT EMAIL
# 8  ADVISEMENT
# 9  ADVISEMENT ROOM
# 10 ADVISEMENT TEACHER LAST NAME
# 11 ADVISEMENT TEACHER FULL NAME
# 12 PERIOD 2
# 13 PERIOD 2 ROOM
# 14 PERIOD 2 TEACHER LAST NAME
# 15 PERIOD 2 TEACHER FULL NAME

puts "Updating students"
CSV.foreach("db/students-seed.csv") do |row|
  ActiveRecord::Base.connection.update("UPDATE `students` SET advisement_name = '#{row[10].gsub('\'',' ')}' WHERE number = #{row[0]}")
end
puts "Updated students"

