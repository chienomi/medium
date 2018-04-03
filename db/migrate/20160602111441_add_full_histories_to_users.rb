class AddFullHistoriesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :full_history, :integer, array: true, default: []
  end
end
