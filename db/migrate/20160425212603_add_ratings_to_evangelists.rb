class AddRatingsToEvangelists < ActiveRecord::Migration
  def change
    add_column :evangelists, :rating, :float, default: 0.0, index: true
  end
end
