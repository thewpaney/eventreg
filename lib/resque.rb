module Jobs
  class Backup
    @queue = :db
    
    def self.perform()
      system "pg_dump events_development > public/backups/dev-#{Time.now.tv_sec}.dmp"
      puts "Saved development database."
      system "pg_dump events_production > public/backups/prd-#{Time.now.tv_sec}.dmp"
      puts "Saved production database."
    end
  end

  class Register
    @@transaction = []
    @@ttime = 0
    @queue = :db
    
    def self.perform(user, workshop)
      puts self.inspect
      bandwidth = Integer(ENV['WEB_CONCURRENCY'] || 2)
      if @@transaction.length < bandwidth or (Time.now.to_f - @@ttime) < 0.05
        puts "Added to transaction buffer"
        @@transaction << [user, workshop]
        @@ttime += 1
        puts "Did it!"
        puts "Time: #{@@ttime}"
      else
        # Actually perform DB transaction
        @@transaction << [user, workshop]
        begin
          ActiveRecord::Base.transaction do
            # INSERT INTO users_workshops (user_id, workshop_id) VALUES
            # Build query string
            q = "INSERT INTO users_workshops (user_id, workshop_id) VALUES"
            @@transaction.each do |t|
              q = q + " (#{t.first}, #{t.last}),"
            end
            q = q.chop + ";"
            puts "### BEGIN"
            ActiveRecord::Base.connection.execute(q)
            puts "### END"
          end
        rescue ActiveRecord::ActiveRecordError
          puts "Could not complete transaction"
        end
        @@transaction = []
        @@ttime = Time.now.to_f
      end
    end
  end
end
