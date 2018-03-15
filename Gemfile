source 'https://rubygems.org'

# Padrino supports Ruby version 2.2.2 and later
ruby '2.4.2'

# Default group
group :default do
  ## DB seeding
  gem 'google_drive'
  gem 'google-api-client'
  ## Adapter
  gem 'puma'
  ## Rake
  gem 'rake'
  ## ORM
  gem 'activerecord', '>= 3.1', :require => 'active_record'
  gem 'activesupport'
  ## Database
  gem 'pg'
  ## Padrino (stable)
  gem 'padrino', '0.14.3'
  ## For displaying nice flash messages
  gem 'sinatra-flash'
  ## Fancy CSS
  gem 'sass'
  gem 'coffee-script'
  ## Background work queue
  gem 'resque'
end

# Testing
group :test do
  gem 'rspec'
  gem 'rack-test'
  gem 'faker', '1.8.0'
end
