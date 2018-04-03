class AddWhatkindsToOnlineforms < ActiveRecord::Migration
  def change
    add_column :onlineforms, :whatkind, :integer, default: 0
  end
end
