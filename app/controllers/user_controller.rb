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

  def ajaxDescription
    @workshop = Workshop.find(params[:id].to_i)
    render :json => @workshop
  end
    
  def edit
    if !user
      flash[:error] = "You must be logged in to register."
      redirect_to action: 'login'
    end
  end

  def register
    if request.post?
      if Workshop.where(id: params[:user][:first]).first.name == Workshop.where(id: params[:user][:second]).first.name or Workshop.where(id: params[:user][:first]).first.name == Workshop.where(id: params[:user][:third]).first.name or Workshop.where(id: params[:user][:second]).first.name == Workshop.where(id: params[:user][:third]).first.name
        flash[:error] = "Two of your workshops were the same thing.  Please diversify and try again."
        return
      end
      
      unless Workshop.find(params[:user][:first]).canSignUp(self.user)
        flash[:error] = "Your first workshop is full!"
      end

      unless Workshop.find(params[:user][:second]).canSignUp(self.user)
        flash[:error] = "Your second workshop is full!"
      end

      unless Workshop.find(params[:user][:third]).canSignUp(self.user)
        flash[:error] = "Your third workshop is full!"
      end

      user.signup params[:user][:first]
      user.signup params[:user][:second]
      user.signup params[:user][:third]
      
    end
  end

  def login
    self.authenticate! params[:user]
    if self.user
      flash[:message]  = "You're logged in as #{user.full}."
      redirect_to action: "register"
    elsif request.post?
      flash[:error] = "Login failed."
    end
  end

  def logout
    if self.user
      self.deauthenticate!
      flash[:message] = 'Successfully logged out.'
      render :login    
    else
      flash[:error] = "You're not currently logged in!"
      render :login          
    end
  end
end
