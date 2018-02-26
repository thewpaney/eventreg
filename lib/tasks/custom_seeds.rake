namespace :db do
  namespace :seed do
    Dir[Rails.root.join('db', 'seeds', '*.rb')].each do |filename|
      task_name = File.basename(filename, '.rb')
      desc "Seed " + task_name + ", based on the file with the same name in `db/seeds/*.rb`"
      task task_name.to_sym => :environment do
        load(filename) if File.exist?(filename)
      end
    end
  end
  namespace :workshops do
    desc "Update workshops using names as references"
    task :update_name => :environment do
      load(Rails.root.join('script','update-workshops-name.rb'))
    end
    desc "Update workshops using presenters as references"
    task :update_presenter => :environment do
      load(Rails.root.join('script','update-workshops-presenter.rb'))
    end
    desc "Update workshops first by name, then by presenter"
    task :update => :environment do
      load(Rails.root.join('script','update-workshops-name.rb'))
      load(Rails.root.join('script','update-workshops-presenter.rb'))
    end
  end
end
