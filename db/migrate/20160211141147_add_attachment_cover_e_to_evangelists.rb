class AddAttachmentCoverEToEvangelists < ActiveRecord::Migration
  def self.up
    change_table :evangelists do |t|
      t.attachment :cover_e
    end
  end

  def self.down
    remove_attachment :evangelists, :cover_e
  end
end
