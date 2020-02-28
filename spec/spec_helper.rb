ENV["RACK_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

require File.expand_path(File.dirname(__FILE__) + "/../config/application")
Dir[File.expand_path(File.dirname(__FILE__) + "/../app/helpers/*.rb")].each(&method(:require))

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include UserHelper
end

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app Events::App
#   app Events::App.tap { |a| }
#   app(Events::App) do
#     set :foo, :bar
#   end
#
def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Rails.application
end

module AuthHelper
  def http_auth_login
    user = ENV['ADMIN_NAME']
    pw = ENV['ADMIN_PASS']
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end  
end
