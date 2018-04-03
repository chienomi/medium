class AddBatchesToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :stripe_1, :integer, default: 0
  	add_column :users, :stripe_2, :integer, default: 0
  	add_column :users, :stripe_3, :integer, default: 0
    add_column :users, :badge_circle, :integer, default: 0
    add_column :users, :badge_1, :integer, default: 0
    add_column :users, :badge_2, :integer, default: 0
    add_column :users, :badge_3, :integer, default: 0
    add_column :users, :badge_4, :integer, default: 0
    add_column :users, :badge_5, :integer, default: 0
  end
end
