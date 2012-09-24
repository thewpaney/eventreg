class EventController < ApplicationController

  before_filter :authenticate, :only => "review"

  def review
    nil
  end

  private
  def authenticate
    authenticate_or_request_with_http_basic "Authentication Required to Continue" do |username, password|
      username === "letmein" && password === "yesssir"
    end
  end
  
end
