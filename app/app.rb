module Events
  class App < Padrino::Application
    use ConnectionPoolManagement
    register ScssInitializer
    register Padrino::Mailer
    register Padrino::Helpers
    register Sinatra::Flash
    enable :sessions

    def user
      User.find(session[:user_id])
    end
    
    # User needs to be authenticated 
    before :register do
      if session[:user_id] == nil
        flash[:error] = "You must log in before registering."
        redirect :login
      end
    end

    before :details do
      if session[:user_id] == nil
        flash[:error] = "You must log in to view your registration details."
        redirect :login
      end
    end
    
    get :browse do
      @firsts = Workshop.firsts.collect {|w| "#{w.name} (#{w.slimit} students, #{w.tlimit} teachers)"}
      @seconds = Workshop.seconds.collect {|w| "#{w.name} (#{w.slimit} students, #{w.tlimit} teachers)"}
      @thirds = Workshop.thirds.collect {|w| "#{w.name} (#{w.slimit} students, #{w.tlimit} teachers)"}
      render :browse
    end

    get :register do
      # user#register
      if user.done?
        redirect :details
      end
      @session = user.sessions_needed.min
      @availabilities = Workshop.available_for_from(user, @session).collect {|w| [w.name, w.id]}
      render :register
    end

    post :register do
      if params[:selection]
        workshop = Workshop.find(params[:selection])
        whynot = user.signup(params[:selection])
        if whynot == "Signed Up"
          flash[:notice] = "Signed up for #{workshop.name} in session #{workshop.session}."
        else
          flash[:error] = "Could not sign up for #{workshop.name} in session #{workshop.session}: #{whynot}"
        end
      else
        flash[:warn] = "Please make a selection."
      end
    end
    
    get :login do
      redirect :register if session[:user_id] != nil
      render :login
    end

    post :login do
      # params[:prefix]
      # params[:number]
      session[:user_id] = User.authenticate(params[:prefix], params[:number])
      if session[:user_id] == nil
        flash[:error] = "User email prefix and ID number did not match."
        redirect :login
      else
        flash[:notice] = "Logged in as #{params[:prefix]}"
        redirect :register
      end
    end
    
    get :logout do
      session[:user_id] = nil
      flash[:notice] = "Logged out."
      redirect :login
    end
    
    get :details do
      render :details
    end

    post :ajaxDescription do
      @workshop = Workshop.find(params[:id].to_i)
      render json: @workshop
    end
    
    # NO user#reset
    # NO user#force_register
    
    error 404 do
      render 'errors/404'
    end
    
    error 500 do
      render 'errors/500'
    end

    error 422 do
      render 'errors/422'
    end
    
  end
end
