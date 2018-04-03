class AddViewsToEvangelists < ActiveRecord::Migration
  def change
    add_column :evangelists, :views, :integer, default: 0
  end
end
