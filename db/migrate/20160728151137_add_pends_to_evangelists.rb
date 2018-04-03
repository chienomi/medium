class AddPendsToEvangelists < ActiveRecord::Migration
  def change
    add_column :evangelists, :pend, :integer, default: 0
    add_column :evangelists, :bought, :integer, default: 0
  end
end
