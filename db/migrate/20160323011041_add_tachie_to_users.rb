class AddTachieToUsers < ActiveRecord::Migration
  def change
    add_column :users, :feeling_i, :integer, default: 0
    add_column :users, :tachie, :string, default: "tachi_06"
  end
end
