require 'resque'
require_relative '../resque.rb'

namespace :jobs do
  desc "Clock process"
  task :clock do
    while true
      case (Time.new.strftime("%M").to_i % 60)
      when 0,30
        puts "Queued backup task."
        Resque.enqueue(Jobs::Backup)
      end
      $stdout.flush
      sleep 60
    end
  end # :clock task
end

