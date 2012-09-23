class EventController < ApplicationController

  before_filter :authenticate
  
  def review
    redirect_to :controller => "user", :action => "login"
  end
  
  private
  def authenticate
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == USER_NAME && password == PASSWORD
    end
  end
  

end
