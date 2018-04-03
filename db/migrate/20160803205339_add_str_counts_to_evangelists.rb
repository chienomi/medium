class AddStrCountsToEvangelists < ActiveRecord::Migration
  def change
    add_column :evangelists, :str_count, :integer, default: 1
  end
end
