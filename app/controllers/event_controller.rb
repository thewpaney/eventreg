require 'fastercsv'

class EventController < ApplicationController
  before_filter :admin!, only: [:admin, :export]

  def review
    # silence is golden
  end

  def admin
    # silence is golden
  end

  def export
    csv_data = FCSV.generate do |csv|
      csv << %w(id name event)
      User.all.collect {|u| [u.id, u.name, (u.event.nil? ? 'NONE' : u.event.name)]}.each {|u| csv << u}
    end
    send_data csv_data, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=eventreg.csv"
  end

  def edit_event
  end
  
  def edit_users
  end

  def save_event
  end

  def save_users
  end
end
