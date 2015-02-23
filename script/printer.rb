job = fork do
  Student.all.each {|s| puts s.full}
end

Process.detach(job)
puts 
puts
puts "MADE IT OUT!"
puts
puts
