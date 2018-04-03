class AddComeEToEvangelists < ActiveRecord::Migration
  def change
    add_column :evangelists, :come_e, :integer, default: 0
  end
end
