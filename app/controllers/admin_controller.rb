require 'csv'

class AdminController < ApplicationController
  # Yeah
  before_filter :admin!

  def export
    csv_data = CSV.generate do |csv|
      csv << %w(id full grade gender advisement first second third)
      Student.all.collect {|u| [u.number, u.full, u.grade, u.gender, u.advisement, (u.first.nil? ? 'NONE' : u.first.name), (u.second.nil? ? 'NONE' : u.second.name), (u.third.nil? ? 'NONE' : u.third.name)]}.each {|u| csv << u}
      Teacher.all.collect {|u| [u.number, u.name, 'N/A', 'N/A', 'N/A', (u.first.nil? ? 'NONE' : u.first.name), (u.second.nil? ? 'NONE' : u.second.name), (u.third.nil? ? 'NONE' : u.third.name)]}.each {|u| csv << u}
    end
    send_data csv_data, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=diversity_log.csv"
  end

  def force_register
    if request.get?
      if user.class == "Teacher"
        user.workshops.each {|w| w.tlimit = (w.tlimit.to_i - 1).to_s}
      else
        user.workshops.each {|w| w.slimit = (w.slimit.to_i - 1).to_s}
      end
      user.workshops.clear
    end
    if request.post?
      if params[:user][:first]
        user.force(params[:user][:first])
      end
      if params[:user][:second]
        user.force(params[:user][:second])
      end
      if params[:user][:third]
        user.force(params[:user][:third])
      end
    else
      params[:user] = {}
    end
  end

end
