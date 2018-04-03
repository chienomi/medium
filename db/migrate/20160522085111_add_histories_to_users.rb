class AddHistoriesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :history, :integer, array: true, default: []
    add_column :users, :repeat, :integer, default: 0
  end
end
