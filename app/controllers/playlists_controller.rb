require './config/environment'
require 'pry'

class PlaylistsController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, "secrets"
    set :views, 'app/views'
  end

  get "/createplaylist" do

    erb :createplaylist
  end

  post "/createplaylist" do
    @user = User.find_by_id(session[:user_id])
    @playlist = Playlist.new(params)
    @playlist.user_id = @user.id 
    if @playlist.save
      erb :home
    else
      erb :createplaylist
    end
  end

    get "/playlist/:id" do
        @playlist = Playlist.find_by_id(params[:id])
    
        erb :playlist
    end
      
    
    post "/playlist/:id" do
        @playlist = Playlist.find_by_id(params[:id])
        
         erb '/playlist/:id'
    end

    delete '/playlist/:id' do 
        @playlist = Playlist.find_by_id(params[:id])
        @playlist.delete
        
        erb :home
    end
    
    get '/playlist/:id/edit' do
        @playlist = Playlist.find_by_id(params[:id])
    
        erb :editplaylist
    end
    
    patch '/playlist/:id/edit' do
        @playlist = Playlist.find_by_id(params[:id])
        @playlist.playlistname = params[:playlistname]
        @playlist.save
        
    
        redirect '/home'
    end

end
