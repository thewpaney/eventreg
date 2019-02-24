require 'json'
# Rust enums
divisions = {
  "BD"=> "Boys",
  "GD"=> "Girls" 
}

classes = {
  "9"=> "Freshman",
  "10" => "Sophomore",
  "11" => "Junior",
  "12"=> "Senior"
}

workshop_names = (Workshop.all.map {|w| w.name}).uniq
workshop_ids = {}
workshop_names.each_with_index {|name, index| workshop_ids[name] = index}

serialized = {
  :users=> Student.all.map {|s| { :id => s.id.to_i, 
                                  :division => divisions[s.gender], 
                                  :class => classes[s.year], 
                                  :role => "Student" }},
  :sessions => Workshop.all.map {|w| {:id => w.id, 
                :workshopID => workshop_ids[w.name], 
                :section => w.session - 1,  #in Rust this is an index
                :capacity => w.slimit.to_i,
                :filled => 0 }},
  :users_by_sid=> Student.all.map {|s| s.workshops.map(&:id)},
  :sessions_by_uid => Workshop.all.map {|w| w.students.map(&:id) }
}

File.open('registration.json', 'w') {|file| file.write(JSON.dump serialized)}
