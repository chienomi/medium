class AddAbsToMikutalks < ActiveRecord::Migration
  def change
    add_column :mikutalks, :ab, :text, array: true, default: []
  end
end
