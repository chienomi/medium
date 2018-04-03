class RemoveColumn < ActiveRecord::Migration
  def change
  	remove_column :users, :playnext, :integer
  	remove_column :users, :a_name, :string
  	remove_column :users, :repeat, :integer
  	remove_column :users, :badge_5, :integer
  	remove_column :users, :badge_4, :integer
  	remove_column :users, :badge_3, :integer
  	remove_column :users, :badge_2, :integer
  	remove_column :users, :badge_1, :integer
  	remove_column :users, :badge_circle, :integer
  	remove_column :users, :stripe_3, :integer
  	remove_column :users, :stripe_2, :integer
	  remove_column :users, :tachie, :string
  	remove_column :users, :feeling_i, :integer
  	remove_column :users, :states, :string
  	remove_column :users, :feeling, :integer
  end
end
