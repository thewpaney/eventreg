# Load the Rails application.
require File.expand_path('../application', __FILE__)

ActionMailer::Base.delivery_method = :sendmail

ActionMailer::Base.sendmail_settings = { :address => "smtp.office365.com",
     :port => "587", :domain => "regisjesuit.com", :user_name => "diversityprogram@regisjesuit.com", 
  :password => "D!verse1877", :authentication => "plain", :enable_starttls_auto => true }

# Initialize the Rails application.
Eventreg::Application.initialize!

