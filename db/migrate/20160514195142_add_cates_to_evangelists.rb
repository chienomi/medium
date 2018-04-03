class AddCatesToEvangelists < ActiveRecord::Migration
  def change
    add_column :evangelists, :cate, :integer, default: 0, index: true
  end
end
