class AddAnamesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :a_name, :string
  end
end
