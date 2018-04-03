class AddParagraphsToConversations < ActiveRecord::Migration
  def change
  	add_column :conversations, :title, :text
    add_column :conversations, :paragraph, :text, unique: true
    add_column :conversations, :showside_num, :integer
    add_column :conversations, :like, :integer, default: 0
  end
end
