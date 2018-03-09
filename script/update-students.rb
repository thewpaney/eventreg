require 'csv'

puts "Updating student advisement_name fields..."
CSV.foreach("db/students-seed.csv") do |row|
  ActiveRecord::Base.connection.update("UPDATE `users` SET advisement_name = '#{row[10].gsub('\'',' ')}' WHERE number = #{row[0]}")
end
puts "Updated student advisement_name fields."
