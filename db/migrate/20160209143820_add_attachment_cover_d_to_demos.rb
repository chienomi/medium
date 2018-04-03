class AddAttachmentCoverDToDemos < ActiveRecord::Migration
  def self.up
    change_table :demos do |t|
      t.attachment :cover_d
    end
  end

  def self.down
    remove_attachment :demos, :cover_d
  end
end
