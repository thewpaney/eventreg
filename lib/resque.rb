require 'padrino'

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
  
  class Registration
    @@transaction = []
    @@ttime = 0
    @queue = :db
    
    def self.perform(user, workshop)
      if @@trasaction.length < ENV['WEB_CONCURRENCY'] or (Time.now.to_f - @@ttime) < 0.05
        @@transaction << [user, workshop]
      else
        # Actually perform DB transaction
        begin
          ActiveRecord::Base.transaction do
            # INSERT INTO users_workshops (user_id, workshop_id) VALUES
            # Build query string
            q = "INSERT INTO users_workshops (user_id, workshop_id) VALUES"
            @@transactions.each do |t|
              q = q + " (#{t.first}, #{t.last}),"
            end
            q = q.chop + ";"
            ActiveRecord::Base.connection.execute(q)
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
