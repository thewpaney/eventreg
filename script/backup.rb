job = fork do
  system "mysqldump eventreg_development > /root/eventreg/db/dev-#{Time.now.tv_sec}.dmp"
  puts "Saved development database."
  system "mysqldump eventreg_production > /root/eventreg/db/prd-#{Time.now.tv_sec}.dmp"
  puts "Saved production database."
end
Process.detach(job)
