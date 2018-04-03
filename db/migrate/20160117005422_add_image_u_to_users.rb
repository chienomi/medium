class AddImageUToUsers < ActiveRecord::Migration
  def change
    add_column :users, :image_u_id, :string
    add_column :users, :image_u_size, :integer
  end
end
