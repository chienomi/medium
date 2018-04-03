class AddR18sToEvangelists < ActiveRecord::Migration
  def change
    add_column :evangelists, :r18, :integer, default: 0
  end
end
