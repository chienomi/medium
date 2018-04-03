class AddCountsToEvangelists < ActiveRecord::Migration
  def change
    add_column :evangelists, :views_e, :integer, default: 0
    add_column :evangelists, :likes_e, :integer, default: 0
  end
end
