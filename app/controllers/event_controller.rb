require 'CSV'

class EventController < ApplicationController

  before_filter :authenticate

  def review
    nil
  end

  def export
    csv_data = CSV.generate do |csv|
      User.all.each do |u|
        e = Event.find(:first, :conditions => ["id=?", u.event_id])
        if e.nil?
          ename = "NONE"
        else
          ename = e.name
        end
        csv << [u[:name], ename]
      end
    end
    send_data csv_data, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=serviceprojects.csv"
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
