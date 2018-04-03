class AddPlaynextsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :playnext, :integer, array: true, default: []
    add_column :users, :playlist_now, :integer, default: 0
  end
end
