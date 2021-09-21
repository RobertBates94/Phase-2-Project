class Createplaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :playlistname
      t.integer :user_id
    end
  end
end
