class CreateDemos < ActiveRecord::Migration
  def change
    create_table :demos do |t|
      t.string :title
      t.text :post_short
      t.text :post
      t.references :user, index: true, foreign_key: true
      t.string :user_name

      t.timestamps null: false
    end
  end
end
