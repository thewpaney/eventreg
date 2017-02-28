# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
# cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# Mayor.create(name: 'Emanuel', city: cities.first)
#
# This is the same as the one we used in 2013

require 'csv'
require "google/apis/drive_v2"

def seed_workshops
  client = Google::Apis::DriveV2::DriveService.new
  auth = client.authorization
  # Follow "Create a client ID and client secret" in
  # https://developers.google.com/drive/web/auth/web-server] to get a client ID and client secret.
  auth.client_id = "15945331926-0728u4paofpjt03ggah2j19modctpv6p.apps.googleusercontent.com"
  auth.client_secret = "BPxAu57AaP-gObUf4MGyjRwd"
  auth.scope =
    "https://www.googleapis.com/auth/drive " +
    "https://spreadsheets.google.com/feeds/"
  auth.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"
  print("1. Open this page:\n%s\n\n" % auth.authorization_uri)
  print("2. Enter the authorization code shown in the page: ")
  auth.code = STDIN.gets.chomp
  auth.fetch_access_token!
  access_token = auth.access_token

  session = GoogleDrive.login_with_oauth(auth.access_token)

  # This is now super deprecated
  # puts "Username and Password, one after the other."
  # session = GoogleDrive.login($stdin.gets, $stdin.gets)
  # puts "Connected to Google"

  puts "Downloading workshops"
  workshops = session.spreadsheet_by_key("1i25k5GQdwSJ_UsFgZByd_g8_TyI2KyJpAjewu7dj95Y").worksheets[0]
  puts "Downloaded workshops"

  puts "Seeding workshops"
  workshops.rows[1..-1].each do |row|
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
        w.save!
        #    rescue
        #      puts "Couldn't make workshop with row #{workshops.rows.index(row) + 1}: " << row.to_s
      end
    end
  end
  puts "Seeded workshops"  
end

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
def seed_students
  index = 1
  puts "Seeding students"
  CSV.foreach("db/students-seed.csv") do |row|
    s = Student.new
    s.id = index
    index += 1
    s.number = row[0].to_i
    #s.last = row[1]
    #s.first = row[2]
    s.full = row[2] + " " + row[1]
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
    puts "saving student #{s.full}"
    s.save!
  end
  puts "Seeded students"
end

# Deprecated - now get from .csv
# puts "Downloading teachers"
# teachers = session.spreadsheet_by_key("0Apg__KXOdrg8dHRBem5CUC1vanJ3OXlpbWlfMGJLNnc").worksheets[0]
# puts "Downloaded teachers"
# 0 BOYS SCHOOL?
# 1 GIRLS SCHOOL?
# 2 RECORD ID
# 3 LAST NAME
# 4 FIRST NAME
# 5 NICKNAME
# 6 EMAIL
# 7 ADVISEMENT
# 8 ROOM #
# 9 2ND PERIOD
# 10 2RW ROOM #
def seed_teachers
  index = 1
  puts "Seeding teachers"
  CSV.foreach("db/teachers-seed.csv") do |row|
    t = Teacher.new
    t.id = index
    index += 1
    t.division = ( row[0] ? "BD" : "GD" )
    t.number = row[2]
    t.name = row[4] + " " + row[3]
    t.prefix = row[6].split("@")[0]
    t.email = row[6]
    t.save!
  end
  puts "Seeded teachers"
end

def seed_presenters
  CSV.foreach("db/presenters.csv") do |row|
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
  CSV.foreach("db/student-presenters.csv") do |row|
    p = Student.where(full: row[0]).first
    puts p.full
    w = Workshop.find(row[1])
    p.workshops << w
    puts "Signed up #{p.full} for workshop #{w.name} in session #{w.session}."
    p.save!
  end
end

# Now actually do it

if STDIN.gets("Google Drive workshops?").chomp === 'y'
  seed_workshops
elsif STDIN.gets("CSV files?").chomp === 'y'
  seed_students
  seed_teachers
elsif STDIN.gets("Presenter CSV files?").chomp === 'y'
  seed_presenters
  seed_student_presenters
end
