class AddPeriodsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :period, :string, default: "irregular"
    add_column :users, :message, :text, default: "Thanks :)"
  end
end
