class AddYtsToEvangelists < ActiveRecord::Migration
  def change
    add_column :evangelists, :yt, :string
    add_column :evangelists, :yt_id, :string, index: true
    add_column :evangelists, :yt_img0, :string
    add_column :evangelists, :yt_img1, :string
    add_column :evangelists, :yt_img2, :string
    add_column :evangelists, :yt_img3, :string
  end
end
