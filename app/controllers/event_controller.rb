class EventController < ApplicationController
  def register
    if request.post?
      params[:event][:sessionid]
      redirect_to :controller => "user", :action => "login"
    end
  end
end
