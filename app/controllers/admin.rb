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
  enable :sessions
  layout :application

  before do
    # HTTP basic auth
    halt(401, 'Not Authorized') unless authenticate_or_request_with_http_basic(ENV['ADMIN_NAME'], ENV['ADMIN_PASS'])
  end
  
  get :index do
    # admin#review
    # user groupings
    session[:user_id] = nil
    @tboys  = User.where(role: "teacher", division: "BD")
    @tgirls = User.where(role: "teacher", division: "GD")
    @sboys  = User.where(role: "student", division: "BD")
    @sgirls = User.where(role: "student", division: "GD")
    # teacher statistics
    @tboysall   = @tboys.count
    @tboysdone  = @tboys.select {|s| s.done? }.count
    @tgirlsall  = @tgirls.count
    @tgirlsdone = @tgirls.select {|s| s.done? }.count
    @tall = @tboysall + @tgirlsall
    @tregistered = @tgirlsdone + @tboysdone
    @tUnfinished = @tall - @tregistered
    # student statistics
    @sboysall   = @sboys.count
    @sboysdone  = @sboys.select {|s| s.done? }.count
    @sgirlsall  = @sgirls.count
    @sgirlsdone = @sgirls.select {|s| s.done? }.count
    @sall = @sboysall + @sgirlsall
    @sregistered = @sgirlsdone + @sboysdone
    @sUnfinished = @sall - @sregistered
    render :review
  end
  
  get :email do
    # admin#email
    # TODO
  end
  
  post :email do
    # admin#email
    # TODO
  end

  get :force, with: :id do
    # admin#force
    session[:user_id] = params[:id]
    if user.nil?
      flash[:error] = "No user with id #{params[:id]} and type #{params[:type]} exists."
      redirect :index
    end
    render :force
  end
  
  post :force, with: :id do
    # admin#force and admin#force_register combo
    return if params.nil?
    user.force(params[:first]) if params[:first]
    user.force(params[:second]) if params[:second]
    user.force(params[:third]) if params[:third]
    user.unsignup(user.first) and flash[:notice] = "Removed session 1" if params[:rmfirst]
    user.unsignup(user.second) and flash[:notice] = "Removed session 2" if params[:rmsecond]
    user.unsignup(user.third) and flash[:notice] = "Removed session 3" if params[:rmthird]
    redirect :force, with: :id
  end

  get :export do
    # admin#export
  end

  get :export_workshops do
    # admin#export_workshops
  end

end
