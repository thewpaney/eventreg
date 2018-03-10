class Registration
  @@transaction = []
  @@ttime = 0
  @queue = :db

  def self.perform(user, workshop)
    if @@trasaction.length < ENV['WEB_CONCURRENCY'] or (Time.now.to_f - @@ttime) < 0.05
      @@transaction << [user, workshop]
    else
      # Actually perform DB transaction
      ActiveRecord::Base.transaction do
        @@transaction.each do |arr|
          uid = arr.shift
          sign_up_user(uid, arr)
        end
      end
      @@transaction = []
      @@ttime = Time.now.to_f
      rescue ActiveRecord::ActiveRecordError => e
        puts e.inspect
      end
    end
  end
end
