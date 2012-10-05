ER::Application.routes.draw do
  get '/user/ready' => 'user#ready'
  get '/user/edit' => 'user#edit'
  get '/user/register' => 'user#register'
  get '/user/login' => 'user#login'
  get '/user/logout' => 'user#logout'
  post '/user/register' => 'user#register'
  post '/user/login' => 'user#login'
  post '/user/edit' => 'user#update'

  get '/event/review' => 'event#review'
  get '/event/admin' => 'event#admin'
  get '/event/export' => 'event#export'
  get '/event/edit' => 'event#edit_events'
  get '/event/users' => 'event#edit_users'
  post '/event/edit' => 'event#save_events'
  post '/event/edit_users' => 'event#save_users'

  root :to => 'user#login'
end
