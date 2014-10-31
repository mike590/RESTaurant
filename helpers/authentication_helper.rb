module Sinatra
  module AuthenticationHelper
    def authenticate!
      @current_user ||= session[:current_user]
    end
    def logout!
      session[:current_user] = nil
      @current_user = nil
    end
    def load_error!
      @error = session[:error]
    end
  end
end