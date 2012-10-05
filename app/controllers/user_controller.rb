class UserController < ApplicationController
  before_filter :login_required!, only: [:edit_sessions, :ready]
  before_filter :check_open, only: :ready
  before_filter :get_event, only: :register
  before_filter :is_time?, only: :register

  POSITIVE_ENCOURAGEMENT = [
                            "That's all you have to do!"
                           ]

  NEGATIVE_ENCOURAGEMENT = [
                   "The one that got away!",
                   "Aww man!"
                   ]


  def check_open
    if is_time?
      redirect_to action: 'register'
    else
      flash[:error] = "Registration is not yet open."
    end
  end

  def get_event
    @event = !params[:event].nil? && !params[:event][:id].nil? ? Event.where(id: params[:event][:id]).first : nil
  end

  def is_time?
    !(g = user.registration).nil? && ((t = Time.now) - g[:open] > 0) && (t - g[:close] < 0)
  end

  def ready
    # silence is golden
  end

  def edit
    if !user?
      flash[:error] = "You must be logged in to register."
      redirect_to action: 'login'
    elsif !is_time?
      flash[:error] = "Registration hasn't opened yet!"
      redirect_to action: 'ready'
    end
  end

  def register
    return unless request.post?

    if @event.nil?
      flash[:error] = "Please pick an option."
    else
      if @event.available?
        self.user.update_attributes event: @event
        flash[:message] = "You're now registered for #{@event}! #{POSITIVE_ENCOURAGEMENT.sample}"
      else
        flash[:error] = "No spots left for #{@event}! #{NEGATIVE_ENCOURAGEMENT.sample}"
      end
    end
  end

  def login
    self.authenticate! params[:user]
    if self.user?
      flash[:message]  = "You are logged in as #{user.name}."
      redirect_to action: "ready"
    elsif request.post?
      flash[:error] = "Login failed."
    end
  end

  def logout
    unless user?
      self.deauthenticate!
      flash[:message] = 'Successfully logged out.'
    else
      flash[:error] = "You are not currently logged in!"
    end
    redirect_to action: 'login'
  end
end
