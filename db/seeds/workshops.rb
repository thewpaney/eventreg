require 'csv'

$workshop_url_2017 = "1vdMBbJuzvmaPk__yB3zSlXtQvXMtUAMHIs-8L7A6nWI"
$workshop_url_2018 = "1Ww5qmj89gYDIdB3OCjpM8fvhkFo50mTADvf3eSAjqLQ"

session = GoogleDrive::Session.from_config("config.json")

puts "Downloading workshops"
workshops = session.spreadsheet_by_key($workshop_url_2018).worksheets[0]
puts "Downloaded workshops"

puts "Seeding workshops"
success_count = 0
workshops.rows[1..-1].each do |row|
  [1,2,3].each do |session|
    if not row[session + 2].blank? #Third box is first session et cetera
      begin
        if row[0].blank? or row[1].blank?
          raise
        end
        w = Workshop.new
        w.session     = session
        w.presentor   = row[0].blank? ? "TBA" : row[0]
        w.name        = row[1].blank? ? "TBA" : row[1]
        w.description = row[2].blank? ? "TBA" : row[2]
        w.slimit      = row[session+2]
        w.room        = row[6].blank? ? "TBA" : row[6]
        w.tlimit      = row[8].blank? ? 2 : row[8]
        w.percentage  = row[9].blank? ? 66 : row[9].to_i
        w.overflow    = row[10].blank? ? 0 : row[10].to_i
        w.staken      = 0
        w.ttaken      = 0
        w.twofer_ref  = 0
        w.save!
      rescue StandardError => e  
        puts "Message: #{e.message}"
        puts e.backtrace.inspect  
        puts "Couldn't make workshop with row #{workshops.rows.index(row) + 1}: " << row.to_s
      else
        success_count += 1
      end
    end
  end
end

puts "Seeded #{success_count} workshops"
