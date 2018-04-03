class AddPosesToWords < ActiveRecord::Migration
  def change
    add_column :words, :pos, :string, default: "noun"
    add_column :words, :noun, :text
    add_column :words, :verb, :text
    add_column :words, :adj, :text
    add_column :words, :adv, :text
  end
end
