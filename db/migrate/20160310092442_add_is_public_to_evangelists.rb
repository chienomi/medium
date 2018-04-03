class AddIsPublicToEvangelists < ActiveRecord::Migration
  def change
    add_column :evangelists, :is_public, :boolean
  end
end
