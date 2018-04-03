class AddDetailsToDemos < ActiveRecord::Migration
  def change
    add_column :demos, :story, :text
    add_column :demos, :os, :text
    add_column :demos, :audio, :text
    add_column :demos, :subtitle, :text
    add_column :demos, :res_m, :text
    add_column :demos, :mem_m, :text
    add_column :demos, :res_r, :text
    add_column :demos, :mem_r, :text
  end
end
