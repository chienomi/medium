class AddPricesToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :price, :integer, index: true, default: 0
  	add_column :users, :paid, :integer, index: true, default: 0
  	add_column :users, :urls, :string, index: true
  end
end
