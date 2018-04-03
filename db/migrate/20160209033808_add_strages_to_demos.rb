class AddStragesToDemos < ActiveRecord::Migration
  def self.up
    add_column :demos, :strage_m, :text
    add_column :demos, :strage_r, :text
    add_column :demos, :cpu_m, :text
    add_column :demos, :cpu_r, :text
  end

  def self.down
  	remove_column :demos, :strage_m
    remove_column :demos, :strage_r
    remove_column :demos, :cpu_m
    remove_column :demos, :cpu_r
  end
end
