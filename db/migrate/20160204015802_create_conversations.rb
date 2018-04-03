class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :time
      t.references :user, index: true, foreign_key: true
      t.string :user_name
      t.text :body
      t.references :evangelist, index: true, foreign_key: true
      t.integer :vote

      t.timestamps null: false
    end
  end
end
