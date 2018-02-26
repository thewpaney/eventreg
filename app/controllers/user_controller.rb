class UserController < ApplicationController
  before_filter :login_required!, only: [:register, :ready, :force_register, :details, :reset]
  before_filter :admin!, only: [:force_register, :reset]
  before_filter :edit, only: :register

  caches_page :login

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

  def browse
    if user.class == Student
      @firsts = Workshop.firsts.collect {|w| ["#{w.name} [#{w.staken}/#{w.slimit}]", w.id] }
      @seconds = Workshop.seconds.collect {|w| ["#{w.name} [#{w.staken}/#{w.slimit}]", w.id] }
      @thirds = Workshop.thirds.collect {|w| ["#{w.name} [#{w.staken}/#{w.slimit}]", w.id] }
    elsif user.Class == Teacher
      @firsts = Workshop.firsts.collect {|w| ["#{w.name} [#{w.ttaken}/#{w.tlimit}]", w.id] }
      @seconds = Workshop.seconds.collect {|w| ["#{w.name} [#{w.ttaken}/#{w.tlimit}]", w.id] }
      @thirds = Workshop.thirds.collect {|w| ["#{w.name} [#{w.ttaken}/#{w.tlimit}]", w.id] }
    end
    firsts = {} if (@firsts.nil?)
    seconds = {} if (@seconds.nil?)
    thirds = {} if (@thirds.nil?)
  end

  def register
    if self.user.finished_with_registration? #No sessions left or no options in sessions left
      redirect_to action: 'details'
    end
    @session = self.user.sessions_needed.min
    @availabilities = Workshop.available_for_from(self.user, @session).collect {|w| [w.name, w.id] }
    if request.post? and !(params[:user].nil?)
      if params[:user][:selection]
        workshop = Workshop.find(params[:user][:selection])
        if (whynot = user.signup(params[:user][:selection])) == "Signed up"
	  flash[:confirmation] = "Signup for #{workshop.name} Succesful"
          redirect_to action: 'register'
        else
          flash[:confirmation] = "Could not sign up for Session #{workshop.session}:\n #{whynot} "
        end
      end
    else
      params[:user] = {}
    end
  end

  def force_register
    if request.post?
      if params[:user][:first]
        user.force(params[:user][:first])
      end
      if params[:user][:second]
        user.force(params[:user][:second])
      end
      if params[:user][:third]
        user.force(params[:user][:third])
      end
    else
      params[:user] = {}
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

  def details
    # Nothing to be done here
  end

  private

  def user_params
    params.permid(:login, :pass, :pass_confirm)
  end
end 
