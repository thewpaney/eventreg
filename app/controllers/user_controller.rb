class UserController < ApplicationController

  before_filter :login_required, :only => ['edit_sessions', 'ready']
  before_filter :check_open, :only => ['ready']
  before_filter :is_time?, :only => ['edit_sessions']

  def login
    session[:register_status] = 0
    if request.post?
      session[:user] = User.authenticate(params[:user][:name], params[:user][:student_id])
      if not session[:user].nil?
        flash[:message]  = "You have successfully logged in as #{params[:user][:name]}."
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
  
  def ready
    
  end

  def register_event
    if request.post?
      # if params[:event][:sessionid] == "--Unregister--" # They clicked "--Unregister--" -- unregister if they're registered, do nothing otherwise.
      #   unless session[:user].event_id.to_i == 0
      #     # Clear session ID in database
      #     flash[:error] = "Cancelled registration for #{Event.find(:first, :conditions => ['id=?', session[:user].event_id]).name}."
      #     session[:user].event = nil
      #     session[:user].event_id = "0"
      #     session[:user].update_attribute("event_id", "0")
      #     session[:user].save
      #   else
      #     flash[:error] = "You are not currently registered for an event."
      #   end
      #   redirect_to :controller => "user", :action => "edit_sessions"
      #   return
      if params[:event][:sessionid] == ""
        flash[:error] = "Please pick an option from the drop-down menu."
        redirect_to :controller => "user", :action => "edit_sessions"
        return
      end # params empty SID check
      
      if Event.is_available?(params[:event][:sessionid])
        # first check to see if we're already registered for a session - if so, unregister
        # if not session[:user].event_id == 0
        #   # Clear session ID in database
        #   flash[:error] = "Cancelled registration for #{Event.find(:first, :conditions=>['id=?', session[:user].event_id]).name}."
        #   session[:user].event_id = 0
        #   session[:user].save
        # end
        # now we can register!
        # update session data
        session[:user].event = Event.find(:first, :conditions=>["id=?", params[:event][:sessionid]])
        # save to users database
        session[:user].update_attribute("event_id", session[:user].event_id)
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
  
  def is_time_junior?
    junior_open = Time.utc(2012, 10, 17, 20, 0)
    junior_close = Time.utc(2012, 10, 19, 20, 0)
    return (Time.now - junior_open > 0) && (Time.now - junior_close < 0)
  end

  def is_time_senior?
    senior_open = Time.utc(2012, 10, 7, 20, 0)
    senior_close = Time.utc(2012, 10, 9, 20, 0)    
    return (Time.now - senior_open > 0) && (Time.now - senior_close < 0)
  end

  def is_time?
    is_time_senior? || is_time_junior?
  end

  def check_is_time?
    # For now, override.  Remove before flight!
    return true if is_time?
    flash[:error] = "Registration is not yet open."
    redirect_to :action => "ready"    
  end

  def check_open
    if is_time?
      redirect_to :action => "edit_sessions"
    else
      flash[:error] = "Registration is not yet open."
    end
  end
  
end
