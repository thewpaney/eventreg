source 'https://rubygems.org'

ruby '2.6.5'

# Heroku recommendations
gem 'rails_12factor'
gem 'puma'

# Rails base
gem 'rails'
gem 'jquery-rails'
gem 'rake'

# DB seeding
gem 'google_drive'
gem 'google-api-client'
gem 'rack-utf8_sanitizer'  # To allow accents in names

# Protect us from ourselves
gem 'protected_attributes'

# Nicer debug/console output
gem 'awesome_print'

# For alerts on how to improve queries
group :development, :test, :staging do
  gem 'bullet'  # For alerts on how to improve queries
end

# Heroku database driver
group :staging, :production do
  gem 'pg'  # For Heroku Postgres
end

# CI/local database driver
group :development, :test do
  gem 'sqlite3'
end

# Caching and fancy views
gem 'actionpack-page_caching'
gem 'actionpack-action_caching'
gem 'execjs'
gem 'turbolinks'

# Asset gems - not needed in production (assets are precompiled)
group :assets do
  gem 'sass-rails'       # Better than CSS
  gem 'coffee-rails'     # CoffeeScript
  gem 'zurb-foundation'  # Page structure
  gem 'uglifier'         # Optimize and mangle JS
end

