class AddCUpdatedAtsToEvangelists < ActiveRecord::Migration
  def change
    add_column :evangelists, :c_updated_at, :datetime
  end
end
