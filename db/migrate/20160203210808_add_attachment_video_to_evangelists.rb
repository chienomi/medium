class AddAttachmentVideoToEvangelists < ActiveRecord::Migration
  def self.up
    change_table :evangelists do |t|
      t.attachment :video
    end
  end

  def self.down
    remove_attachment :evangelists, :video
  end
end
