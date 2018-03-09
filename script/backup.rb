# Rather than detaching this job: run it with a worker process
system "pg_dump eventreg_development > " + Padrino.root + "/backups/dev-#{Time.now.tv_sec}.dmp"
puts "Saved development database."
system "pg_dump eventreg_production > " + Padrino.root + "/backups/prd-#{Time.now.tv_sec}.dmp"
puts "Saved production database."

