class CreateMikutalks < ActiveRecord::Migration
  def change
    create_table :mikutalks do |t|
      t.references :user, index: true, foreign_key: true
      t.string :user_name, default: "Nanasi"
      t.text :body
      t.text :question
      t.text :keyword, array: true, default: []
      t.text :answear
      t.float :useful, default: 0.50
      t.text :waiting_for, default: ""
      t.text :waiting_word, array: true, default: []

      t.timestamps null: false
    end
  end
end
