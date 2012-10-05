class UserController < ApplicationController
  before_filter :login_required, :only => ['welcome', 'edit_sessions', 'hidden']

  def login
    session[:register_status] = 0
    if request.post?
      session[:user] = User.authenticate(params[:user][:name], params[:user][:student_id])
      if not session[:user].nil?
        flash[:message]  = "You have successfully logged in as #{session[:user].name}."
        redirect_to :controller => "user", :action => "ready"
      else
        flash[:error] = "Login failed."
      end
    end
  end

  def edit_sessions
    if session[:user].nil?
      flash[:error] = "You must be logged in to edit your registered sessions."
      redirect_to :action => 'login'
    elsif not is_time?
      flash[:error] = "Registration hasn't opened yet!"
      redirect_to :action => 'ready'
    end
  end

  def logout
    unless session[:user].nil?
      session[:user] = nil
      flash[:message] = 'Successfully logged out.'
      redirect_to :action => 'login'
    else
      flash[:error] = "You are not currently logged in!"
      redirect_to :action => 'login'
    end
  end
  
  def welcome
    
  end

  def register_event
    if request.post?
      if params[:event][:id].nil? || params[:event][:id].empty?
        flash[:error] = "Please pick an option from the drop-down menu."
        redirect_to :controller => "user", :action => "edit_sessions"
        return
      end

      if Event.is_available?(params[:event])
        session[:user].event = Event.where(:id => params[:event][:id])
        session[:user].save
        flash[:message] = "Saved registration for #{Event.find(:first, :conditions=>['id=?', params[:event][:sessionid]]).name}."
        session[:register_status] = 1
        redirect_to :action => "edit_sessions"
      else
        flash[:error] = "No spots left for site: #{Event.find(:first, :conditions=>['id=?', params[:event][:sessionid]]).name}."
        session[:register_status] = 2
        redirect_to :controller => "user", :action => "edit_sessions"
      end # Event.is_available?
    end # request.post?
  end
  
  def is_time?
    return true
    t = Time.new
    if (t.year >= 2012 and t.day >= 28 and t.hour >= 5) and (t.year < 2013 and t.day < 4 and (t.month == 5 or t.month == 6))# or (session[:user].name == "admin")
      return true
    end
    return false
    
  end
  
end
