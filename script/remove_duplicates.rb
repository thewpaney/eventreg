duplicate_students = Student.all.collect {|s| s if s.workshop_ids.uniq.length != s.workshop_ids.length}.delete_if {|s| s.nil?}

duplicate_pairs = duplicate_students.collect {|s| [s.id, s.workshop_ids.select {|e| s.workshop_ids.count(e) > 1}.uniq] }

duplicate_pairs.each do |sid, warr|
  wid = warr.first
  s = Student.find(sid)
  s.unsignup(wid)
  s.force(wid)
end
