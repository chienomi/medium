class AddAttachmentImageUserToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :image_user
    end
  end

  def self.down
    remove_attachment :users, :image_user
  end
end
