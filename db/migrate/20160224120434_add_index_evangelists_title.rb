class AddIndexEvangelistsTitle < ActiveRecord::Migration
  def change
  	add_index :evangelists, :title, unique: true
  end
end