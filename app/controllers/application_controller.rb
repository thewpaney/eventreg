class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :user, :user?
  
  def user
    session[:user]
  end

  def user?
    !user.nil?
  end

  def authenticate! p
    session[:user] = Student.authenticate(p[:number].to_i, p[:prefix]) or Teacher.authenticate(p[:number].to_i, p[:prefix]) or nil
  end

  def deauthenticate!
    session[:user] = nil
  end

  def admin!
    authenticate_or_request_with_http_basic Rails.configuration.admin[:message] do |username, password|
      username == Rails.configuration.admin[:username] && password == Rails.configuration.admin[:password]
    end
  end

  def login_required!
    return true if user?
    flash[:error] = 'You must log in to continue.'
    redirect_to :controller => 'user', :action => 'login'
    false
  end
  
  def redirect_to_stored
    if return_to = session[:return_to]
      session[:return_to] = nil
      redirect_to_url(return_to)
    else
      redirect_to :controller => 'user', :action => 'welcome'
    end
  end
end
