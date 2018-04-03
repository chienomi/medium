class AddMikusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :feeling, :float, default: 0.50
    add_column :users, :states, :text, default: "learning it"
  end
end
