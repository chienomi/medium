class AddTitleSesToDemos < ActiveRecord::Migration
  def self.up
    add_column :demos, :title_s, :text
  end
  def self.down
  	remove_column :demos, :title_s
  end
end
