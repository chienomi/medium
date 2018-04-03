class AddAStrsToEvangelists < ActiveRecord::Migration
  def change
    add_column :evangelists, :a_str, :integer, array: true, default: []
  end
end
