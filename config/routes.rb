Eventreg::Application.routes.draw do
  get '/user/ready' => 'user#ready'
  get '/user/edit' => 'user#edit'
  get '/user/register' => 'user#register'
  get '/user/force_register' => 'user#force_register'  
  get '/user/login' => 'user#login'
  get '/user/logout' => 'user#logout'
  post '/user/register' => 'user#register'
  post '/user/login' => 'user#login'
  post '/user/edit' => 'user#update'
  get '/admin/export' => 'admin#export'
  get '/user/reset' => 'user#reset'
  
  get '/admin' => 'admin#review'
  get '/admin/email' => 'admin#email'
  post '/admin/email' => 'admin#email'

  match '/user/description/:id' => 'user#ajaxDescription', :via => [:post]

  root :to => 'user#login'
end
