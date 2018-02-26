require 'csv'

class AdminController < ApplicationController
  # Yeah
  before_filter :admin!

  def review
    self.deauthenticate!
    @tboys = Teacher.boys
    @tboysall = @tboys.count
    @tboysdone = @tboys.select {|s| s.workshop_ids.count == 3}.count
    @tgirls = Teacher.girls
    @tgirlsall = @tgirls.count
    @tgirlsdone = @tgirls.select {|s| s.workshop_ids.count == 3}.count
    @tregistered = @tgirlsdone + @tboysdone
    @tall = @tboysall + @tgirlsall
    @sboys = Student.boys
    @sboysall = @sboys.count
    @sboysdone = @sboys.select {|s| s.workshop_ids.count == 3}.count
    @sgirls = Student.girls
    @sgirlsall = @sgirls.count
    @sgirlsdone = @sgirls.select {|s| s.workshop_ids.count == 3}.count
    @sall = @sboysall + @sgirlsall
    @sregistered = @sboysdone + @sgirlsdone
    @sproblems = (@sboys + @sgirls).collect {|s| s.workshop_ids.count != 0 and s.workshop_ids.count != 3}.delete_if {|a| !a}.count
    @tproblems = (@tboys + @tgirls).collect {|s| s.workshop_ids.count != 0 and s.workshop_ids.count != 3}.delete_if {|a| !a}.count
  end

  def export
    csv_data = CSV.generate do |csv|
      csv << %w(id full grade gender advisement advisement-teacher first second third)
      Student.all.collect {|u| [u.number, u.full, u.grade, u.gender, u.advisement == "0" ? "GD Cafeteria" : u.advisement, u.advisement_name, (u.first.nil? ? 'NONE' : "#{u.first.name} - #{u.first.room}"), (u.second.nil? ? 'NONE' : "#{u.second.name} - #{u.second.room}"), (u.third.nil? ? 'NONE' : "#{u.third.name} - #{u.third.room}")] }.each {|u| csv << u }
      Teacher.all.collect {|u| [u.number, u.name, 'N/A', 'N/A', 'N/A', 'N/A', (u.first.nil? ? 'NONE' : "#{u.first.name} - #{u.first.room}"), (u.second.nil? ? 'NONE' : "#{u.second.name} - #{u.second.room}"), (u.third.nil? ? 'NONE' : "#{u.third.name} - #{u.third.room}")]}.each {|u| csv << u}
    end
    send_data csv_data, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=diversity_log.csv"
  end

  def export_workshops
    csv_data = CSV.generate do |csv|
      csv << %w(workshop amount)
      Workshop.all.collect {|w| [w.name + " Session " + w.session.to_s, w.staken, w.slimit]}.each {|w| csv << w}
    end
    send_data csv_data, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=workshop_popularity.csv"
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
      puts "###{params[:name]}"
      if params[:rmfirst]
        user.unsignup(user.first)
      elsif params[:rmsecond]
        user.unsignup(user.second)
      elsif params[:rmthird]
        user.unsignup(user.third)
      end
    else
      params[:user] = {}
    end
  end

  def email
    if request.post?
      params[:email][:to].split(",").each do |recipient|
        if (! (trecord = Teacher.find_by_prefix(recipient)).nil? )
          # It's a teacher
          EventregMailer.custom_email(trecord, params[:email][:title], params[:email][:body].html_safe).deliver
        elsif (! (srecord = Student.find_by_prefix(recipient)).nil? )
          # It's a student
          EventregMailer.custom_email(srecord, params[:email][:title], params[:email][:body].html_safe).deliver
        elsif (recipient === "UNREGISTERED")
          Teacher.unregistered.each do |u|
            EventregMailer.custom_email(u, params[:email][:title], params[:email][:body].html_safe).deliver
          end
          Student.unregistered.each do |u|
            EventregMailer.custom_email(srecord, params[:email][:title], params[:email][:body].html_safe).deliver
          end
        elsif (recipient === "STUDENTS")
          Student.all.each do |s|
            EventregMailer.custom_email(s, params[:email][:title], params[:email][:body].html_safe).deliver
          end
        elsif (recipient === "TEACHERS")
          Teacher.all.each do |t|
            EventregMailer.custom_email(t, params[:email][:title], params[:email][:body].html_safe).deliver
          end
        elsif (recipient === "ALL")
          Teacher.all.each do |t|
            EventregMailer.custom_email(t, params[:email][:title], params[:email][:body].html_safe).deliver
          end
          Student.all.each do |s|
            EventregMailer.custom_email(s, params[:email][:title], params[:email][:body].html_safe).deliver
          end
        else
          flash[:error] = ( flash[:error].nil? ? "" : flash[:error] )  + "No record found: #{recipient}."
        end
        if (recipient === "STUDENTS" and !(recipient === "ALL"))
          EventregMailer.custom_email(Teacher.find_by_prefix("lglasscock"), params[:email][:title], params[:email][:body].html_safe).deliver
          EventregMailer.custom_email(Teacher.find_by_prefix("cvela"), params[:email][:title], params[:email][:body].html_safe).deliver
        end
      end
    end
  end

  def force
    # Don't check if params[:user] is populated - this is what broke removing students
    if request.post?
      # No parameters
      if params.nil?
        return
      end
      # Submitting form
      # Removing a workshop
      puts params[:rmfirst]
      puts params[:rmsecond]
      puts params[:rmthird]
      if params[:rmfirst]
        user.unsignup(user.first.id)
        flash[:message] = "Removed session"
        return
      elsif params[:rmsecond]
        user.unsignup(user.second.id)
        flash[:message] = "Removed session"
        return
      elsif params[:rmthird]
        user.unsignup(user.third.id)
        flash[:message] = "Removed session"
        return
      end
      # Adding workshops
      # If user clicked "submit" without anything selected
      if params[:user].nil?
        return
      end
      if params[:user][:first]
        unless (whynot = user.signup(params[:user][:first])) == "Signed up"
          workshop = Workshop.find(params[:user][:first])
          flash[:error] = "Could not sign up for Session #{workshop.session}:\n #{whynot} "
        end
      end
      
      if params[:user][:second]
        unless (whynot = user.signup(params[:user][:second])) == "Signed up"
          workshop = Workshop.find(params[:user][:second])
          flash[:error] = "Could not sign up for Session #{workshop.session}:\n #{whynot} "
        end
      end
      
      if params[:user][:third]
        unless (whynot = user.signup(params[:user][:third])) == "Signed up"
          workshop = Workshop.find(params[:user][:third])
          flash[:error] = "Could not sign up for Session #{workshop.session}:\n #{whynot} "
        end
      end
    else
      # Rendering form
      if (!(params[:type] === "student" or params[:type] === "teacher"))
        flash[:error] = "Bad user type #{params[:type]} - make it student or teacher."
        redirect_to '/admin'
      else
        session[:type] = params[:type]
        session[:user_id] = params[:id]
        if user.nil?
          flash[:error] = 'No user with id #{params[:id]} and type #{params[:type]} exists.'
          redirect_to '/admin'
        end
      end
    end
  end
  
end
