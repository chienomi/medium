class AddAStrsToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :a_str, :text
  end
end
