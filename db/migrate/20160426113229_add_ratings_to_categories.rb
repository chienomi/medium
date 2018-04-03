class AddRatingsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :rating, :float, default: 0.0, index: true
  end
end
