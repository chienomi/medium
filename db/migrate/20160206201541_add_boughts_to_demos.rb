class AddBoughtsToDemos < ActiveRecord::Migration
  def self.up
    add_column :demos, :bought, :integer, default: 0
    add_column :demos, :bought_us, :integer, default: 0
    add_column :demos, :bought_jp, :integer, default: 0
  end

  def self.down
  	remove_column :demos, :bought
    remove_column :demos, :bought_us
    remove_column :demos, :bought_jp
  end
end
