class AddPlaylistsToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :playlist_num, :integer, index: true, default: 0
    add_column :likes, :playorder, :integer, index: true, default: 0
  end
end
