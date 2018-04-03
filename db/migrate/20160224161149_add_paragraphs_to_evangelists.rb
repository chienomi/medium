class AddParagraphsToEvangelists < ActiveRecord::Migration
  def change
    add_column :evangelists, :paragraph1, :text
    add_column :evangelists, :paragraph2, :text
    add_column :evangelists, :paragraph3, :text
    add_column :evangelists, :paragraph4, :text
    add_column :evangelists, :paragraph5, :text
    add_column :evangelists, :paragraph6, :text
    add_column :evangelists, :paragraph7, :text
  end
end
