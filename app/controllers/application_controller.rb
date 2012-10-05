class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def login_required
    unless session[:user].nil?
      return true
    end
    flash[:error]='You must log in to continue.'
    redirect_to :controller => "user", :action => "login"
    false 
  end
  
  def current_user
    session[:user]
  end
  
  def redirect_to_stored
    if return_to = session[:return_to]
      session[:return_to]=nil
      redirect_to_url(return_to)
    else
      redirect_to :controller=>'user', :action=>'welcome'
    end
  end
end
