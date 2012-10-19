require 'csv'

class EventController < ApplicationController
  before_filter :admin!

  def review
    # silence is golden
  end

  def admin
    # silence is golden
  end

  def edit_users
    return unless request.post?
    if params[:user][:id].empty?
      flash[:error] = "No user selected!"
      return
    elsif params[:event][:id].empty?
      flash[:error] = "No event action selected!"
      return
    end
    u = User.where(:id => params[:user][:id].to_i).first
    if u.nil?
      flash[:error] = "Invalid user!"
      return
    end
    if params[:event][:id] == "--Unregister--"
      u.event = nil
      u.save!
      flash[:message] = "Unregistered!"
    else
      u.event = Event.where(:id => params[:event][:id]).first
      u.event_id = (u.event.id ? u.event.id : nil)
      if u.save!
        flash[:message] = "Successfully updated user #{u.name}."
      else
        flash[:message] = "Error saving user!"
      end
    end
  end

  def edit_events
    return unless request.post?
    if !(params[:new].nil?) and params[:new] == "false"
      if !params[:event][:name].empty? and !params[:event][:capacity].empty?
        if Event.new(:name => params[:event][:name], :capacity => params[:event][:capacity]).save!
          flash[:message] = "Event created successfully."
        else
          flash[:message] = "Error creating event.  E-mail the developers."
        end
      else
        flash[:error] = "Please specify a name and a capacity when creating a new site."
      end
    elsif params[:event][:id].empty?
      flash[:error] = "Please select a site to modify."
    elsif !(params[:kill].nil?) and params[:kill] == "false"
      Event.find(params[:event][:id].to_i).destroy
      flash[:message] = "Event removed."
    else 
      e = Event.where(:id => params[:event][:id].to_i)
      e.first.name = params[:event][:name] unless params[:event][:name].empty?
      e.first.capacity = params[:event][:capacity].to_i unless params[:event][:capacity].empty?
      if e.first.save!
        flash[:message] = "Event successfully updated."
      else
        flash[:message] = "Error modifying event."
      end
    end
  end

  def export
    csv_data = CSV.generate do |csv|
      csv << %w(id last first event)
      User.all.collect {|u| [u.student_id, u.last, u.first, (u.event.nil? ? 'NONE' : u.event.name)]}.each {|u| csv << u}
    end
    send_data csv_data, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=eventreg.csv"
  end
end
