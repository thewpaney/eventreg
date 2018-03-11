# Web dyno configuration
web: bundle exec puma -C config/puma.rb

# Worker dyno configuration
worker: INTERVAL=0.1 QUEUE=db bundle exec rake resque:work

# Clock dyno (make this a free-tier one!) that schedules timed worker jobs
clock: bundle exec rake jobs:clock

# One-off dyno that runs when staging is promoted to production
release: rake db:migrate

