class PlaylistSong < ActiveRecord::Base
    has_many :playlists
    has_many :songs
end