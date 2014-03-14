["Sarah Warren","Alicia Ziegler"].each do |name|
  t = Teacher.where(name: name).first
  puts t.inspect
  puts "Workshop 1 ID: " unless t.name  === "Sarah Warren"
  id1 = $stdin.gets unless t.name  === "Sarah Warren"
  t.workshops << Workshop.where(id: id1).first unless t.name  === "Sarah Warren"
  
  puts "Workshop 2 ID: " unless t.name  === "Sarah Warren"
  id2 = $stdin.gets unless t.name  === "Sarah Warren"
  t.workshops << Workshop.where(id: id2).first unless t.name  === "Sarah Warren"
  
  
  puts "Workshop 3 ID: " unless t.name  === "Malory Peterson" or t.name === "Alicia Ziegler"
  id3 = $stdin.gets unless t.name  === "Malory Peterson" or t.name === "Alicia Ziegler"
  t.workshops << Workshop.where(id: id3).first unless t.name  === "Malory Peterson" or t.name === "Alicia Ziegler"
  
  t.save!
end
  
