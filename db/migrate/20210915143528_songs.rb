class Songs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :songname
      t.string :artistname
      t.string :genre
      t.integer :playlist_id
    end
  end
end
