class CreateSpeaks < ActiveRecord::Migration
  def change
    create_table :speaks do |t|

      t.timestamps null: false
    end
  end
end
