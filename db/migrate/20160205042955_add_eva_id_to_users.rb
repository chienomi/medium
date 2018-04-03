class AddEvaIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :eva_id, :integer, default: 0
  end
end
