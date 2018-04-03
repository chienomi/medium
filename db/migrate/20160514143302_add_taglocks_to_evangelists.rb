class AddTaglocksToEvangelists < ActiveRecord::Migration
  def change
  	add_column :evangelists, :taglock, :integer, default: 0
  end
end
