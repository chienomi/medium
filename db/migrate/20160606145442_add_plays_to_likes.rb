class AddPlaysToLikes < ActiveRecord::Migration
  def change
    add_reference :likes, :playlist, index: true, foreign_key: true
  end
end
