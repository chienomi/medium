class AddAttachmentFilePatchToDemos < ActiveRecord::Migration
  def self.up
    change_table :demos do |t|
      t.attachment :file_patch
    end
  end

  def self.down
    remove_attachment :demos, :file_patch
  end
end
