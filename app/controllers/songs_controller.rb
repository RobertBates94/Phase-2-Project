require './config/environment'
require 'pry'

class SongsController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, "secrets"
    set :views, 'app/views'
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