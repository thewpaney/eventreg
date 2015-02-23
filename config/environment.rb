# Load the Rails application.
require File.expand_path('../application', __FILE__)

ActionMailer::Base.delivery_method = :sendmail

#ActionMailer::Base.sendmail_settings = { :address => "smtp.gmail.com",
#     :port => "587", :domain => "gmail.com", :user_name => "diversity.mailer@gmail.com", 
#  :password => "kurdmcfrogspleen", :authentication => "plain", :enable_starttls_auto => true }

# Initialize the Rails application.
Eventreg::Application.initialize!

