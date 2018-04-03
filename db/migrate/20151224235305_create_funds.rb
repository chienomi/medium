class CreateFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.references :demo, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
