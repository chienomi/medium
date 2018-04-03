class AddArrayBToUsers < ActiveRecord::Migration
  def change
    add_column :users, :array_b, :integer, array:true, default: []
  end
end
