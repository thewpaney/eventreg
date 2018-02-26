puts 'Username and Password, one after the other.'
session = GoogleDrive.login($stdin.gets, $stdin.gets)
puts 'Connected to Google'

puts 'Downloading workshops'
workshops = session.spreadsheet_by_key('0AiFYq092sE5adFVBNVg4ZWVyUEhiUUdia1VyUVo0MXc').worksheets[0]
puts 'Downloaded workshops'

puts 'Updating workshops by name'
workshops.rows[1..-1].each do |row|
  if row[3] == 'x'
    w = Workshop.firsts.where(name: row[1]).first
    (w.nil?) ? (puts 'No match for #{row[0]}: #{row[1]}'; next;) : w
    (w.presentor != row[0]) ? (puts 'Updated presentor of #{w.id} from #{w.presentor} to #{w.presentor = row[0]}') : (puts 'No presentor changes for #{w.id}')
    (w.slimit != row[7]) ? (puts 'Updated slimit of #{w.id} from #{w.slimit} to #{w.slimit = row[7]}') : (puts 'No slimit changes for #{w.id}')
    (w.tlimit != ( row[8].blank? ? 2 : row[8] ) ) ? ( puts 'Updated tlimit of #{w.id} from #{w.tlimit} to #{w.tlimit = row[8].blank? ? 2 : row[8]}' ) : ( puts 'No tlimit changes for #{w.id}' )
    w.save!
  end
  if row[4] == 'x'
    w = Workshop.seconds.where(name: row[1]).first
    (w.nil?) ? (puts 'No match for #{row[0]}: #{row[1]}'; next;) : w
    (w.presentor != row[0]) ? (puts 'Updated presentor of #{w.id} from #{w.presentor} to #{w.presentor = row[0]}') : (puts 'No presentor changes for #{w.id}')
    (w.slimit != row[7]) ? (puts 'Updated slimit of #{w.id} from #{w.slimit} to #{w.slimit = row[7]}') : (puts 'No slimit changes for #{w.id}')
    (w.tlimit != ( row[8].blank? ? 2 : row[8] ) ) ? ( puts 'Updated tlimit of #{w.id} from #{w.tlimit} to #{w.tlimit = row[8].blank? ? 2 : row[8]}' ) : ( puts 'No tlimit changes for #{w.id}' )
    w.save!
  end
  if row[5] == 'x'
    w = Workshop.thirds.where(name: row[1]).first
    (w.nil?) ? (puts 'No match for #{row[0]}: #{row[1]}'; next;) : w
    (w.presentor != row[0]) ? (puts 'Updated presentor of #{w.id} from #{w.presentor} to #{w.presentor = row[0]}') : (puts 'No presentor changes for #{w.id}')
    (w.slimit != row[7]) ? (puts 'Updated slimit of #{w.id} from #{w.slimit} to #{w.slimit = row[7]}') : (puts 'No slimit changes for #{w.id}')
    (w.tlimit != ( row[8].blank? ? 2 : row[8] ) ) ? ( puts 'Updated tlimit of #{w.id} from #{w.tlimit} to #{w.tlimit = row[8].blank? ? 2 : row[8]}' ) : ( puts 'No tlimit changes for #{w.id}' )
    w.save!
  end
end
puts 'Updated workshops by name'

puts 'Updating workshops by presentor'
workshops.rows[1..-1].each do |row|
  if row[3] == 'x'
    w = Workshop.firsts.where(presentor: row[0]).first
    (w.nil?) ? (puts 'No match for #{row[0]}: #{row[1]}'; next;) : w
    (w.name != row[1]) ? (puts 'Updated name of #{w.id} from #{w.name} to #{w.name = row[1]}') : (puts 'No name changes for #{w.id}' )
    (w.slimit != row[7]) ? (puts 'Updated slimit of #{w.id} from #{w.slimit} to #{w.slimit = row[7]}') : (puts 'No slimit changes for #{w.id}')
    (w.tlimit != ( row[8].blank? ? 2 : row[8] ) ) ? ( puts 'Updated tlimit of #{w.id} from #{w.tlimit} to #{w.tlimit = row[8].blank? ? 2 : row[8]}' ) : ( puts 'No tlimit changes for #{w.id}' )
    w.save!
  end
  if row[4] == 'x'
    w = Workshop.seconds.where(presentor: row[0]).first
    (w.nil?) ? (puts 'No match for #{row[0]}: #{row[1]}'; next;) : w
    (w.name != row[1]) ? (puts 'Updated name of #{w.id} from #{w.name} to #{w.name = row[1]}') : (puts 'No name changes for #{w.id}')
    (w.slimit != row[7]) ? (puts 'Updated slimit of #{w.id} from #{w.slimit} to #{w.slimit = row[7]}') : (puts 'No slimit changes for #{w.id}')
    (w.tlimit != ( row[8].blank? ? 2 : row[8] ) ) ? ( puts 'Updated tlimit of #{w.id} from #{w.tlimit} to #{w.tlimit = row[8].blank? ? 2 : row[8]}' ) : ( puts 'No tlimit changes for #{w.id}' )
    w.save!
  end
  if row[5] == 'x'
    w = Workshop.thirds.where(presentor: row[0]).first
    (w.nil?) ? (puts 'No match for #{row[0]}: #{row[1]}'; next;) : w
    (w.name != row[1]) ? (puts 'Updated name of #{w.id} from #{w.name} to #{w.name = row[1]}') : (puts 'No name changes for #{w.id}')
    (w.slimit != row[7]) ? (puts 'Updated slimit of #{w.id} from #{w.slimit} to #{w.slimit = row[7]}') : (puts 'No slimit changes for #{w.id}')
    (w.tlimit != ( row[8].blank? ? 2 : row[8] ) ) ? ( puts 'Updated tlimit of #{w.id} from #{w.tlimit} to #{w.tlimit = row[8].blank? ? 2 : row[8]}' ) : ( puts 'No tlimit changes for #{w.id}' )
    w.save!
  end
end
puts 'Updated workshops by presentor'
