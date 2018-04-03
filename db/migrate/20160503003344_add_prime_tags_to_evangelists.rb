class AddPrimeTagsToEvangelists < ActiveRecord::Migration
  def change
    add_column :evangelists, :prime_tag, :string, default: ""
  end
end