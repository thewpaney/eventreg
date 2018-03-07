module Events
  class App < Padrino::Application
    use ConnectionPoolManagement
    register ScssInitializer
    register Padrino::Mailer
    register Padrino::Helpers
    register Sinatra::Flash
    enable :sessions

    # User needs to be authenticated 
    before :register do
      flash[:error] = "You must log in before registering."
    end

    before :details do
      
      flash[:error] = "You must log in to view your registration details."
    end
    
    get :browse do
      # user#browse
    end

    get :register do
      # user#register
    end

    post :register do
      # user#register
    end
    
    get :login do
      # user#login
    end

    post :login do
      # user#login
    end
    
    get :logout do
      # user#logout
    end
    
    get :details do
      # user#details
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
