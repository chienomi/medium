class AddLocksToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :lock, :integer, default: 0
  end
end
