class CreateMikus < ActiveRecord::Migration
  def change
    create_table :mikus do |t|
      t.float :feeling, default: 0.50
      t.text :states, default: "learning it"

      t.timestamps null: false
    end
  end
end
