class CreateOnlineforms < ActiveRecord::Migration
  def change
    create_table :onlineforms do |t|
      t.text :title, default: ""
      t.text :body
      t.integer :disclose, default: 0
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
