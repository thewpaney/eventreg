class UserController < ApplicationController

before_filter :login_required, :only=>['welcome', 'edit_sessions', 'hidden']

  def login
    if request.post?
      if User.authenticate(params[:user][:name], params[:user][:student_id])
        flash[:message]  = "You have successfully logged in as #{params[:user][:name]}."
        session[:user] = params[:user]
        session[:user][:event] = Event.find(:first, :conditions=>["id=?", User.find(:first, :conditions=>["id=? AND name=?", params[:user][:student_id], params[:user][:name]]).sessionid])
        redirect_to "/user/edit_sessions"
      else
        flash[:error] = "Login unsuccessful."
      end
    end
  end

  def edit_sessions
    if session[:user].nil?
      flash[:error] = "You must be logged in to edit your registered sessions."
      redirect_to :action => 'login'
    end
    if request.post?
      ActiveRecord::Base.connection.execute('REPLACE INTO Users (sessionid) VALUES (#{params[:user][:sessionid]})')
      flash[:message] = "Saved registration for #{params[:user][:sessionid]}."
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
        unless session[:user][:event].nil?
          Event.unregister_event(session[:user][:event].id)
          # Clear session ID in database
          ActiveRecord::Base.connection.execute("UPDATE Users SET sessionid=0 WHERE id=#{session[:user][:student_id]}")
          flash[:error] = "Cancelled registration for #{session[:user][:event].name}."
          session[:user][:event] = nil
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
        if not session[:user][:event].nil?
          Event.unregister_event(session[:user][:event].id)
          # Clear session ID in database
          ActiveRecord::Base.connection.execute("UPDATE Users SET sessionid=0 WHERE id=#{session[:user][:student_id]}")
          flash[:error] = "Cancelled registration for #{session[:user][:event].name}."
          session[:user][:event] = nil
        end
        # now we can register!
        Event.register_event(params[:event][:sessionid])
        # update session data
        session[:user][:event] = Event.find(:first, :conditions=>["id=?", params[:event][:sessionid]])
        # save to users database
        ActiveRecord::Base.connection.execute("UPDATE Users SET sessionid=(#{params[:event][:sessionid]}) WHERE id=#{session[:user][:student_id]}")
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
