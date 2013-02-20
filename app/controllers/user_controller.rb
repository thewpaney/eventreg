class UserController < ApplicationController
  before_filter :login_required!, only: [:register, :ready]
  before_filter :edit, only: :register

  caches_page :login

  POSITIVE_ENCOURAGEMENT = [
                            "That's all you have to do!",
                            "You're done!",
                            "That's it! Seriously!",
                            "Congratulations!",
                            "You're registered!",
                            "You got in!",
                            "It'll be a blast!",
                            "Oppa Regis style!"
                           ]

  NEGATIVE_ENCOURAGEMENT = [
                            "The one that got away!",
                            "Aww man!",
                            "Hope you had a backup!",
                            "Try again!",
                            "Nope!",
                            ":(",
                           ]

  def register
    return unless request.post?
    session[:user].first
  end

  def ready
    # silence is golden
  end

  def edit
    if !user?
      flash[:error] = "You must be logged in to register."
      redirect_to action: 'login'
    end
  end

  def register
    
  end

  def login
    self.authenticate! params[:user]
    if self.user?
      if self.user.class == Student
        flash[:message]  = "You're logged in as #{session[:user].full}."
      else
        flash[:message]  = "You're logged in as #{session[:user].prefix}."
      end
        redirect_to action: "register"
    elsif request.post?
      flash[:error] = "Login failed."
    end
  end

  def logout
    if self.user?
      self.deauthenticate!
      flash[:message] = 'Successfully logged out.'
    else
      flash[:error] = "You're not currently logged in!"
    end
    redirect_to action: :login
  end
end
