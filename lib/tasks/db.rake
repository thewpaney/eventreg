namespace :db do
  desc "Drop, create, migrate, seed.  One step further than reset."
  task reload: :environment do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
  end

end
