class AddLikesToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :i_likes, :integer, default: 0, index: true
  end
end
