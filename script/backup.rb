job = fork do
  system "mysqldump eventreg_development > /www/eventreg/db/backups/dev-#{Time.now.tv_sec}.dmp"
  puts "Saved development database."
  system "mysqldump eventreg_production > /www/eventreg/db/backups/prd-#{Time.now.tv_sec}.dmp"
  puts "Saved production database."
end
Process.detach(job)
