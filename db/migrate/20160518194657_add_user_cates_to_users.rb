class AddUserCatesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_cate, :integer, default: 99, index: true
  end
end
