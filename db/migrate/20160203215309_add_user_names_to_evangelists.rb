class AddUserNamesToEvangelists < ActiveRecord::Migration
  def change
    add_column :evangelists, :user_name, :string
  end
end
