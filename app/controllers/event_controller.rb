require 'csv'

class EventController < ApplicationController
  before_filter :admin!

  def review
    # silence is golden
  end

  def admin
    # silence is golden
  end

  def edit_events
    return unless request.post?
    if params[:event][:id].empty?
      flash[:error] = "Please select a site to modify."
    else 
      e = Event.find(params[:event][:id].to_i)
      e.first.name = params[:event][:name] unless params[:event][:name].empty?
      e.first.capacity = params[:event][:capacity].to_i unless params[:event][:capacity].empty
      if e.first.save
        flash[:message] = "Event successfully updated."
      else
        flash[:message] = "Error modifying event."
      end
    end
  end

  def export
    csv_data = CSV.generate do |csv|
      csv << %w(id name event)
      User.all.collect {|u| [u.id, u.name, (u.event.nil? ? 'NONE' : u.event.name)]}.each {|u| csv << u}
    end
    send_data csv_data, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=eventreg.csv"
  end
end
