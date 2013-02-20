ER::Application.routes.draw do
  get '/user/ready' => 'user#ready'
  get '/user/edit' => 'user#edit'
  get '/user/register' => 'user#register'
  get '/user/login' => 'user#login'
  get '/user/logout' => 'user#logout'
  post '/user/register' => 'user#register'
  post '/user/login' => 'user#login'
  post '/user/edit' => 'user#update'

  get '/event/admin' => 'event#admin'
  get '/event/review' => 'event#review'
  get '/event/export' => 'event#export'
  get '/event/edit_events' => 'event#edit_events'
  get '/event/edit_users' => 'event#edit_users'
  post '/event/edit_events' => 'event#edit_events'
  post '/event/edit_users' => 'event#edit_users'

  match '/user/description/:id' => 'user#ajaxDescription'

  root :to => 'user#login'
end
