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
  
  
end
