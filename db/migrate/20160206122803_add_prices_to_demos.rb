class AddPricesToDemos < ActiveRecord::Migration
  def self.up
    add_column :demos, :price, :integer, default: 0
    add_column :demos, :pend, :integer, default: 0
  end

  def self.down
  	remove_column :demos, :price
    remove_column :demos, :pend
  end
end
