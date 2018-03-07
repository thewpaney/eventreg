Padrino.configure_apps do
  # enable :sessions
  set :session_secret, 'e79e5d0d483c1aeb1687067e6d2f02eef129ebb3c6049959205467e57734c782'
  set :protection, :except => :path_traversal
  set :protect_from_csrf, true
end

# Mounts the core application for this project
Padrino.mount('Events::App', :app_file => Padrino.root('app/app.rb')).to('/')

