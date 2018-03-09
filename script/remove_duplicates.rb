duplicate_users = User.all.collect {|u| u if u.workshop_ids.uniq.length != u.workshop_ids.length}.delete_if {|u| u.nil?}

duplicate_pairs = duplicate_users.collect {|u| [u.id, u.workshop_ids.select {|e| u.workshop_ids.count(e) > 1}.uniq] }

duplicate_pairs.each do |sid, warr|
  wid = warr.first
  u = User.find(sid)
  u.unsignup(wid)
  u.force(wid)
end
