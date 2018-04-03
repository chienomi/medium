class AddAttachmentCoverUToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :cover_u
    end
  end

  def self.down
    remove_attachment :users, :cover_u
  end
end
