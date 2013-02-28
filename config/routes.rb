ER::Application.routes.draw do
  get '/user/ready' => 'user#ready'
  get '/user/edit' => 'user#edit'
  get '/user/register' => 'user#register'
  match '/user/force_register' => 'user#force_register'  
  get '/user/login' => 'user#login'
  get '/user/logout' => 'user#logout'
  post '/user/register' => 'user#register'
  post '/user/login' => 'user#login'
  post '/user/edit' => 'user#update'
  get '/admin' => 'admin#review'
  get '/table' => 'user#table'
  get '/admin/export' => 'admin#export'
  get '/user/reset' => 'user#reset'
  
  match '/user/description/:id' => 'user#ajaxDescription'

  root :to => 'user#login'
end
