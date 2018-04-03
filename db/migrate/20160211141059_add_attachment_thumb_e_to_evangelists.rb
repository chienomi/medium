class AddAttachmentThumbEToEvangelists < ActiveRecord::Migration
  def self.up
    change_table :evangelists do |t|
      t.attachment :thumb_e
    end
  end

  def self.down
    remove_attachment :evangelists, :thumb_e
  end
end
