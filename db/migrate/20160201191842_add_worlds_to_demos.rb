class AddWorldsToDemos < ActiveRecord::Migration
  def change
    add_column :demos, :world, :text
  end
end
