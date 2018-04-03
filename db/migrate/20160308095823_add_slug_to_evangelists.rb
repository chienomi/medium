class AddSlugToEvangelists < ActiveRecord::Migration
  def change
    add_column :evangelists, :slug, :string
    add_index :evangelists, :slug
  end
end
