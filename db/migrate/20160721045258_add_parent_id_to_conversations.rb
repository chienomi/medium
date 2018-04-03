class AddParentIdToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :parent_id, :integer
  end
end
