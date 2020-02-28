Eventreg::Application.routes.draw do
  get '/user/browse' => 'user#browse'
  get '/user/register' => 'user#register'
  get '/user/login' => 'user#login'
  get '/user/logout' => 'user#logout'
#  get '/user/force_register' => 'user#force_register'
#  post '/user/force_register' => 'user#force_register'
  post '/user/register' => 'user#register'
  post '/user/login' => 'user#login'
#  get '/user/reset' => 'user#reset'
  get '/user/details' => 'user#details'
  
  get '/admin' => 'admin#review'
#  get '/admin/email' => 'admin#email'
#  post '/admin/email' => 'admin#email'
#  get '/admin/force_register' => 'admin#force_register'  
#  post '/admin/force_register' => 'admin#force_register'  
  get '/admin/force/:type/:id' => 'admin#force'
  post '/admin/force/:type/:id' => 'admin#force'
  get '/admin/export' => 'admin#export'
  get '/admin/export_workshops' => 'admin#export_workshops'
  
  match '/user/description/:id' => 'user#ajaxDescription', :via => [:post]

  root :to => 'user#login'

  get '/errors/file_not_found'
  get '/errors/unprocessable'
  get '/errors/internal_server_error'

  match '/404', to: 'errors#file_not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
