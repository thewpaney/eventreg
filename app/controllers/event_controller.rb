class EventController < ApplicationController

  before_filter :authenticate, :only => "review"

  def review
    nil
  end

  private
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      if(username == "letmein" && password == "yesssir")
        true
      else
        redirect_to :controller => "user", :action => "login"
      end
    end
  end

end
