class AddSmellsToWords < ActiveRecord::Migration
  def change
    add_column :words, :smell, :text, array: true, default: []
  end
end
