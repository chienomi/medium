class AddDurationsToEvangelists < ActiveRecord::Migration
  def change
  	add_column :evangelists, :yt_duration, :string, default: "05:25"
  end
end
