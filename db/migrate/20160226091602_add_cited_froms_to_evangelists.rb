class AddCitedFromsToEvangelists < ActiveRecord::Migration
  def change
    add_column :evangelists, :cited_from, :text
  end
end
