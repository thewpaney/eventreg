class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery prepend: true
  
  # include ActionController::Caching::Pages
  # self.page_cache_directory = "#{Rails.root.to_s}/public/page_cache"
  helper_method :user
  
  def user
    if session[:type] == "student"
      Student.find(session[:user_id])
    elsif session[:type] == "teacher"
      Teacher.find(session[:user_id])
    else
      nil
    end
  end
  
  def authenticate! p
    return if p.nil?
    if Student.authenticate(p[:number].to_i, p[:prefix])
      session[:user_id] = Student.authenticate(p[:number].to_i, p[:prefix]).id
      session[:type] = "student"
    elsif Teacher.authenticate(p[:number].to_i, p[:prefix])
      session[:user_id] = Teacher.authenticate(p[:number].to_i, p[:prefix]).id
      session[:type] = "teacher"
    else
      session[:user_id] = nil
      session[:type] = nil
    end
  end
  
  def deauthenticate!
    session[:user_id] = nil
    session[:type] = nil
  end
  
  def admin!
    authenticate_or_request_with_http_basic Rails.configuration.admin[:message] do |username, password|
      username == Rails.configuration.admin[:username] && password == Rails.configuration.admin[:password]
    end
  end
  
  def login_required!
    return true if user
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
  
  def admin!
    authenticate_or_request_with_http_basic "Provide credentials to continue." do |username, password|
      username == "admin" && password == "ulysses2017"
    end
  end
  
end
