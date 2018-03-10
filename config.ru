#!/usr/bin/env rackup
# encoding: utf-8

require 'resque/server'

require File.expand_path("../config/boot.rb", __FILE__)

if ENV['RACK_ENV'] == "production"
  run Padrino.application
else
  run Rack::URLMap.new "/" => Padrino.application, "/resque" => Resque::Server.new
end
