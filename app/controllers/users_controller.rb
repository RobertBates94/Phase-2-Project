require './config/environment'
require 'pry'

class UsersController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, "secrets"
    set :views, 'app/views'
  end

  # get "/" do

  #   erb :login
  # end

  # post "/" do 
  #   @user = User.find_by(username: params[:username])
  #     if !!@user && @user.authenticate(params[:password])
  #       session[:user_id] = @user.id
  #       erb :home
  #     else   
  #       @error = "Sorry your username or password is incorrect, please try again."  
  #       erb :login
  #     end    
  # end


    get "/signup" do

        erb :signup
    end

    post "/signup" do
    @user = User.new(params)
    if @user.save
        session[:user_id] = @user.id

        redirect "/home"
    else
        @error = @user.errors.full_messages
        erb :'/signup'
    end
    end

    get "/home" do 
    @user = User.find_by_id(session[:user_id])

    erb:home
    end

    get "/logout" do 
    session.clear
    redirect to "/"
    end 

end

  