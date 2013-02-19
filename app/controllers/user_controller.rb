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

<<<<<<< HEAD
  def check_open
    if user.is_time?
      redirect_to action: 'register'
    else
      flash[:error] = "Registration is not yet open."
    end
  end

  def get_event
    @event = !params[:event].nil? && !params[:event][:id].nil? ? Event.where(id: params[:event][:id]).first : nil
  end

=======
>>>>>>> 00404ecc7678406be3ed10e5666e7997043a8dcc
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
    session[:user].signup params[:user][:first]
    session[:user].signup params[:user][:second]
    session[:user].signup params[:user][:third]    

  end

  def login
    self.authenticate! params[:user]
    if self.user?
      flash[:message]  = "You're logged in as #{session[:user].full}."
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
