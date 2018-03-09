require 'csv'

$workshop_spreadsheet_key = "1Ww5qmj89gYDIdB3OCjpM8fvhkFo50mTADvf3eSAjqLQ"

session = GoogleDrive::Session.from_config("config.json")

puts "Downloading spreadsheet"
spreadsheet = session.spreadsheet_by_key($workshop_spreadsheet_key)
puts "Downloaded spreadsheet"

# Mark Diversity Action Group students
dag_students = spreadsheet.worksheets[1]

puts "Marking special user characteristics"
dag_students.rows[1..-1].each do |row|
  s = User.where(prefix: row[1]).first
  if s.nil?
    puts "Bad user prefix #{row[1]}"
    next
  end
  s.special = "DAG"
  s.save!
end
