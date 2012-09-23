class UserController < ApplicationController

  before_filter :login_required, :only=>['welcome', 'edit_sessions', 'hidden']

  @user = nil

  def login
    if request.post?
      session[:user] = User.authenticate(params[:user][:name], params[:user][:student_id])
      if not session[:user].nil?
        flash[:message]  = "You have successfully logged in as #{params[:user][:name]}."
        redirect_to :controller => "user", :action => "edit_sessions"
      else
        flash[:error] = "Login failed."
      end
    end
  end

  def edit_sessions
    if session[:user].nil?
      flash[:error] = "You must be logged in to edit your registered sessions."
      redirect_to :action => 'login'
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
      if params[:event][:sessionid] == "--Unregister--" # They clicked "--Unregister--" -- unregister if they're registered, do nothing otherwise.
        unless session[:user].event_id == 0
          # Clear session ID in database
          flash[:error] = "Cancelled registration for #{Event.find(:first, :conditions => ['id=?', session[:user].event_id]).name}."
          session[:user].event_id = 0
          session[:user].update_attribute(:event_id, 0)
        else
          flash[:error] = "You are not currently registered for an event."
        end
        redirect_to :controller => "user", :action => "edit_sessions"
        return
      elsif params[:event][:sessionid] == ""
        redirect_to :controller => "user", :action => "edit_sessions"
        return
      end # params empty SID check
      
      if Event.is_available?(params[:event][:sessionid])
        # first check to see if we're already registered for a session - if so, unregister
        if not session[:user].event.nil?
          # Clear session ID in database
          session[:user].event_id = 0
          flash[:error] = "Cancelled registration for #{Event.find(:first, :conditions=>['id=?', params[:event][:sessionid]]).name}."
          session[:user].update_attribute(:event_id, 0)
        end
        # now we can register!
        # update session data
        session[:user].event = Event.find(:first, :conditions=>["id=?", params[:event][:sessionid]])
        # save to users database
        session[:user].update_attribute("event_id", session[:user].event.id)
        flash[:message] = "Saved registration for #{Event.find(:first, :conditions=>['id=?', params[:event][:sessionid]]).name}."
        redirect_to :action => "edit_sessions"
      else
        flash[:error] = "No spots left for site: #{Event.find(:first, :conditions=>['id=?', params[:event][:sessionid]]).name}."
        redirect_to :controller => "user", :action => "edit_sessions"
      end # Event.is_available?
    end # request.post?
  end
  
  def hidden
    
  end
  
end
