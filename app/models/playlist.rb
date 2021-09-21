class Playlist < ActiveRecord::Base
    belongs_to :users
    has_many :songs
end