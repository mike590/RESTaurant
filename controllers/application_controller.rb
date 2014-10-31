class ApplicationController < Sinatra::Base
  helpers Sinatra::FormHelper, Sinatra::LinkHelper, Sinatra::AuthenticationHelper
  require './connection'

  set :views, File.expand_path("../../views", __FILE__)
  set :public_folder, File.expand_path("../../public", __FILE__)

  enable :sessions, :method_override

  get '/' do
    @servers = Server.all
    @parties = Party.all
    @orders = Order.all
    authenticate!
    load_error!
    erb :index
  end

end