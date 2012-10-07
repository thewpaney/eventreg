namespace :page do
  namespace :cache do

    desc "Clean user page cache"
    task :user_clean => :environment do
      UserSweeper.sweep
    end
  end
end
