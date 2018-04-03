class CreatePlayseeds < ActiveRecord::Migration
  def change
    create_table :playseeds do |t|
      t.references :user, index: true, foreign_key: true
      t.references :playlist, index: true, foreign_key: true
      t.integer :listorder

      t.timestamps null: false
    end
  end
end
