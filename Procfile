# Web dyno configuration
web: bundle exec puma -C config/puma.rb

# Worker dyno configuration
worker: bundle exec rake jobs:work

# Clock dyno (make this a free-tier one!) that schedules timed worker jobs
clock: bundle exec rake jobs:clock

# One-off dyno that runs when staging is promoted to production
release: bundle exec rake db:migrate

