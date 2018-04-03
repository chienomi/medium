class Changerails < ActiveRecord::Migration
  def change
  	change_column :evangelists, :yt_img0, :string, :default => 'https://i.graphnote.com/images/120/medium/pexels-photo-119685.jpeg?1471388976'
  end
end
