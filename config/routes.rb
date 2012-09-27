ER::Application.routes.draw do
  get "user/ready"
  get "user/edit_sessions"
  get "user/login"
  get "user/logout"
  get "event/review"
  get "event/admin"
  get "event/export"
  get "event/edit_events"
  get "event/edit_users"
  
  post "user/register_event"
  post "user/login"
  post "user/edit_sessions"
  post "event/edit_events"
  post "event/edit_users"

  root :to => "user#login"
end
