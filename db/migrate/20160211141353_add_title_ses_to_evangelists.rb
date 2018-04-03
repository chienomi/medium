class AddTitleSesToEvangelists < ActiveRecord::Migration
  def self.up
    add_column :evangelists, :title_s, :text
  end
  def self.down
    remove_column :evangelists, :title_s
  end
end
