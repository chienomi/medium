class CreateEvangelists < ActiveRecord::Migration
  def change
    create_table :evangelists do |t|
      t.string :title
      t.text :post_short
      t.text :post
      t.references :user, index: true, foreign_key: true
      t.references :demo, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
