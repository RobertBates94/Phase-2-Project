require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, "secrets"
    set :views, 'app/views'
    #set :method_override, true
  end

  get "/" do 
  
    erb :login
  end

  post "/" do 
    @user = User.find_by(username: params[:username])
      if !!@user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        erb :home
      else   
        @error = "Sorry your username or password is incorrect, please try again."  
        erb :login
      end    
  end

end


