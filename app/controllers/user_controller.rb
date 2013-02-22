class UserController < ApplicationController
  before_filter :login_required!, only: [:register, :ready]
  before_filter :edit, only: :register

  caches_page :login

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
<<<<<<< HEAD
      if Workshop.where(id: params[:user][:first]).first.name == Workshop.where(id: params[:user][:second]).first.name or Workshop.where(id: params[:user][:first]).first.name == Workshop.where(id: params[:user][:third]).first.name or Workshop.where(id: params[:user][:second]).first.name == Workshop.where(id: params[:user][:third]).first.name
        flash[:error] = "Two of your workshops were the same thing.  Please diversify and try again."
        return
      end
      if self.user.nil?
        flash[:message] = "You are nil!  Congratulations!  You broke the system!"
        return
      end
      unless Workshop.find(params[:user][:first]).canSignUp(self.user)
        flash[:error] = "Your first workshop is full!"
        return
      end

      unless Workshop.find(params[:user][:second]).canSignUp(self.user)
        flash[:error] = "Your second workshop is full!"
        return
      end
      
      unless Workshop.find(params[:user][:third]).canSignUp(self.user)
        flash[:error] = "Your third workshop is full!"
        return
      end

      user.signup params[:user][:first]
      user.signup params[:user][:second]
      user.signup params[:user][:third]
      
=======
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
>>>>>>> 4cc76c041b8a7cbda1dfb0ef6f62f7082110c868
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
end
