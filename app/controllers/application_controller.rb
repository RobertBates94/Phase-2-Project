require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, "secrets"
    set :views, 'app/views'
    set :method_override, true
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

  get "/logout" do 
    session.clear
    redirect to "/"
  end 

  get "/createplaylist" do

    erb :createplaylist
  end

  post "/createplaylist" do
    @user = User.find_by_id(session[:user_id])
    @playlist = Playlist.new(params)
    @playlist.user_id = @user.id 
    if @playlist.save
      redirect "/home"
    else
      erb :createplaylist
    end
  end

  get "/home" do 
    @user = User.find_by_id(session[:user_id])

    erb:home
  end

  get "/playlist/:id" do
    @playlist = Playlist.find_by_id(params[:id])

    erb :playlist
  end
  

  post "/playlist/:id" do
    @playlist = Playlist.find_by_id(params[:id])
    
     erb '/playlist/:id'
  end

  get "/createsong/:id" do
    @playlist = Playlist.find_by_id(params[:id])

    erb :createsong
  end

  delete "/song/:id" do 
    @song = Song.find_by_id(params[:id])
    @song.delete

    redirect "/playlist/#{@song.playlist_id}"
  end

  get '/song/:id/edit' do
    @song = Song.find_by_id(params[:id])

    erb :editsong
  end

  patch '/song/:id/edit' do
    @song = Song.find_by_id(params[:id])
    @song.songname = params[:songname]
    @song.artistname = params[:artistname]
    @song.genre = params[:genre]
    @song.save

    redirect "/playlist/#{@song.playlist_id}"
  end

  delete '/playlist/:id' do 
    @playlist = Playlist.find_by_id(params[:id])
    @playlist.delete
    
    redirect '/home'
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

  post "/createsong/:id" do
   @playlist = Playlist.find_by_id(params[:id])
   @song = Song.create(songname:params[:songname], artistname:params[:artistname], genre:params[:genre])
    @song.playlist_id = @playlist.id
    if @song.save
      redirect "/playlist/#{@playlist.id}"
    else
      redirect "/playlist/#{@playlist.id}" 
    end
  end

end


