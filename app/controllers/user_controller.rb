class UserController < ApplicationController

before_filter :login_required, :only=>['welcome', 'edit_sessions', 'hidden']

  def login
    if request.post?
      if session[:user] = User.authenticate(params[:user][:name], params[:user][:student_id])
        flash[:message]  = "You have successfully logged in as #{params[:user][:name]}."
        session[:user] = params[:user]
        redirect_to "/user/edit_sessions"
      else
        flash[:error] = "Login unsuccessful."
      end
    end
  end

  def edit_sessions
    unless session[:user]
      flash[:error] = "You must be logged in to edit your registered sessions."
      redirect_to :action => 'login'
    end
    if request.post?
      ActiveRecord::Base.connection.execute('REPLACE INTO Users (sessionid) VALUES (#{params[:user][:sessionid]})')
      flash[:message] = "Successfully saved registration for #{params[:user][:sessionid]}."
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

  def edit_sessions

  end
  
  def hidden
    
  end
  
end
