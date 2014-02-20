class UserController < ApplicationController
  before_filter :login_required!, only: [:register, :ready, :force_register]
  before_filter :admin!, only: :force_register
  before_filter :edit, only: :register

  # caches_page :login

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

  # THIS CODE IS BAD AND WE SHOULD FEEL BAD
  # def force_register
  #   if request.get?
  #     if user.class == "Teacher"
  #       user.workshops.each {|w| w.tlimit = (w.tlimit.to_i - 1).to_s}
  #     else
  #       user.workshops.each {|w| w.slimit = (w.slimit.to_i - 1).to_s}
  #     end
  #     user.workshops.clear
  #   end
  #   if request.post?
  #     if params[:user][:first]
  #       user.force(params[:user][:first])
  #     end
  #     if params[:user][:second]
  #       user.force(params[:user][:second])
  #     end
  #     if params[:user][:third]
  #       user.force(params[:user][:third])
  #     end
  #   else
  #     params[:user] = {}
  #   end
  # end
  
  def register
    if request.post?
      if params[:user][:first]
        unless (whynot = user.signup(params[:user][:first])) == "Signed up"
          workshop = Workshop.find(params[:user][:first])
          flash[:error] = "Could not sign up for Session #{workshop.session}:\n #{whynot} "
        end
      end

      if params[:user][:second]
        unless (whynot = user.signup(params[:user][:second])) == "Signed up"
          workshop = Workshop.find(params[:user][:second])
          flash[:error] = "Could not sign up for Session #{workshop.session}:\n #{whynot} "
        end
      end

      if params[:user][:third]
        unless (whynot = user.signup(params[:user][:third])) == "Signed up"
          workshop = Workshop.find(params[:user][:third])
          flash[:error] = "Could not sign up for Session #{workshop.session}:\n #{whynot} "
        end
      end
    else
      params[:user] = {}
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
      redirect_to "/user/login"
    else
      flash[:error] = "You're not currently logged in!"
      redirect_to "/user/login"   
    end
  end

  def reset
    if self.user.workshops != []
      self.user.workshops.each do |w|
        w.ttaken = (w.ttaken.to_i - 1).to_s
        w.save!
      end
      self.user.workshops.clear
    end
    redirect_to "/user/register"
  end
end
