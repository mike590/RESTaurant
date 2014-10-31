class SessionsController < ApplicationController
  
  post '/' do
    test_server = Server.find(params[:server_id].to_i)
    if test_server.password == params[:password]
      session[:current_user] = test_server
      session[:error] = nil
      
      redirect '/'
    else
      session[:error] = "Incorrect Password"
      redirect '/'
    end
  end

  get '/register' do
    erb :'server/register'
  end

  post '/register' do
    new_server = Server.create(params[:server])
    if new_server.valid?
      session[:current_user] = new_server
      redirect '/'
    else
      @errors = new_server.errors.full_messages
      erb :'serverregister'
    end
  end

  post '/destroy' do
    logout!
    redirect '/'
  end
end