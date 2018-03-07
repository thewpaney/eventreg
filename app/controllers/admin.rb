# See https://gist.github.com/coffeeaddict/2400427

require 'base64'

def authenticate_or_request_with_http_basic(user, pass, realm = 'Admin area')
  authenticate_with_http_basic(user, pass) || request_http_basic_authentication(realm)
end

def authenticate_with_http_basic(user, pass)
  if auth_str = request.env['HTTP_AUTHORIZATION']
    return Base64.decode64(auth_str.sub(/^Basic\s+/, '')) == [ user, pass ].join(":")
  end
end
  
def request_http_basic_authentication(realm = 'Application')
  response.headers["WWW-Authenticate"] = %Q(Basic realm="#{realm}")
  response.body = "HTTP Basic: Access denied.\n"
  response.status = 401
  return false
end

Events::App.controllers :admin, :provides => [:html,:json] do
  layout :application

  before do
    # HTTP basic auth
    halt(401, 'Not Authorized') unless authenticate_or_request_with_http_basic(ENV['ADMIN_NAME'], ENV['ADMIN_PASS'])
  end
  
  get :index do
    # admin#review
  end
  
  get :email do
    # admin#email
  end
  
  post :email do
    # admin#email
  end
  
  get :force_register do
    # admin#force_register
  end

  post :force_register do
    # admin#force_register
  end

  get :force, with: [:type, :id] do
    # admin#force
  end

  post :force, with: [:type, :id] do
    # admin#force
  end

  get :export do
    # admin#export
  end

  get :export_workshops do
    # admin#export_workshops
  end

end
