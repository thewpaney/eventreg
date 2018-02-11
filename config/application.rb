require File.expand_path('../boot', __FILE__)

require 'rails/all'

# require "/www/eventreg/app/middleware/handle_invalid_percent_encoding.rb"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Eventreg
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    config.assets.enabled = true
    config.serve_static_files = true

    # Custom error pages!
    config.exceptions_app = self.routes

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # NOTE: These must be in this order relative to each other.
    # HandleInvalidPercentEncoding just raises for encoding errors it doesn't cover,
    # so it must run after (= be inserted before) Rack::UTF8Sanitizer.
    #config.middleware.insert 0, HandleInvalidPercentEncoding
    config.middleware.insert 0, Rack::UTF8Sanitizer  # from a gem
  end
end
