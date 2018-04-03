class AddArrayLsToEvangelists < ActiveRecord::Migration
  def change
    add_column :evangelists, :array_l, :integer, array: true, default: []
  end
end
