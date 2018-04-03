class AddExtrasToEvangelists < ActiveRecord::Migration
  def change
  	add_column :evangelists, :extra, :text, default: ""
  end
end
