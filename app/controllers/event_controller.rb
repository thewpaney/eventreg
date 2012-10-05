require 'csv'

class EventController < ApplicationController
  before_filter :authenticate

  def review
    nil
  end

  def export
    csv_data = CSV.generate do |csv|
      User.all.collect {|u| [u.name, (u.event.nil? 'NONE' : u.event.name)]}.each {|u| csv << u}
    end
    send_data csv_data, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=eventreg.csv"
  end

  def admin
    nil
  end

  def edit_events
    if request.post?
      
    end
    nil
  end
  
  def edit_users
    if request.post?
      
    end
    nil
  end
  
  private
  def authenticate
    authenticate_or_request_with_http_basic "Authentication Required to Continue" do |username, password|
      username === "letmein" && password === "yesssir"
    end
  end
end
