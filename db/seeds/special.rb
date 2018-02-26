require 'csv'

$workshop_url_2018 = "1Ww5qmj89gYDIdB3OCjpM8fvhkFo50mTADvf3eSAjqLQ"

session = GoogleDrive::Session.from_config("config.json")

puts "Downloading spreadsheet"
spreadsheet = session.spreadsheet_by_key($workshop_url_2018)
puts "Downloaded spreadsheet"

dag_students = spreadsheet.worksheets[1]

puts "Marking special student characteristics"
dag_students.rows[1..-1].each do |row|
  s = Student.where(prefix: row[1]).first
  if s.nil?
    puts "Bad student prefix #{row[1]}"
    next
  end
  s.special = "DAG"
  s.save!
end
